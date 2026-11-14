import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: root
    property bool open: false
    property bool opened: open
    property Item background
    property Item foreground
    property bool hideOnMinimize: true
    property real dock: 0
    default property alias _content: contentItem.data
    anchors.fill: parent
    Item { id: contentItem; anchors.fill: parent }
    function show() { open = true }
    function hide() { open = false }
}
