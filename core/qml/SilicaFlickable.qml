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
