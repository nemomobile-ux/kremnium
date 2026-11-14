import QtQuick 2.0
import Sailfish.Silica 1.0

TextInput {
    id: root
    property string label
    property string placeholderText
    property string description
    property bool errorHighlight: false
    property bool acceptableInput: true
    property int textLeftMargin: Theme.horizontalPageMargin
    property int textRightMargin: Theme.horizontalPageMargin
    property int textTopMargin: Theme.paddingMedium
    property var labelVisible: 1.0
    property color color: Theme.primaryColor
    property color placeholderColor: Theme.secondaryColor
    property bool enableSoftwareInputPanel: true
    property var labelComponent
    property Item rightItem
    property Item leftItem
    property bool focusOutBehavior: false
    property bool focusOnClick: true
    property bool textRightAligned: false
    property int backgroundStyle: 0
    property var background
    property int inputMethodHints: Qt.ImhNone
    property string _editorPlaceholderText: placeholderText
    echoMode: TextInput.Normal
    font.pixelSize: Theme.fontSizeMedium
    width: parent ? parent.width : implicitWidth
    height: Math.max(Theme.itemSizeSmall, implicitHeight + Theme.paddingMedium)
    Rectangle { anchors.fill: parent; z: -1; color: Theme.highlightBackgroundColor; opacity: 0.1; radius: 4 }
    Item { id: _rightHolder; anchors.right: parent.right; anchors.verticalCenter: parent.verticalCenter; width: root.rightItem ? root.rightItem.width : 0; height: root.rightItem ? root.rightItem.height : 0 }
    Item { id: _leftHolder; anchors.left: parent.left; anchors.verticalCenter: parent.verticalCenter; width: root.leftItem ? root.leftItem.width : 0; height: root.leftItem ? root.leftItem.height : 0 }
}
