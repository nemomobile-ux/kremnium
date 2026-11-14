import QtQuick 2.0
import Sailfish.Silica 1.0

MouseArea {
    id: root

    property bool highlighted: pressed && containsMouse
    property bool down: pressed && containsMouse
    property color highlightedColor: Theme.rgba(Theme.highlightBackgroundColor, Theme.highlightBackgroundOpacity)
    property bool _showPress: true
    property bool _pressEffectDelay: false
    property var _feedbackEffect

    implicitWidth: Theme.itemSizeExtraLarge
    implicitHeight: Theme.itemSizeSmall

    Rectangle {
        anchors.fill: parent
        visible: root.highlighted && root._showPress
        color: root.highlightedColor
    }
}
