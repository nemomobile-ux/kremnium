import QtQuick 2.0
SequentialAnimation {
    id: root
    property Item target
    PropertyAction { target: root.target; property: "ListView.delayRemove"; value: true }
    NumberAnimation { target: root.target; property: "opacity"; to: 0; duration: 200 }
    PropertyAction { target: root.target; property: "ListView.delayRemove"; value: false }
}
