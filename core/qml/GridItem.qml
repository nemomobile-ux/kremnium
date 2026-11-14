import QtQuick 2.0
import Sailfish.Silica 1.0

MouseArea {
    id: root

    property bool highlighted: pressed && containsMouse
    property bool down: pressed && containsMouse
    property bool menuOpen: contextMenu !== null && contextMenu.active
    property color highlightedColor: Theme.rgba(Theme.highlightBackgroundColor, Theme.highlightBackgroundOpacity)
    property color _backgroundColor: highlightedColor
    property bool _showPress: true
    property alias contentItem: contentItem
    property real contentHeight: height
    property real contentWidth: width
    property Component menu
    property Item _menuItem: contextMenu
    property var contextMenu: null

    default property alias _content: contentItem.data

    implicitWidth: Theme.itemSizeExtraLarge
    implicitHeight: Theme.itemSizeExtraLarge

    onPressAndHold: {
        if (menu && !contextMenu) {
            contextMenu = menu.createObject(root, { "item": root })
            if (contextMenu && contextMenu.open) contextMenu.open(root)
            else if (contextMenu) contextMenu.visible = true
        }
    }

    Rectangle {
        id: background
        anchors.fill: parent
        visible: root.highlighted && root._showPress
        color: root._backgroundColor !== undefined ? root._backgroundColor : root.highlightedColor
    }

    Item {
        id: contentItem
        anchors.fill: parent
    }
}
