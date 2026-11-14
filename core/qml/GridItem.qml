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

    property bool _remorseActive: false

    function animateRemoval(callback) {
        _remorseActive = true
        removalAnim._cb = callback
        removalAnim.start()
    }

    SequentialAnimation {
        id: removalAnim
        property var _cb
        NumberAnimation { target: root; property: "opacity"; to: 0; duration: 200 }
        ScriptAction { script: { if (removalAnim._cb) removalAnim._cb(); root.opacity = 1.0; root._remorseActive = false } }
    }

    function remorseAction(text, callback, timeout) {
        var t = "Deleted", cb = null, to = undefined
        if (typeof text === "function" || (text && text.trigger)) { cb = text; to = callback }
        else { t = text; cb = callback; to = timeout }
        return Remorse.itemAction(root, t, function() { root.animateRemoval(cb) }, to)
    }

    function remorseDelete(text, callback, timeout) {
        return remorseAction(text, callback, timeout)
    }

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
