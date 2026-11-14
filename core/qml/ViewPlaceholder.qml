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
    property string text
    property string hintText
    property bool enabled: true
    property real verticalOffset
    property real horizontalOffset
    property alias flickable: root._flickable
    property var _flickable
    visible: enabled
    anchors.horizontalCenter: parent ? parent.horizontalCenter : undefined
    width: parent ? parent.width - Theme.horizontalPageMargin*2 : implicitWidth
    implicitHeight: column.implicitHeight
    height: implicitHeight

    Column {
        id: column
        width: parent.width
        spacing: Theme.paddingMedium
        Label {
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
            color: Theme.highlightColor
            font.pixelSize: Theme.fontSizeExtraLarge
            text: root.text
            visible: text.length > 0
        }
        Label {
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
            color: Theme.secondaryHighlightColor
            font.pixelSize: Theme.fontSizeSmall
            text: root.hintText
            visible: text.length > 0
        }
    }
}
