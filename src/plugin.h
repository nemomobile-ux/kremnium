#ifndef PLUGIN_H
#define PLUGIN_H

#include <QQmlExtensionPlugin>

class QQuickKremniumControlsExtensionPlugin : public QQmlExtensionPlugin {
public:
    Q_OBJECT
    Q_PLUGIN_METADATA(IID QQmlEngineExtensionInterface_iid FILE "kremnium.json")
public:
    void registerTypes(const char* uri);
};

#endif // PLUGIN_H
