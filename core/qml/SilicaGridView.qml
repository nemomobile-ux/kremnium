import QtQuick 2.0
import Sailfish.Silica 1.0

SilicaFlickable {
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
    contentWidth: width
    contentHeight: gridView.contentHeight
    GridView {
        id: gridView
        anchors.fill: parent
        interactive: false
        clip: true
    }
}
