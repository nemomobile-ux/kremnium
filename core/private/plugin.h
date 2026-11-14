#ifndef SILICA_PRIVATE_PLUGIN_H
#define SILICA_PRIVATE_PLUGIN_H

#include <QQmlExtensionPlugin>

class SilicaPrivatePlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID QQmlExtensionInterface_iid)
public:
    void registerTypes(const char *uri) override;
};

#endif
