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
#include "declarativetruncationmode.h"
#include "kremniumtheme.h"
#include <QtQml>
#include <QScreen>

void QQuickKremniumControlsExtensionPlugin::registerTypes(const char* uri)
{
    Q_ASSERT(uri == QLatin1String("Sailfish.Silica"));
    qmlRegisterModule(uri, 1, 0);
    qmlRegisterUncreatableType<Qt::ScreenOrientation>(uri, 1, 0, "Orientation", "Not creatable as it is an enum type");
    qmlRegisterUncreatableType<DeclarativePageStatus>(uri, 1, 0, "PageStatus", "Not creatable as it is an enum type");
    qmlRegisterUncreatableType<DeclarativeTruncationMode>(uri, 1, 0, "TruncationMode", "Not creatable as it is an enum type");
}

void QQuickKremniumControlsExtensionPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    KremniumTheme* theme = new KremniumTheme();

    QQmlExtensionPlugin::initializeEngine(engine, uri);
    QQmlContext* context = engine->rootContext();
    context->setContextProperty("Theme", theme);
}
