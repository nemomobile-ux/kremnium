import QtQuick 2.0
import Sailfish.Silica 1.0

MouseArea {
    id: root
    property bool checked: false
    property bool automaticCheck: true
    property bool down: pressed && containsMouse
    property bool highlighted: down
    property bool busy: false
    property alias icon: iconItem

    Item { id: iconItem; property url source; property bool highlight; visible: false }

    implicitWidth: Theme.iconSizeMedium
    implicitHeight: Theme.iconSizeSmall
    width: implicitWidth
    height: implicitHeight

    onClicked: if (automaticCheck) checked = !checked

    Rectangle {
        anchors.fill: parent
        radius: height/2
        color: root.checked ? Theme.highlightColor : Theme.secondaryColor
        opacity: root.checked ? 0.8 : 0.4
    }
    Rectangle {
        width: parent.height - 4
        height: width
        radius: width/2
        anchors.verticalCenter: parent.verticalCenter
        x: root.checked ? parent.width - width - 2 : 2
        color: "white"
        Behavior on x { NumberAnimation { duration: 120 } }
    }
}
