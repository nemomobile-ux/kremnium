import QtQuick 2.0
import Sailfish.Silica 1.0

TextInput {
    id: root
    property string label
    property string placeholderText
    property string description
    property string errorHighlight
    property bool acceptableInput: true
    property int textLeftMargin: Theme.horizontalPageMargin
    property int textRightMargin: Theme.horizontalPageMargin
    property int textTopMargin: Theme.paddingMedium
    property real labelVisible: 1.0
    property color color: Theme.primaryColor
    property color placeholderColor: Theme.secondaryColor
    property bool enableSoftwareInputPanel: true
    property var labelComponent
    property Item rightItem
    property Item leftItem
    property bool focusOutBehavior: false
    property bool textRightAligned: false
    property int inputMethodHints: Qt.ImhNone
    property string _editorPlaceholderText: placeholderText
    echoMode: TextInput.Normal
    font.pixelSize: Theme.fontSizeMedium
    width: parent ? parent.width : implicitWidth
    height: Math.max(Theme.itemSizeSmall, implicitHeight + Theme.paddingMedium)
    Rectangle { anchors.fill: parent; z: -1; color: Theme.highlightBackgroundColor; opacity: 0.1; radius: 4 }
    Item { id: _right; data: root.rightItem ? [root.rightItem] : []; anchors.right: parent.right; anchors.verticalCenter: parent.verticalCenter }
}
