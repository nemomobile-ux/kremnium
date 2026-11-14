#include <QDebug>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDir>
#include <QFileInfo>
#include <QUrl>

int main(int argc, char* argv[])
{
    QGuiApplication app(argc, argv);
    app.setApplicationName(QStringLiteral("kremnium-clock"));

    QQmlApplicationEngine engine;

    const QString appDir = QFileInfo(QString::fromUtf8(argv[0])).absolutePath();
    const QString cwd = QDir::currentPath();

    QStringList searchDirs = { appDir, QDir(appDir).filePath(QStringLiteral("..")), cwd };
    searchDirs << QDir(appDir).filePath(QStringLiteral("../.."));
#ifdef KREMNIUM_CLOCK_SOURCE_DIR
    searchDirs << QStringLiteral(KREMNIUM_CLOCK_SOURCE_DIR);
#endif

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
    qInfo() << "kremnium-clock: mainQml" << mainQml;
    if (mainQml.isEmpty()) {
        qWarning("kremnium-clock: cannot find main.qml");
        return -1;
    }

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
                     &app, []() { QCoreApplication::exit(-1); },
                     Qt::QueuedConnection);
    engine.load(QUrl::fromLocalFile(mainQml));
    qInfo() << "kremnium-clock: rootObjects after main" << engine.rootObjects().size();

    if (engine.rootObjects().isEmpty()) {
        const QString clockQml = findFile(QStringLiteral("clock/clock.qml"));
        qInfo() << "kremnium-clock: clockQml" << clockQml;
        if (!clockQml.isEmpty())
            engine.load(QUrl::fromLocalFile(clockQml));
    }

    return app.exec();
}
