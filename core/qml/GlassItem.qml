import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: root
    property color color: Theme.highlightColor
    property bool dimmed: false
    property real radius: 0.5
    property real falloffRadius: 0.1
    property real brightness: 1.0
    implicitWidth: Theme.itemSizeExtraSmall
    implicitHeight: Theme.itemSizeExtraSmall

    Rectangle {
        anchors.centerIn: parent
        width: Math.min(parent.width, parent.height) * Math.max(0.1, root.radius)
        height: width
        radius: width / 2
        color: root.color
        opacity: (root.dimmed ? 0.3 : 1.0) * root.brightness
    }
}
