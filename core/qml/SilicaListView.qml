import QtQuick 2.0
import Sailfish.Silica 1.0

Flickable {
    id: root

    property alias model: listView.model
    property alias delegate: listView.delegate
    property alias count: listView.count
    property alias currentIndex: listView.currentIndex
    property alias currentItem: listView.currentItem
    property alias section: listView.section
    property alias header: listView.header
    property alias footer: listView.footer
    property alias spacing: listView.spacing
    property alias orientation: listView.orientation
    property alias snapMode: listView.snapMode
    property alias highlight: listView.highlight
    property alias highlightFollowsCurrentItem: listView.highlightFollowsCurrentItem
    property alias verticalLayoutDirection: listView.verticalLayoutDirection
    property alias cacheBuffer: listView.cacheBuffer
    property alias displayMarginBeginning: listView.displayMarginBeginning
    property alias displayMarginEnd: listView.displayMarginEnd
    property alias add: listView.add
    property alias addDisplaced: listView.addDisplaced
    property alias displaced: listView.displaced
    property alias move: listView.move
    property alias moveDisplaced: listView.moveDisplaced
    property alias populate: listView.populate
    property alias remove: listView.remove
    property alias removeDisplaced: listView.removeDisplaced
    property alias highlightRangeMode: listView.highlightRangeMode
    property alias preferredHighlightBegin: listView.preferredHighlightBegin
    property alias preferredHighlightEnd: listView.preferredHighlightEnd

    property bool quickScroll: false
    property bool quickScrollAnimating: false
    property real quickScrollEnabled: quickScroll
    property Item pullDownMenu
    property Item pushUpMenu
    property QtObject _scrollAnimation
    property bool _pulleyDimmerActive: pullDownMenu && pullDownMenu._activeDimmer || pushUpMenu && pushUpMenu._activeDimmer

    default property alias _data: root.data

    contentWidth: width
    contentHeight: listView.contentHeight

    Item {
        id: listViewContainer
        width: parent.width
        height: listView.contentHeight

        ListView {
            id: listView
            anchors.fill: parent
            interactive: false
            boundsBehavior: Flickable.StopAtBounds
        }
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

    function positionViewAtIndex(index, mode) { listView.positionViewAtIndex(index, mode) }
    function positionViewAtBeginning() { listView.positionViewAtBeginning() }
    function positionViewAtEnd() { listView.positionViewAtEnd() }
    function indexAt(x, y) { return listView.indexAt(x - contentX, y - contentY) }
    function itemAt(x, y) { return listView.itemAt(x - contentX, y - contentY) }
    function scrollToTop() { contentY = 0 }
    function scrollToBottom() { contentY = Math.max(0, contentHeight - height) }
}
