#include "plugin.h"
#include "TabViewAction.h"
#include <qqml.h>

void SilicaPrivatePlugin::registerTypes(const char *uri)
{
    Q_ASSERT(QLatin1String(uri) == QLatin1String("Sailfish.Silica.private"));
    qmlRegisterModule(uri, 1, 0);
    qmlRegisterUncreatableMetaObject(TabViewAction::staticMetaObject, uri, 1, 0, "TabViewAction",
                                     QStringLiteral("Not creatable as it is an enum type"));
}

#include "plugin.moc"
