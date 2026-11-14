import QtQuick 2.0
import Sailfish.Silica 1.0

// Launcher for testing real Jolla Calculator QML with Kremnium's Sailfish.Silica.
// Run with a Qt6 QML runtime that can see Kremnium's Sailfish.Silica module and
// this directory in QML import path (for Sailfish.Calculator stub), e.g. on device:
//   QML2_IMPORT_PATH=<kremnium-qml-install>:/home/defaultuser/kremnium-calculator qml6 /home/defaultuser/kremnium-calculator/main.qml
//
// Loads the copied real calculator QML bundled in ./calculator/.

QtObject {
    id: root
    property url source: Qt.resolvedUrl("calculator/calculator.qml")

    property var app: null

    Component.onCompleted: {
        var comp = Qt.createComponent(source)
        if (comp.status === Component.Ready) {
            app = comp.createObject(null)
            if (!app) {
                console.log("Failed to create calculator object:", comp.errorString())
            }
        } else if (comp.status === Component.Error) {
            console.log("Failed to load calculator QML:", comp.errorString())
        } else {
            comp.statusChanged.connect(function() {
                if (comp.status === Component.Ready) {
                    app = comp.createObject(null)
                    if (!app) console.log("Failed to create calculator object:", comp.errorString())
                } else if (comp.status === Component.Error) {
                    console.log("Failed to load calculator QML:", comp.errorString())
                }
            })
        }
    }
}
