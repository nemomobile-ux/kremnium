import QtQuick 2.0
import Sailfish.Silica 1.0

Image {
    id: root
    property bool highlighted: false
    property color color: Theme.primaryColor
    property color highlightColor: Theme.highlightColor
    fillMode: Image.PreserveAspectFit
    asynchronous: true
}
