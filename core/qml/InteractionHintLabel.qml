import QtQuick 2.0
import Sailfish.Silica 1.0

Label {
    property bool invert
    property int interactionMode
    anchors.horizontalCenter: parent ? parent.horizontalCenter : undefined
    opacity: 0.0
}
