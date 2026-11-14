import QtQuick 2.0
import Sailfish.Silica 1.0
Column {
    id: root
    property string title
    property bool expanded: false
    property alias button: headerItem
    property alias content: contentLoader
    default property alias _content: bodyContent.data

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
        height: root.expanded ? Math.max(bodyContent.implicitHeight, contentLoader.item ? contentLoader.item.implicitHeight : 0, contentLoader.item ? contentLoader.item.height : 0) : 0
        visible: root.expanded
        clip: true
        implicitHeight: Math.max(bodyContent.implicitHeight, contentLoader.item ? contentLoader.item.implicitHeight : 0)

        Item {
            id: bodyContent
            width: parent.width
            implicitHeight: childrenRect.height
            height: implicitHeight
        }
        Loader {
            id: contentLoader
            width: parent.width
        }
    }
}
