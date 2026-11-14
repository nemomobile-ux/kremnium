import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: root
    property string label
    property string value
    property string description
    property int currentIndex: -1
    property var currentItem: null
    property var menu: null
    property bool enabled: true

    signal activated(int index)
    signal clicked()

    implicitHeight: Theme.itemSizeSmall
    width: parent ? parent.width : implicitWidth
    height: implicitHeight

    Rectangle { anchors.fill: parent; color: Theme.highlightBackgroundColor; opacity: 0.1; radius: 4 }

    Column {
        anchors.left: parent.left
        anchors.leftMargin: Theme.horizontalPageMargin
        anchors.verticalCenter: parent.verticalCenter
        spacing: 2
        Label { id: labelLabel; text: root.label; color: Theme.secondaryHighlightColor; font.pixelSize: Theme.fontSizeExtraSmall }
        Label { id: valueLabel; text: root.value; color: Theme.primaryColor }
        Label { text: root.description; visible: text.length>0; color: Theme.secondaryColor; font.pixelSize: Theme.fontSizeExtraSmall }
    }

    property Item _menuItem: null

    function _menuItems() {
        if (!_menuItem) return []
        // our ContextMenu stores items in _content/menuColumn
        try { if (_menuItem._content && _menuItem._content.children) return _menuItem._content.children } catch(e) {}
        try { if (_menuItem.children && _menuItem.children.length > 0) return _menuItem.children } catch(e) {}
        return []
    }

    function _syncFromIndex() {
        var items = _menuItems()
        if (currentIndex >= 0 && currentIndex < items.length) {
            root.currentItem = items[currentIndex]
            if (items[currentIndex] && items[currentIndex].text !== undefined)
                root.value = items[currentIndex].text
        } else if (currentIndex < 0) {
            root.currentItem = null
        }
    }

    function _connectMenu(m) {
        if (!m) return
        _menuItem = m
        // keep declared parent for inline menu instances to preserve scope/placement expectations
        try {
            if (m.activated) m.activated.connect(function(idx) { root.currentIndex = idx; root.activated(idx); root._syncFromIndex() })
        } catch(e) {}
        // initialize
        if (root.currentIndex < 0) {
            root.currentIndex = 0
        }
        _syncFromIndex()
    }

    function _handleMenuChanged() {
        if (!menu) return
        if (menu.createObject) {
            var m = menu.createObject(root)
            _connectMenu(m)
        } else {
            _connectMenu(menu)
        }
    }

    onMenuChanged: _handleMenuChanged()

    onCurrentIndexChanged: _syncFromIndex()

    MouseArea {
        anchors.fill: parent
        enabled: root.enabled
        onClicked: {
            root.clicked()
            if (root._menuItem) {
                try { if (root._menuItem.open) root._menuItem.open(root); else root._menuItem.visible = true } catch(e) { root._menuItem.visible = true }
                root._menuItem.z = 1000
                root._menuItem.width = root.width
            }
        }
    }

    Component.onCompleted: {
        if (menu) _handleMenuChanged()
    }
}
