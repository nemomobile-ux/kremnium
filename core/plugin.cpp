/*
 * Copyright (C) 2025 Chupligin Sergey <neochapay@gmail.com>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public License
 * along with this library; see the file COPYING.LIB.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301, USA.
 */

#include "plugin.h"
#include "declarativepagestatus.h"
#include "declarativepagestackaction.h"
#include "declarativedock.h"
#include "declarativetouchinteraction.h"
#include "declarativefocusbehavior.h"
#include "declarativetexteditor.h"
#include "declarativetruncationmode.h"
#include "declarativewindow.h"
#include "kremniumtheme.h"
#include "silicascreen.h"
#include "silicaorientation.h"
#include "silicacover.h"
#include "silicaformat.h"
#include "silicabusyindicatorsize.h"
#include "buttonlayoutattached.h"
#include "declarativebuttonlayout.h"
#include "declarativeregexpvalidator.h"
#include "declarativenotice.h"
#include "enterkeyattached.h"
#include "themeimageprovider.h"
#include <QtQml>
#include <QScreen>
#include <QQuickWindow>
#include <QQuickItem>
#include <QTimer>
#include <QGuiApplication>
#include <QCoreApplication>
#include <QEvent>
#include <QPointer>

class ThemeEffectStub : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int effect READ effect WRITE setEffect NOTIFY effectChanged)
public:
    enum Effect {
        Press = 0, Release, PressWeak, ReleaseWeak, PressStrong, ReleaseStrong,
        DragStart, DragDropInZone, DragDropOutOfZone, DragCrossBoundary, Appear
    };
    Q_ENUM(Effect)
    explicit ThemeEffectStub(QObject *parent = nullptr) : QObject(parent) {}
    int effect() const { return m_effect; }
    void setEffect(int e) { if (m_effect == e) return; m_effect = e; emit effectChanged(); }
    Q_INVOKABLE void play() {}
    Q_INVOKABLE bool supported() { return false; }
signals:
    void effectChanged();
private:
    int m_effect = 0;
};

void QQuickKremniumControlsExtensionPlugin::registerTypes(const char* uri)
{
    Q_ASSERT(uri == QLatin1String("Sailfish.Silica"));
    qmlRegisterModule(uri, 1, 0);
    qmlRegisterUncreatableMetaObject(SilicaOrientation::staticMetaObject, uri, 1, 0, "Orientation", "Not creatable as it is an enum type");
    qmlRegisterUncreatableMetaObject(SilicaCover::staticMetaObject, uri, 1, 0, "Cover", "Not creatable as it is an enum type");
    qmlRegisterUncreatableMetaObject(SilicaBusyIndicatorSize::staticMetaObject, uri, 1, 0, "BusyIndicatorSize", "Not creatable as it is an enum type");
    qmlRegisterUncreatableMetaObject(DeclarativePageStackAction::staticMetaObject, uri, 1, 0, "PageStackAction", "Not creatable as it is an enum type");
    qmlRegisterUncreatableMetaObject(DeclarativeDock::staticMetaObject, uri, 1, 0, "Dock", "Not creatable as it is an enum type");
    qmlRegisterUncreatableMetaObject(DeclarativeTouchInteraction::staticMetaObject, uri, 1, 0, "TouchInteraction", "Not creatable as it is an enum type");
    qmlRegisterUncreatableMetaObject(DeclarativeFocusBehavior::staticMetaObject, uri, 1, 0, "FocusBehavior", "Not creatable as it is an enum type");
    qmlRegisterUncreatableMetaObject(DeclarativeTextEditor::staticMetaObject, uri, 1, 0, "TextEditor", "Not creatable as it is an enum type");
    qmlRegisterUncreatableType<DeclarativePageStatus>(uri, 1, 0, "PageStatus", "Not creatable as it is an enum type");
    qmlRegisterUncreatableType<DeclarativeTruncationMode>(uri, 1, 0, "TruncationMode", "Not creatable as it is an enum type");
    qmlRegisterUncreatableType<EnterKey>(uri, 1, 0, "EnterKey", "EnterKey is an attached property");
    qmlRegisterType<DeclarativeButtonLayout>(uri, 1, 0, "ButtonLayout");
    qmlRegisterType<DeclarativeRegExpValidator>(uri, 1, 0, "RegExpValidator");
    qmlRegisterType<DeclarativeNotice>(uri, 1, 0, "Notice");

    qmlRegisterType<DeclarativeWindow>(uri, 1, 0, "KremniumWindow");
    qmlRegisterSingletonType<SilicaScreen>(uri, 1, 0, "Screen", [](QQmlEngine *engine, QJSEngine *) -> QObject * {
        return new SilicaScreen(engine);
    });
    qmlRegisterSingletonType<SilicaFormat>(uri, 1, 0, "Format", [](QQmlEngine *engine, QJSEngine *) -> QObject * {
        return new SilicaFormat(engine);
    });
}

