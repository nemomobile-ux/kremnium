import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: root

    property alias text: input.text
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
    property int echoMode: TextInput.Normal
    property alias font: input.font
    property alias readOnly: input.readOnly
    property alias validator: input.validator
    property alias cursorPosition: input.cursorPosition
    property alias selectionStart: input.selectionStart
    property alias selectionEnd: input.selectionEnd
    property alias selectedText: input.selectedText
    property alias horizontalAlignment: input.horizontalAlignment
    property alias inputMethodComposing: input.inputMethodComposing
    property string _editorPlaceholderText: placeholderText
    property int wrapMode: TextInput.NoWrap
    property int textMargin: Theme.horizontalPageMargin

    property alias contentItem: input
    property alias _editor: input

    signal accepted()

    width: parent ? parent.width : implicitWidth
    implicitHeight: labelArea.height + input.implicitHeight + root.textTopMargin + Theme.paddingMedium
    height: implicitHeight

    onActiveFocusChanged: if (activeFocus) input.forceActiveFocus()

    onBackgroundChanged: {
        if (background) {
            try { background.parent = root; background.z = -1 } catch(e) {}
        }
    }

    Item {
        id: labelArea
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: labelLoader.status === Loader.Ready && labelLoader.item ? (labelLoader.item.implicitHeight || labelLoader.item.height || 0)
                                                                          : (labelText.visible ? labelText.implicitHeight : 0)

        Label {
            id: labelText
            anchors.left: parent.left
            anchors.leftMargin: root.textLeftMargin
            anchors.right: parent.right
            anchors.rightMargin: root.textRightMargin
            text: root.label
            visible: !labelLoader.item && !root.labelComponent && root.label.length > 0 && (root.labelVisible !== 0 && root.labelVisible !== false)
            color: Theme.secondaryHighlightColor
            font.pixelSize: Theme.fontSizeExtraSmall
            elide: Text.ElideRight
        }

        Loader {
            id: labelLoader
            anchors.left: parent.left
            anchors.right: parent.right
            sourceComponent: (root.labelComponent && typeof root.labelComponent === "object" && root.labelComponent.createObject !== undefined) ? root.labelComponent : null
            onLoaded: if (item) { item.parent = labelArea }
        }
    }

    onLabelComponentChanged: {
        if (labelComponent && labelComponent.createObject === undefined) {
            try { labelComponent.parent = labelArea } catch(e) {}
        }
    }

    Rectangle {
        id: defaultBg
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: labelArea.bottom
        anchors.bottom: parent.bottom
        z: -2
        visible: !root.background
        color: Theme.highlightBackgroundColor
        opacity: 0.1
        radius: 4
    }

    Item { id: leftHolder; anchors.left: parent.left; anchors.leftMargin: Theme.paddingSmall; anchors.verticalCenter: input.verticalCenter; width: root.leftItem ? root.leftItem.width : 0; height: root.leftItem ? root.leftItem.height : 0; data: root.leftItem ? [root.leftItem] : [] }
    Item { id: rightHolder; anchors.right: parent.right; anchors.rightMargin: Theme.paddingSmall; anchors.verticalCenter: input.verticalCenter; width: root.rightItem ? root.rightItem.width : 0; height: root.rightItem ? root.rightItem.height : 0; data: root.rightItem ? [root.rightItem] : [] }

    TextInput {
        id: input
        anchors.left: leftHolder.right
        anchors.right: rightHolder.left
        anchors.leftMargin: root.textLeftMargin
        anchors.rightMargin: root.textRightMargin
        anchors.top: labelArea.bottom
        anchors.topMargin: root.textTopMargin
        color: root.color
        font.pixelSize: Theme.fontSizeMedium
        echoMode: root.echoMode
        inputMethodHints: root.inputMethodHints
        onAccepted: root.accepted()
    }

    Component.onCompleted: {
        if (background) { try { background.parent = root; background.z = -1 } catch(e) {} }
        if (labelComponent && labelComponent.createObject === undefined) { try { labelComponent.parent = labelArea } catch(e) {} }
    }

    function forceActiveFocus() { input.forceActiveFocus() }
    function select(start, end) { input.select(start, end) }
    function selectAll() { input.selectAll() }
    function copy() { input.copy() }
    function paste() { input.paste() }
    function cut() { input.cut() }
}
