import QtQuick 2.0
import Sailfish.Silica 1.0

Label {
    id: root
    property string defaultLinkActions
    property string plainText
    property bool shortenUrl: false
    text: plainText.length > 0 ? plainText : text
    textFormat: Text.StyledText
    wrapMode: Text.Wrap
    onLinkActivated: function(link) { Qt.openUrlExternally(link) }
}