static QObject *findSilicaApplicationWindow(QObject *obj)
{
    if (!obj) return nullptr;
    if (obj->property("pageStack").isValid() && obj->property("allowedOrientations").isValid())
        return obj;
    for (QObject *child : obj->children()) {
        if (QObject *found = findSilicaApplicationWindow(child))
            return found;
    }
    return nullptr;
}

class AppWindowWatcher : public QObject
{
public:
    AppWindowWatcher(QQmlEngine *engine, QObject *parent) : QObject(parent), m_engine(engine) {}
    bool eventFilter(QObject *obj, QEvent *event) override
    {
        if (!m_engine || QCoreApplication::closingDown())
            return QObject::eventFilter(obj, event);
        if (event->type() == QEvent::ChildAdded || event->type() == QEvent::Show || event->type() == QEvent::Polish) {
            trySet();
        }
        if (auto *win = qobject_cast<QQuickWindow*>(obj)) {
            QObject *root = win->contentItem();
            QObject *app = root ? findSilicaApplicationWindow(root) : nullptr;
            if (m_engine && m_engine->rootContext())
                m_engine->rootContext()->setContextProperty("applicationWindow", app ? app : static_cast<QObject*>(win));
        }
        return QObject::eventFilter(obj, event);
    }
    void trySet()
    {
        if (!m_engine || QCoreApplication::closingDown())
            return;
        auto *ctx = m_engine->rootContext();
        if (!ctx)
            return;
        const auto wins = QGuiApplication::topLevelWindows();
        for (QWindow *w : wins) {
            if (auto *qwin = qobject_cast<QQuickWindow*>(w)) {
                QObject *app = findSilicaApplicationWindow(qwin->contentItem());
                if (app) {
                    ctx->setContextProperty("applicationWindow", app);
                    return;
                }
                ctx->setContextProperty("applicationWindow", qwin);
            }
        }
    }
private:
    QPointer<QQmlEngine> m_engine;
};

void QQuickKremniumControlsExtensionPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    KremniumTheme* theme = new KremniumTheme();

    QQmlExtensionPlugin::initializeEngine(engine, uri);
    QQmlContext* context = engine->rootContext();
    context->setContextProperty("Theme", theme);
    context->setContextProperty("palette", theme);
    engine->addImageProvider(QStringLiteral("theme"), new ThemeImageProvider());

    // Provide QtFeedback stub for apps that use it (e.g. ThemeEffect) without requiring QtFeedback module
    qmlRegisterType<ThemeEffectStub>("QtFeedback", 5, 0, "ThemeEffect");

    // placeholder so name exists early; replaced with real Silica ApplicationWindow when found
    context->setContextProperty("applicationWindow", QVariant::fromValue<QObject*>(nullptr));

    auto *watcher = new AppWindowWatcher(engine, engine);
    if (qGuiApp) qGuiApp->installEventFilter(watcher);

    auto setAppWin = [watcher]() { watcher->trySet(); };
    QObject::connect(qGuiApp, &QGuiApplication::focusWindowChanged, engine, [watcher](QWindow *) {
        watcher->trySet();
    });
    QTimer::singleShot(0, engine, setAppWin);
    QTimer::singleShot(50, engine, setAppWin);
    QTimer::singleShot(100, engine, setAppWin);
    QTimer::singleShot(500, engine, setAppWin);
    QTimer::singleShot(1500, engine, setAppWin);
}

#include "plugin.moc"
