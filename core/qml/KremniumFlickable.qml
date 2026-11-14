//Imported from https://github.com/CODeRUS/better-sailfishos-qmltypes/blob/master/Sailfish/Silica/SilicaFlickable.qml

import QtQuick

Flickable {
    id: flick

    // API same as in SilicaWebView see also that.

    // Property quickScrollEnabled deprecated. Use quickScroll instead.
    //property alias quickScrollEnabled: quickScrollItem.quickScroll
    //property alias quickScroll: quickScrollItem.quickScroll
    //property alias quickScrollAnimating: quickScrollItem.quickScrollAnimating
    //property alias quickScrollVisible: quickScrollItem.quickScrollVisible
    property Item pullDownMenu
    property Item pushUpMenu
    property QtObject _scrollAnimation
    property bool _pulleyDimmerActive: pullDownMenu && pullDownMenu._activeDimmer || pushUpMenu && pushUpMenu._activeDimmer
    //property alias _quickScrollItem: quickScrollItem
    readonly property Item pageStack: {
        var w = flick.Window.window
        return (w && w.pageStack) ? w.pageStack : null
    }

    default property alias _contentData: contentColumn.data

    topMargin: 0
    bottomMargin: 0

    Item {
        id: contentColumn
        width: flick.contentWidth > 0 ? flick.contentWidth : flick.width
        height: childrenRect.height
    }
    contentWidth: width
    contentHeight: contentColumn.height

    function _attachPullDownMenu(menu) {
        if (!menu) return
        if (menu.parent !== flick.contentItem)
            menu.parent = flick.contentItem
        menu.anchors.left = undefined
        menu.anchors.right = undefined
        menu.width = Qt.binding(function() { return flick.width })
        menu.y = Qt.binding(function() { return -menu.height })
        menu.z = 200
        if (menu.hasOwnProperty("flickable"))
            menu.flickable = flick
    }

    onPullDownMenuChanged: _attachPullDownMenu(pullDownMenu)
    Component.onCompleted: if (pullDownMenu) _attachPullDownMenu(pullDownMenu)

    function scrollToTop() {
        FastScroll.scrollToTop(flick, quickScrollItem)
    }
    function scrollToBottom() {
        FastScroll.scrollToBottom(flick, quickScrollItem)
    }

    pixelAligned: true
    flickDeceleration: Theme.flickDeceleration
    maximumFlickVelocity: Theme.maximumFlickVelocity
    boundsBehavior: (pullDownMenu && pullDownMenu._activationPermitted) || (pushUpMenu && pushUpMenu._activationPermitted)
                    ? Flickable.DragOverBounds : Flickable.StopAtBounds

    // flickableDirection must always include VerticalFlick if a menu is set
    flickableDirection: (pullDownMenu != null || pushUpMenu != null)
                        ? ((contentWidth >= 0 && contentWidth != width) ? Flickable.HorizontalAndVerticalFlick
                                                                        : Flickable.VerticalFlick)
                        : Flickable.AutoFlickDirection

    //BoundsBehavior { flickable: flick }
    /*QuickScroll {
        id: quickScrollItem
        flickable: flick
    }*/
}
