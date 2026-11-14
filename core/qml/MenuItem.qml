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

MouseArea {
    id: root
    width: parent ? parent.width : implicitWidth
    implicitHeight: Theme.itemSizeSmall
    height: implicitHeight

    property alias text: menuItemText.text
    property string description
    property bool down: pressed && containsMouse
    property bool highlighted: down || activeHighlight
    property bool activeHighlight: false
    property color color: root.enabled ? (highlighted ? Theme.highlightColor : Theme.primaryColor) : Theme.secondaryColor

    signal delayedClick()

    onClicked: {
        delayedClick()
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.highlightBackgroundColor
        opacity: root.highlighted ? 0.3 : 0.0
    }

    Label {
        id: menuItemText
        anchors.centerIn: parent
        width: parent.width - Theme.horizontalPageMargin * 2
        horizontalAlignment: Text.AlignHCenter
        color: root.color
        elide: Text.ElideRight
    }
}
