import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: root
    property var model
    property Item tabView
    property int currentIndex: tabView ? tabView.currentIndex : 0

    implicitHeight: Theme.itemSizeSmall
    height: implicitHeight

    Rectangle {
        anchors.fill: parent
        color: Theme.highlightDimmerColor
    }

    Row {
        id: row
        anchors.fill: parent
        Repeater {
            model: root.model
            delegate: MouseArea {
                width: root.width / Math.max(1, (root.model && root.model.count !== undefined ? root.model.count : (root.model ? root.model.length : 1)))
                height: root.height
                onClicked: {
                    if (root.tabView) root.tabView.moveTo(index)
                    else root.currentIndex = index
                }
                Rectangle {
                    anchors.fill: parent
                    color: index === root.currentIndex ? Theme.highlightBackgroundColor : "transparent"
                    opacity: index === root.currentIndex ? 0.4 : 0.0
                }
                Label {
                    anchors.centerIn: parent
                    text: model.title !== undefined ? model.title : (modelData && modelData.title !== undefined ? modelData.title : "")
                    color: index === root.currentIndex ? Theme.highlightColor : Theme.primaryColor
                    font.pixelSize: Theme.fontSizeSmall
                    elide: Text.ElideRight
                    width: parent.width - Theme.paddingSmall * 2
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }
    }
}
