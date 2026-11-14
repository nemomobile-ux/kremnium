import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: root
    property bool open: false
    property bool opened: open
    property alias background: backgroundItem.data
    property alias foreground: foregroundItem.data
    property bool hideOnMinimize: true
    property int dock: Dock.Left
    default property alias _content: foregroundItem.data

    Item {
        id: backgroundItem
        anchors.fill: parent
        visible: root.open
        z: 0
    }

    Item {
        id: foregroundItem
        anchors.fill: parent
        z: 1
    }

    function show() { open = true }
    function hide() { open = false }
}
