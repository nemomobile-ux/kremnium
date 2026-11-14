/*
 * Copyright (C) 2025 Chupligin Sergey <neochapay@gmail.com>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public License
 * along with this library; see the file COPYING.LIB.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301, USA.
 */

import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Window 2.0

import Nemo
import Nemo.Controls

NemoWindow {
    id: applicationWindow

    property var cover
    property var initialPage
    property Item mainPage
    property int allowedOrientations: Qt.PortraitOrientation | Qt.LandscapeOrientation | Qt.InvertedPortraitOrientation | Qt.InvertedLandscapeOrientation
    property int defaultAllowedOrientations: allowedOrientations
    property int _defaultPageOrientations: 15 // Orientation.All
    property int _defaultLabelFormat: Text.AutoText
    property real bottomMargin: 0
    property alias contentItem: content

    // Silica-like page stack wrapper
    property alias pageStack: pageStackItem

    visible: true
    width: 540
    height: 960

    property bool _screenSync: {
        if (Screen && Screen._overrideWidth !== undefined) {
            Screen._overrideWidth = width
            Screen._overrideHeight = height
        }
        return true
    }

    onWidthChanged: if (Screen && Screen._overrideWidth !== undefined) Screen._overrideWidth = width
    onHeightChanged: if (Screen && Screen._overrideHeight !== undefined) Screen._overrideHeight = height
    Component.onCompleted: {
        if (Screen && Screen._overrideWidth !== undefined) {
            Screen._overrideWidth = width
            Screen._overrideHeight = height
        }
        if (initialPage) {
            pageStackItem.push(initialPage)
        }
    }

    Rectangle {
        id: background
        anchors.fill: parent
        z: -1
        color: Theme.backgroundColor
    }

    Item {
        id: pageStackItem
        anchors.fill: parent

        property alias depth: stackView.depth
        property Item currentPage: stackView.currentItem
        property alias busy: stackView.busy

        function _makeAnimator(resultItem) {
            var obj = Qt.createQmlObject('import QtQuick 2.0; QtObject { signal pageCompleted(var page); property var page: null }', pageStackItem, "PageStackAnimator")
            obj.page = resultItem
            Qt.callLater(function() {
                try { obj.pageCompleted(resultItem ? resultItem : stackView.currentItem) } catch(e) {}
                try { obj.destroy(5000) } catch(e) {}
            })
            return obj
        }

        function push(page, properties, operation) {
            var item = stackView.push(page, properties === undefined ? {} : properties, operation)
            pageStackItem.currentPage = stackView.currentItem
            return item
        }
        function pop(page, operation) {
            var item = stackView.pop(page, operation)
            pageStackItem.currentPage = stackView.currentItem
            return item
        }
        function replace(page, properties, operation) {
            var item = stackView.replace(page, properties === undefined ? {} : properties, operation)
            pageStackItem.currentPage = stackView.currentItem
            return item
        }
        function clear() {
            stackView.clear()
            pageStackItem.currentPage = null
        }
        function animatorPush(page, properties, operation) {
            var item = push(page, properties, operation)
            return _makeAnimator(item ? item : stackView.currentItem)
        }
        function animatorPop(page, operation) {
            var item = pop(page, operation)
            return _makeAnimator(stackView.currentItem)
        }
        function animatorReplace(page, properties, operation) {
            var item = replace(page, properties, operation)
            return _makeAnimator(item ? item : stackView.currentItem)
        }

        property var _attachedPage: null
        property var _currentContainer: ({ attachedContainer: null })

        function pushAttached(page, properties) {
            _attachedPage = page
            return page
        }
        function popAttached(page, operation) {
            _attachedPage = null
            return null
        }
        function navigateForward(operation) {
            // minimal: try to push attached page if present
            if (_attachedPage) {
                var p = _attachedPage
                _attachedPage = null
                return push(p, {}, operation)
            }
            return null
        }
        function navigateBack(operation) {
            return pop(undefined, operation)
        }
        property Item previousPage: depth > 1 ? null : null
        property Item nextPage: _attachedPage ? null : null

        function completeAnimation() { }
        function _emitPageStackBusyChanged() { }

        StackView {
            id: stackView
            anchors.fill: parent
            focus: true

            onCurrentItemChanged: pageStackItem.currentPage = currentItem
            Component.onCompleted: pageStackItem.currentPage = currentItem
        }

        Item {
            id: content
            anchors.fill: stackView
        }
    }

    Item {
        id: coverHost
        anchors.fill: parent
        z: -2
        visible: false

        Loader {
            id: coverLoader
            anchors.fill: parent
            active: applicationWindow.cover !== null && applicationWindow.cover !== undefined && (typeof applicationWindow.cover === "string" || applicationWindow.cover instanceof String || !!(applicationWindow.cover && applicationWindow.cover.createObject))
            sourceComponent: (applicationWindow.cover && applicationWindow.cover.createObject) ? applicationWindow.cover : null
            source: (typeof applicationWindow.cover === "string" || applicationWindow.cover instanceof String) ? applicationWindow.cover : ""
            onLoaded: {
                if (item) {
                    item.visible = true
                }
            }
        }
    }

    onCoverChanged: {
        // if cover is an Item instance, reparent into host
        if (cover && cover !== null && typeof cover === "object" && !cover.createObject && !(typeof cover === "string" || cover instanceof String)) {
            try {
                if (cover.parent !== coverHost) cover.parent = coverHost
                cover.anchors.fill = coverHost
                cover.visible = true
            } catch(e) {}
        }
    }

    // Component.onCompleted handled above to also sync Screen overrides

}
