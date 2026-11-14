import QtQuick 2.0
import Sailfish.Silica 1.0

MouseArea {
    id: root
    property alias text: label.text
    property alias description: desc.text
    property bool checked: false
    property bool automaticCheck: true
    property bool down: pressed && containsMouse
    property bool highlighted: down
    property bool busy: false
    property alias icon: iconItem

    implicitWidth: parent ? parent.width : Theme.itemSizeLarge
    implicitHeight: Math.max(Theme.itemSizeSmall, contentColumn.implicitHeight + Theme.paddingMedium * 2)
    height: implicitHeight

    onClicked: if (automaticCheck) checked = !checked

    Image {
        id: iconItem
        visible: false
        width: 0; height: 0
        property bool highlight: false
    }

    Rectangle {
        id: indicator
        anchors.left: parent.left
        anchors.leftMargin: Theme.horizontalPageMargin
        anchors.verticalCenter: parent.verticalCenter
        width: Theme.iconSizeSmall
        height: width
        radius: 4
        color: root.checked ? Theme.highlightColor : Theme.secondaryColor
        opacity: 0.6
    }

    Column {
        id: contentColumn
        anchors.left: indicator.right
        anchors.leftMargin: Theme.paddingMedium
        anchors.right: parent.right
        anchors.rightMargin: Theme.horizontalPageMargin
        anchors.verticalCenter: parent.verticalCenter
        spacing: Theme.paddingSmall
        Label {
            id: label
            width: parent.width
            wrapMode: Text.Wrap
            color: root.enabled ? Theme.primaryColor : Theme.secondaryColor
        }
        Label {
            id: desc
            width: parent.width
            visible: text.length > 0
            wrapMode: Text.Wrap
            font.pixelSize: Theme.fontSizeExtraSmall
            color: Theme.secondaryColor
        }
    }
}
