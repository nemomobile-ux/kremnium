import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: root
    property alias text: label.text
    property alias icon: iconImage
    anchors.fill: parent
    Image {
        id: iconImage
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: label.top
        anchors.bottomMargin: Theme.paddingMedium
        fillMode: Image.PreserveAspectFit
    }
    Label {
        id: label
        anchors.centerIn: parent
        width: parent.width - Theme.paddingLarge*2
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.Wrap
        color: Theme.highlightColor
    }
}
