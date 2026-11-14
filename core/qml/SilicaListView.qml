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

// NOT IMPLEMENTED!!!

import QtQuick 2.0
import Sailfish.Silica 1.0

SilicaFlickable {
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

    contentWidth: width
    contentHeight: listView.contentHeight

    ListView {
        id: listView
        anchors.fill: parent
        interactive: false
        boundsBehavior: Flickable.StopAtBounds
    }

    function positionViewAtIndex(index, mode) { listView.positionViewAtIndex(index, mode) }
    function positionViewAtBeginning() { listView.positionViewAtBeginning() }
    function positionViewAtEnd() { listView.positionViewAtEnd() }
    function indexAt(x, y) { return listView.indexAt(x - contentX, y - contentY) }
    function itemAt(x, y) { return listView.itemAt(x - contentX, y - contentY) }
}