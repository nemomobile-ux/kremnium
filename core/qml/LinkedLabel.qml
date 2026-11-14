import QtQuick 2.0
import Sailfish.Silica 1.0

Label {
    property string defaultLinkActions
    property bool plainText: false
    textFormat: plainText ? Text.PlainText : Text.StyledText
    wrapMode: Text.Wrap
    onLinkActivated: function(link) { Qt.openUrlExternally(link) }
}
