import QtQuick 2.0
import Sailfish.Silica 1.0
Column {
    id: root
    property string title
    property bool expanded: false
    property Component content
    property alias button: headerItem
    default property alias _content: body.data
    width: parent ? parent.width : implicitWidth
    BackgroundItem {
        id: headerItem
        width: parent.width
        height: Theme.itemSizeSmall
        onClicked: root.expanded = !root.expanded
        Label { anchors.left: parent.left; anchors.leftMargin: Theme.horizontalPageMargin; anchors.verticalCenter: parent.verticalCenter; text: root.title; color: Theme.highlightColor }
    }
    Item {
        id: body
        width: parent.width
        height: root.expanded ? implicitHeight : 0
        visible: root.expanded
        implicitHeight: childrenRect.height
        Loader { sourceComponent: root.content; width: parent.width }
    }
}
