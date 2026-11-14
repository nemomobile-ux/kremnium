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

import QtQuick
import QtQuick.Controls

Item {
    id: root
    default property alias _content: menuColumn.data
    property bool active: visible
    property Item _parentItem
    signal closed()
    signal activated(int index)

    visible: false
    z: 1000
    width: parent ? parent.width : implicitWidth
    implicitHeight: menuColumn.implicitHeight + Theme.paddingSmall * 2
    height: implicitHeight

    Rectangle { anchors.fill: parent; color: Theme.highlightDimmerColor; opacity: 0.95 }

    Column {
        id: menuColumn
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: Theme.paddingSmall
        spacing: 0
    }

    function open(item) {
        _parentItem = item || parent
        visible = true
    }
    function close() {
        visible = false
        closed()
    }
    function show(item) { open(item) }
    function hide() { close() }

    // detect clicks on menu items to emit activated
    Component.onCompleted: {
        for (var i = 0; i < menuColumn.children.length; ++i) {
            (function(idx, child) {
                if (child && child.clicked !== undefined) {
                    var orig = child.clicked
                    child.clicked.connect(function() { root.activated(idx); root.close() })
                } else if (child && child.delayedClick !== undefined) {
                    child.delayedClick.connect(function() { root.activated(idx); root.close() })
                }
            })(i, menuColumn.children[i])
        }
    }
}
