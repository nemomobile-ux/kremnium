import QtQuick 2.0
import Sailfish.Silica 1.0

Label {
    property bool visibleToMenu: true
    width: parent ? parent.width : implicitWidth
    horizontalAlignment: Text.AlignHCenter
    color: Theme.secondaryHighlightColor
    font.pixelSize: Theme.fontSizeExtraSmall
    wrapMode: Text.Wrap
    padding: Theme.paddingSmall
}
