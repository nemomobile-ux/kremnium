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

#include <QDebug>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDir>
#include <QFileInfo>
#include <QUrl>
#include <QtQml>

#include "Sailfish/Calculator/calculation.h"

int main(int argc, char* argv[])
{
    QGuiApplication app(argc, argv);
    app.setApplicationName(QStringLiteral("kremnium-calculator"));

    qmlRegisterType<Calculation>("Sailfish.Calculator", 1, 0, "Calculation");

    QQmlApplicationEngine engine;

    const QString appDir = QFileInfo(QString::fromUtf8(argv[0])).absolutePath();
    const QString cwd = QDir::currentPath();

    QStringList searchDirs = { appDir, QDir(appDir).filePath(QStringLiteral("..")), cwd };
    // common dev layout: <src>/build/ -> <src>/
    searchDirs << QDir(appDir).filePath(QStringLiteral("../.."));
#ifdef KREMNIUM_CALC_SOURCE_DIR
    searchDirs << QStringLiteral(KREMNIUM_CALC_SOURCE_DIR);
#endif

    // Prepend import paths so Kremnium's Sailfish.Silica takes precedence over system modules
    QStringList importPaths = engine.importPathList();
    const QString qmlImportPath = QString::fromLocal8Bit(qgetenv("QML_IMPORT_PATH"));
    if (!qmlImportPath.isEmpty()) {
        const QStringList envPaths = qmlImportPath.split(QLatin1Char(':'));
        for (int i = envPaths.size() - 1; i >= 0; --i) {
            if (!envPaths[i].isEmpty())
                importPaths.prepend(envPaths[i]);
        }
    }
    for (int i = searchDirs.size() - 1; i >= 0; --i) {
        importPaths.prepend(searchDirs[i]);
    }
    importPaths.removeDuplicates();
    engine.setImportPathList(importPaths);

    auto findFile = [&](const QString &rel) -> QString {
        for (const QString &dir : searchDirs) {
            const QString p = QDir(dir).filePath(rel);
            if (QFileInfo::exists(p))
                return QDir(p).absolutePath();
        }
        return QString();
    };

    const QString mainQml = findFile(QStringLiteral("main.qml"));
    qInfo() << "kremnium-calculator: mainQml" << mainQml;
    if (mainQml.isEmpty()) {
        qWarning("kremnium-calculator: cannot find main.qml");
        return -1;
    }

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
                     &app, []() { QCoreApplication::exit(-1); },
                     Qt::QueuedConnection);
    engine.load(QUrl::fromLocalFile(mainQml));
    qInfo() << "kremnium-calculator: rootObjects after main" << engine.rootObjects().size();

    if (engine.rootObjects().isEmpty()) {
        const QString calcQml = findFile(QStringLiteral("calculator/calculator.qml"));
        qInfo() << "kremnium-calculator: calcQml" << calcQml;
        if (!calcQml.isEmpty())
            engine.load(QUrl::fromLocalFile(calcQml));
    }

    return app.exec();
}
