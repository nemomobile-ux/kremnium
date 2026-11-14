#include "silicascreen.h"
#include <QGuiApplication>
#include <QScreen>
#include <QWindow>
#include <QtGlobal>

SilicaScreen::SilicaScreen(QObject *parent) : QObject(parent)
{
    if (qGuiApp) {
        connect(qGuiApp, &QGuiApplication::primaryScreenChanged, this, [this](QScreen *s){
            if (s) {
                connect(s, &QScreen::geometryChanged, this, &SilicaScreen::sizeChanged);
                connect(s, &QScreen::physicalDotsPerInchChanged, this, &SilicaScreen::screenChanged);
            }
            emit screenChanged();
            emit sizeChanged();
        });
        if (QScreen *s = qGuiApp->primaryScreen()) {
            connect(s, &QScreen::geometryChanged, this, &SilicaScreen::sizeChanged);
            connect(s, &QScreen::physicalDotsPerInchChanged, this, &SilicaScreen::screenChanged);
        }
        // Track top-level window size for windowed/desktop runs (Silica apps expect Screen to match app window)
        connect(qGuiApp, &QGuiApplication::focusWindowChanged, this, [this](QWindow *w){
            if (w) {
                connect(w, &QWindow::widthChanged, this, &SilicaScreen::sizeChanged, Qt::UniqueConnection);
                connect(w, &QWindow::heightChanged, this, &SilicaScreen::sizeChanged, Qt::UniqueConnection);
            }
            emit sizeChanged();
        });
    }
}

QScreen *SilicaScreen::screen() const
{
    return qGuiApp ? qGuiApp->primaryScreen() : nullptr;
}

static QWindow *activeAppWindow()
{
    if (!qGuiApp) return nullptr;
    QWindow *w = qGuiApp->focusWindow();
    if (w) return w;
    const auto wins = QGuiApplication::topLevelWindows();
    for (QWindow *tw : wins) {
        if (tw && tw->isVisible())
            return tw;
    }
    if (!wins.isEmpty())
        return wins.first();
    return nullptr;
}

int SilicaScreen::width() const
{
    if (m_overrideWidth > 0) return m_overrideWidth;
    if (QWindow *w = activeAppWindow()) {
        int ww = w->width();
        if (ww > 0) return ww;
    }
    QScreen *s = screen();
    return s ? s->size().width() : 0;
}

int SilicaScreen::height() const
{
    if (m_overrideHeight > 0) return m_overrideHeight;
    if (QWindow *w = activeAppWindow()) {
        int wh = w->height();
        if (wh > 0) return wh;
    }
    QScreen *s = screen();
    return s ? s->size().height() : 0;
}

qreal SilicaScreen::pixelDensity() const
{
    QScreen *s = screen();
    return s ? s->physicalDotsPerInch() / 25.4 : 0.0;
}

qreal SilicaScreen::devicePixelRatio() const
{
    QScreen *s = screen();
    return s ? s->devicePixelRatio() : 1.0;
}

int SilicaScreen::orientation() const
{
    if (m_overrideWidth > 0 && m_overrideHeight > 0)
        return m_overrideWidth > m_overrideHeight ? Qt::LandscapeOrientation : Qt::PortraitOrientation;
    if (QWindow *w = activeAppWindow()) {
        if (w->width() > 0 && w->height() > 0)
            return w->width() > w->height() ? Qt::LandscapeOrientation : Qt::PortraitOrientation;
    }
    QScreen *s = screen();
    return s ? static_cast<int>(s->orientation()) : Qt::PrimaryOrientation;
}

int SilicaScreen::primaryOrientation() const
{
    QScreen *s = screen();
    return s ? static_cast<int>(s->primaryOrientation()) : Qt::PrimaryOrientation;
}

int SilicaScreen::desktopAvailableWidth() const
{
    QScreen *s = screen();
    return s ? s->availableSize().width() : width();
}

int SilicaScreen::desktopAvailableHeight() const
{
    QScreen *s = screen();
    return s ? s->availableSize().height() : height();
}

int SilicaScreen::sizeCategory() const
{
    int w = qMin(width(), height());
    if (w >= 720) return 4;
    if (w >= 540) return 3;
    if (w >= 360) return 2;
    if (w >= 250) return 1;
    return 0;
}

void SilicaScreen::setOverrideWidth(int w)
{
    if (m_overrideWidth == w) return;
    m_overrideWidth = w;
    emit sizeChanged();
}

void SilicaScreen::setOverrideHeight(int h)
{
    if (m_overrideHeight == h) return;
    m_overrideHeight = h;
    emit sizeChanged();
}
