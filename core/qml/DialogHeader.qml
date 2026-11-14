import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: root
    property alias title: titleLabel.text
    property alias acceptText: acceptLabel.text
    property alias cancelText: cancelLabel.text
    property bool acceptTextEnabled: true
    property string defaultAcceptText
    property string defaultCancelText
    signal accept()
    signal cancel()

    implicitHeight: Theme.itemSizeLarge
    width: parent ? parent.width : implicitWidth
    height: implicitHeight

    MouseArea {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        width: cancelLabel.implicitWidth + Theme.horizontalPageMargin*2
        height: parent.height
        onClicked: root.cancel()
        Label {
            id: cancelLabel
            anchors.centerIn: parent
            text: qsTr("Cancel")
            color: Theme.secondaryHighlightColor
        }
    }
    Label {
        id: titleLabel
        anchors.centerIn: parent
        color: Theme.highlightColor
        font.pixelSize: Theme.fontSizeLarge
    }
    MouseArea {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        width: acceptLabel.implicitWidth + Theme.horizontalPageMargin*2
        height: parent.height
        enabled: root.acceptTextEnabled
        onClicked: root.accept()
        Label {
            id: acceptLabel
            anchors.centerIn: parent
            text: qsTr("Accept")
            color: root.acceptTextEnabled ? Theme.highlightColor : Theme.secondaryColor
        }
    }
}
