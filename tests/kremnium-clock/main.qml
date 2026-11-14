import QtQuick 2.0

QtObject {
    id: root
    property url source: Qt.resolvedUrl("clock/clock.qml")
    property var app: null

    Component.onCompleted: {
        var comp = Qt.createComponent(source)
        if (comp.status === Component.Ready) {
            app = comp.createObject(null)
            if (!app) console.log("Failed to create clock object:", comp.errorString())
        } else if (comp.status === Component.Error) {
            console.log("Failed to load clock QML:", comp.errorString())
        } else {
            comp.statusChanged.connect(function() {
                if (comp.status === Component.Ready) {
                    app = comp.createObject(null)
                    if (!app) console.log("Failed to create clock object:", comp.errorString())
                } else if (comp.status === Component.Error) {
                    console.log("Failed to load clock QML:", comp.errorString())
                }
            })
        }
    }
}
