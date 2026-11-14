import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: root
    property real value: 0.0
    property real progressValue: value
    property bool indeterminate: false
    property color progressColor: Theme.highlightColor
    property color backgroundColor: Theme.secondaryColor
    property real borderWidth: 4
    property string label
    property string valueText
    implicitWidth: Theme.iconSizeMedium
    implicitHeight: Theme.iconSizeMedium
    Rectangle {
        anchors.fill: parent
        radius: width/2
        color: "transparent"
        border.color: root.backgroundColor
        border.width: root.borderWidth
        opacity: 0.4
    }
    Rectangle {
        anchors.centerIn: parent
        width: parent.width * Math.max(0, Math.min(1, root.indeterminate ? 0.5 : root.value))
        height: width
        radius: width/2
        color: root.progressColor
        opacity: 0.6
    }
    Label {
        anchors.centerIn: parent
        text: root.label.length > 0 ? root.label : root.valueText
        visible: text.length > 0
        font.pixelSize: Theme.fontSizeExtraSmall
        color: Theme.primaryColor
    }
}
