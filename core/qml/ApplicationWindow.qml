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

    Loader {
        id: coverLoader
        anchors.fill: parent
        z: -2
        active: false
        visible: false
        source: (typeof applicationWindow.cover === "string" || applicationWindow.cover instanceof String) ? applicationWindow.cover : ""
    }

    // Component.onCompleted handled above to also sync Screen overrides

}
