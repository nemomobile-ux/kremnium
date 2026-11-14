import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: root
    property string label
    property string value
    property string description
    property alias currentIndex: internal.currentIndex
    property var currentItem: null
    property alias menu: menuLoader.sourceComponent
    property bool enabled: true

    signal activated(int index)
    signal clicked()

    QtObject { id: internal; property int currentIndex: -1 }

    implicitHeight: Theme.itemSizeSmall
    width: parent ? parent.width : implicitWidth
    height: implicitHeight

    Rectangle { anchors.fill: parent; color: Theme.highlightBackgroundColor; opacity: 0.1; radius: 4 }

    Column {
        anchors.left: parent.left
        anchors.leftMargin: Theme.horizontalPageMargin
        anchors.verticalCenter: parent.verticalCenter
        spacing: 2
        Label { text: root.label; color: Theme.secondaryHighlightColor; font.pixelSize: Theme.fontSizeExtraSmall }
        Label { text: root.value; color: Theme.primaryColor }
        Label { text: root.description; visible: text.length>0; color: Theme.secondaryColor; font.pixelSize: Theme.fontSizeExtraSmall }
    }

    Loader {
        id: menuLoader
        active: true
        visible: false
        onLoaded: {
            if (item) {
                if (item.activated) item.activated.connect(function(idx) { internal.currentIndex = idx; root.activated(idx) })
                if (item.parent !== root) item.parent = root
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.clicked()
            if (menuLoader.item) {
                if (menuLoader.item.open) menuLoader.item.open(root)
                menuLoader.item.visible = true
                menuLoader.item.z = 1000
                menuLoader.item.width = root.width
            }
        }
    }
}
