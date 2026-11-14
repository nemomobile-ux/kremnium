import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: root
    property bool open: false
    property bool opened: open
    property bool expanded: open
    property bool modal: false
    property bool docked: true
    property int dock: Dock.Bottom
    property real visibleSize: open ? (dock === Dock.Left || dock === Dock.Right ? width : height) : 0
    property real _visibleSize: visibleSize
    property alias background: bg.data
    property alias contentItem: contentItem

    default property alias _content: contentItem.data

    z: 10
    visible: open || height > 0 || width > 0

    Rectangle {
        id: bg
        anchors.fill: parent
        color: Theme.highlightDimmerColor
        opacity: 0.9
        z: -1
    }
    Item {
        id: contentItem
        anchors.fill: parent
    }

    function show(immediate) { open = true }
    function hide(immediate) { open = false }
}
