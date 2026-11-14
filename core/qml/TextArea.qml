import QtQuick 2.0
import Sailfish.Silica 1.0

TextEdit {
    id: root
    property string label
    property string placeholderText
    property string description
    property bool acceptableInput: true
    property bool errorHighlight: false
    property var labelVisible: 1.0
    property var labelComponent
    property Item leftItem
    property Item rightItem
    property int backgroundStyle: 0
    property var background
    property int textLeftMargin: Theme.horizontalPageMargin
    property int textRightMargin: Theme.horizontalPageMargin
    property int textTopMargin: Theme.paddingMedium
    property int textMargin: Theme.horizontalPageMargin
    property bool hideLabelOnEmptyField: true
    property bool focusOutBehavior: false
    property bool focusOnClick: true
    property Item contentItem: root
    color: Theme.primaryColor
    font.pixelSize: Theme.fontSizeMedium
    wrapMode: TextEdit.Wrap
    width: parent ? parent.width : implicitWidth
    height: Math.max(Theme.itemSizeLarge, implicitHeight + Theme.paddingMedium)
}
