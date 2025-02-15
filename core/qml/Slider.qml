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

import Nemo
import Nemo.Controls

Column {
    id: sliderItem

    height: slider.height + sliderlabel.height

    property alias maximumValue: slider.to
    property alias minimumValue: slider.from
    property alias stepSize: slider.stepSize
    property alias value: slider.value

    property alias label: sliderlabel.text

    property string valueText

/*
https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-slider.html/

Properties
animateValue : bool
down : bool
enabled : bool
handleVisible : bool
highlighted : bool
label : string
maximumValue : real
minimumValue : real
sliderValue : real
stepSize : real
value : real
valueText : string
*/

    Slider{
        id: slider
        width: parent.width
    }

    Label{
        id: sliderlabel
        width: parent.width
        horizontalAlignment: Text.AlignHCenter
    }
}
