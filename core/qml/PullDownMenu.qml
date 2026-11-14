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
import Sailfish.Silica 1.0

Item {
    id: root
    default property alias _content: menuColumn.data

    property bool active: false
    property bool quickSelect: false
    property bool busy: false
    property string hintText
    property bool _activationPermitted: true
    property bool _activeDimmer: active
    property Flickable flickable: null
    property real _displayHeight: menuColumn.implicitHeight + Theme.paddingLarge * 2
    property Item _highlightedItem: null

    z: 200
    width: flickable ? flickable.width : (parent ? parent.width : implicitWidth)
    implicitHeight: _displayHeight
    height: implicitHeight
    visible: flickable ? (active || flickable.dragging || flickable.contentY < -1) : true

    function _menuItems() {
        var items = []
        for (var i = 0; i < menuColumn.children.length; ++i) {
            var c = menuColumn.children[i]
            if (c && c.visible && c.enabled !== false && c.height > 0 && c.hasOwnProperty("text"))
                items.push(c)
        }
        return items
    }

    function _updateHighlight() {
        if (!flickable) return
        var pull = -flickable.contentY
        var items = _menuItems()
        if (!active || items.length === 0 || pull < Theme.itemSizeSmall * 0.5) {
            _highlightedItem = null
            for (var j = 0; j < items.length; ++j)
                if (items[j].hasOwnProperty("activeHighlight")) items[j].activeHighlight = false
            return
        }
        var yInMenu = pull - Theme.paddingLarge
        var idx = Math.floor(yInMenu / Math.max(1, menuColumn.implicitHeight) * items.length)
        if (idx < 0) idx = 0
        if (idx >= items.length) idx = items.length - 1
        _highlightedItem = items[idx]
        for (var k = 0; k < items.length; ++k)
            if (items[k].hasOwnProperty("activeHighlight")) items[k].activeHighlight = (items[k] === _highlightedItem)
    }

    function _activate() {
        if (_highlightedItem) {
            if (_highlightedItem.delayedClick)
                _highlightedItem.delayedClick()
        }
        active = false
        _highlightedItem = null
        _updateHighlight()
    }

    Connections {
        target: flickable
        function onContentYChanged() { root._updateHighlight() }
        function onDraggingChanged() {
            if (!flickable) return
            if (flickable.dragging) {
                if (flickable.contentY < -Theme.itemSizeSmall * 0.5)
                    root.active = true
            } else {
                if (root.active && -flickable.contentY > Theme.itemSizeSmall * 0.6)
                    root._activate()
                else {
                    root.active = false
                    root._highlightedItem = null
                    root._updateHighlight()
                }
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.highlightDimmerColor
        opacity: 0.95
    }

    Column {
        id: menuColumn
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: Theme.paddingLarge
        spacing: Theme.paddingSmall
    }

    // Peek label when pulling
    Label {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Theme.paddingSmall
        visible: flickable && flickable.contentY < -2 && !active
        text: "↓"
        color: Theme.secondaryHighlightColor
        font.pixelSize: Theme.fontSizeSmall
    }

    Component.onCompleted: {
        var p = parent
        while (p) {
            if (p.hasOwnProperty("pullDownMenu") && p.hasOwnProperty("contentY")) {
                p.pullDownMenu = root
                flickable = p
                if (p._attachPullDownMenu) p._attachPullDownMenu(root)
                break
            }
            p = p.parent
        }
    }

    // Allow direct interaction fallback: clicking/tapping an item should work when menu is on screen
    function show() {
        if (flickable) {
            active = true
            flickable.contentY = -height
        }
    }
    function hide() {
        active = false
        _highlightedItem = null
        _updateHighlight()
        if (flickable) flickable.contentY = 0
    }
}
