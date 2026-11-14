import QtQuick 2.0
import Sailfish.Silica 1.0

BackgroundItem {
    id: root
    property string label
    property string value
    property string description
    property alias valueColor: valueLabel.color
    implicitHeight: Theme.itemSizeSmall
    width: parent ? parent.width : implicitWidth
    Column {
        anchors.left: parent.left
        anchors.leftMargin: Theme.horizontalPageMargin
        anchors.right: parent.right
        anchors.rightMargin: Theme.horizontalPageMargin
        anchors.verticalCenter: parent.verticalCenter
        Label { text: root.label; color: Theme.secondaryHighlightColor; font.pixelSize: Theme.fontSizeExtraSmall; width: parent.width }
        Label { id: valueLabel; text: root.value; color: Theme.primaryColor; width: parent.width }
        Label { text: root.description; visible: text.length>0; color: Theme.secondaryColor; font.pixelSize: Theme.fontSizeExtraSmall; width: parent.width; wrapMode: Text.Wrap }
    }
}
