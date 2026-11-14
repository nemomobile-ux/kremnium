import QtQuick 2.0
import Sailfish.Silica 1.0

MouseArea {
    id: root
    property string text
    property bool down: pressed && containsMouse
    property bool highlighted: down
    property color color: Theme.primaryColor
    property int layoutDirection: Qt.LeftToRight
    property alias icon: iconImage
    property bool preferredWidth: false

    implicitWidth: Math.max(Theme.buttonWidthMedium, contentRow.implicitWidth + Theme.paddingLarge*2)
    implicitHeight: Theme.itemSizeSmall
    width: implicitWidth
    height: implicitHeight

    Rectangle {
        anchors.fill: parent
        radius: Theme.paddingSmall
        color: root.down ? Theme.highlightBackgroundColor : Theme.secondaryHighlightColor
        opacity: root.enabled ? 0.4 : 0.2
    }

    Row {
        id: contentRow
        anchors.centerIn: parent
        spacing: Theme.paddingSmall
        layoutDirection: root.layoutDirection

        Image {
            id: iconImage
            visible: source !== "" && status !== Image.Null
            width: visible ? Theme.iconSizeSmall : 0
            height: Theme.iconSizeSmall
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            property bool highlight: false
        }
        Label {
            text: root.text
            color: root.enabled ? Theme.primaryColor : Theme.secondaryColor
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: Theme.fontSizeMedium
        }
    }
}
