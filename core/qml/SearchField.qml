import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: root
    property alias text: input.text
    property string placeholderText
    property alias label: labelText.text
    property bool canHide: true
    property bool focusOutBehavior: true
    property int textLeftMargin: Theme.horizontalPageMargin
    property int textRightMargin: Theme.horizontalPageMargin
    property int textMargin: Theme.horizontalPageMargin

    function forceActiveFocus() { input.forceActiveFocus() }
    onActiveFocusChanged: if (activeFocus) input.forceActiveFocus()
    implicitHeight: Theme.itemSizeSmall
    width: parent ? parent.width : implicitWidth
    height: implicitHeight

    TextInput {
        id: input
        anchors.fill: parent
        anchors.leftMargin: root.textLeftMargin
        anchors.rightMargin: root.textRightMargin
        verticalAlignment: Text.AlignVCenter
        color: Theme.primaryColor
    }
    Label {
        anchors.fill: input
        verticalAlignment: Text.AlignVCenter
        text: root.placeholderText
        color: Theme.secondaryColor
        visible: input.text.length === 0 && !input.activeFocus
    }
    Label { id: labelText; visible: false }
}
