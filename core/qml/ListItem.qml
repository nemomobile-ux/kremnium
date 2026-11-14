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

BackgroundItem {
    id: listItem

    property real contentHeight: Theme.itemSizeSmall
    property Component menu
    property bool menuOpen: contextMenu !== null && (contextMenu.active || contextMenu.visible)
    property bool highlighted: down || menuOpen
    property var contextMenu: null
    property Item _menuItem: contextMenu

    implicitWidth: parent ? parent.width : Screen.width
    implicitHeight: contentHeight
    width: parent ? parent.width : implicitWidth
    height: contentHeight

    property bool _remorseActive: false

    function animateRemoval(callback) {
        _remorseActive = true
        removalAnim._cb = callback
        removalAnim.start()
    }

    SequentialAnimation {
        id: removalAnim
        property var _cb
        NumberAnimation { target: listItem; property: "height"; to: 0; duration: 200; easing.type: Easing.InOutQuad }
        ScriptAction { script: { if (removalAnim._cb) removalAnim._cb(); listItem._remorseActive = false } }
        PropertyAction { target: listItem; property: "height"; value: listItem.contentHeight }
    }

    function remorseAction(text, callback, timeout) {
        var t = "Deleted", cb = null, to = undefined
        if (typeof text === "function" || (text && text.trigger)) { cb = text; to = callback }
        else { t = text; cb = callback; to = timeout }
        return Remorse.itemAction(listItem, t, function() { listItem.animateRemoval(cb) }, to)
    }

    function remorseDelete(text, callback, timeout) {
        return remorseAction(text, callback, timeout)
    }

    function _openMenu() {
        if (!menu || contextMenu) return
        contextMenu = menu.createObject(listItem, { "item": listItem })
        if (contextMenu) {
            try { if (contextMenu.closed) contextMenu.closed.connect(function() { contextMenu = null }) } catch(e) {}
            try { if (contextMenu.open) contextMenu.open(listItem); else contextMenu.visible = true } catch(e) { contextMenu.visible = true }
        }
    }

    onPressAndHold: {
        _openMenu()
    }
}
