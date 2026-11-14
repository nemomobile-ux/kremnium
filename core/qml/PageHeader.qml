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

Rectangle {
    id: root
    property alias title: labelText.text
    property alias description: descriptionLabel.text
    property alias extraContent: extraContentItem.children

    implicitHeight: Theme.itemSizeLarge
    height: implicitHeight
    width: parent ? parent.width : implicitWidth
    clip: true

    color: Theme.overlayBackgroundColor

    Label {
        id: labelText
        anchors {
            right: parent.right
            rightMargin: Theme.horizontalPageMargin
            verticalCenter: parent.verticalCenter
        }
        width: parent.width - Theme.horizontalPageMargin * 2 - extraContentItem.width
        horizontalAlignment: Text.AlignRight
        color: Theme.highlightColor
        font.pixelSize: Theme.fontSizeLarge
        elide: Text.ElideRight
    }

    Label {
        id: descriptionLabel
        anchors {
            right: parent.right
            rightMargin: Theme.horizontalPageMargin
            top: labelText.bottom
        }
        visible: text.length > 0
        color: Theme.secondaryHighlightColor
        font.pixelSize: Theme.fontSizeSmall
    }

    Item {
        id: extraContentItem
        anchors {
            left: parent.left
            leftMargin: Theme.horizontalPageMargin
            verticalCenter: parent.verticalCenter
        }
        width: childrenRect.width
        height: childrenRect.height
    }
}
