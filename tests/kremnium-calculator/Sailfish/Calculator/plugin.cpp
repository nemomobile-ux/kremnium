#include <QtQml/qqmlextensionplugin.h>
#include <QtQml/qqml.h>
#include "calculation.h"

class SailfishCalculatorPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID QQmlExtensionInterface_iid)

public:
    void registerTypes(const char *uri) override
    {
        qmlRegisterType<Calculation>(uri, 1, 0, "Calculation");
    }
};

#include "plugin.moc"
