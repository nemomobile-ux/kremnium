import QtQuick 2.0

ListModel {
    id: root
    property bool populated: true
    property bool onlyCountdown: false

    function createAlarm() {
        var comp = Qt.createComponent("Alarm.qml")
        if (comp.status === Component.Ready)
            return comp.createObject(root)
        return null
    }
}
