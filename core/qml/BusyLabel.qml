import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: root
    property alias text: label.text
    property bool running: true
    implicitHeight: Theme.itemSizeLarge
    width: parent ? parent.width : implicitWidth
    BusyIndicator {
        id: ind
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        running: root.running
        visible: root.running
    }
    Label {
        id: label
        anchors.top: ind.bottom
        anchors.topMargin: Theme.paddingMedium
        anchors.horizontalCenter: parent.horizontalCenter
        color: Theme.secondaryHighlightColor
    }
}
