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

NemoPage {
    id: page

    readonly property double backGestureThreshold: Theme.itemSizeLarge > 0 ? Theme.itemSizeLarge : 64
    property int status: StackView.status
    property var headerTools
    property bool isPortrait: width <= height
    property bool isLandscape: !isPortrait
    property int orientation: isPortrait ? Qt.PortraitOrientation : Qt.LandscapeOrientation
    property int allowedOrientations: Qt.PortraitOrientation | Qt.LandscapeOrientation | Qt.InvertedPortraitOrientation | Qt.InvertedLandscapeOrientation
    property bool canNavigateForward: false
    property bool showNavigationIndicator: true
    property bool backNavigation: true
    property bool highContrast: false
    property color backgroundColor: "transparent"

    property var pageStack: {
        var w = page.Window.window
        var s = (w && w.pageStack) ? w.pageStack : (StackView.view ? StackView.view : null)
        if (!s) return null
        if (s.currentPage) return s
        // fallback proxy during initialization
        return {
            currentPage: page,
            depth: s.depth ? s.depth : 1,
            push: function(p, pr, op) { return s.push(p, pr, op) },
            pop: function(p, op) { return s.pop(p, op) },
            replace: function(p, pr, op) { return s.replace(p, pr, op) },
            clear: function() { return s.clear() },
            _stack: s
        }
    }

    default property alias __content: content.data

    clip: true

    headerTools: HeaderToolsLayout {
        showBackButton: true
        title: "Untitled"
    }

    Item {
        id: content
        anchors.fill: parent
        clip: true
    }
}
