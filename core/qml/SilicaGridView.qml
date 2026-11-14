import QtQuick 2.0
import Sailfish.Silica 1.0

Flickable {
    id: root
    property alias model: gridView.model
    property alias delegate: gridView.delegate
    property alias cellWidth: gridView.cellWidth
    property alias cellHeight: gridView.cellHeight
    property alias header: gridView.header
    property alias footer: gridView.footer
    property alias count: gridView.count
    property alias currentIndex: gridView.currentIndex
    property alias currentItem: gridView.currentItem
    property bool quickScroll: false
    property Item pullDownMenu
    property Item pushUpMenu

    default property alias _data: root.data

    contentWidth: width
    contentHeight: gridView.contentHeight

    GridView {
        id: gridView
        anchors.fill: parent
        interactive: false
        clip: true
    }

    function _attachPullDownMenu(menu) {
        if (!menu) return
        if (menu.parent !== root.contentItem)
            menu.parent = root.contentItem
        menu.width = Qt.binding(function() { return root.width })
        menu.y = Qt.binding(function() { return -menu.height })
        menu.z = 200
        if (menu.hasOwnProperty("flickable"))
            menu.flickable = root
    }
    onPullDownMenuChanged: _attachPullDownMenu(pullDownMenu)
    Component.onCompleted: if (pullDownMenu) _attachPullDownMenu(pullDownMenu)
}
