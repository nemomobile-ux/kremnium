import QtQuick 2.0
import QtQuick.Controls 2.0 as QQC2
import Nemo
import Nemo.Controls as NemoControls
import Sailfish.Silica 1.0

Item {
    id: sliderItem

    implicitHeight: slider.implicitHeight + (sliderlabel.visible ? sliderlabel.implicitHeight : 0) + (valueLabel.visible ? valueLabel.implicitHeight : 0)
    height: implicitHeight

    property real maximumValue: 1.0
    property real minimumValue: 0.0
    property real stepSize: 0.0
    property real value: 0.0
    property real sliderValue: value

    property alias label: sliderlabel.text
    property string valueText
    property bool handleVisible: true
    property bool down: slider.pressed
    property bool highlighted: down
    property bool animateValue: false
    property color valueTextColor: (Theme && Theme.secondaryHighlightColor) ? Theme.secondaryHighlightColor : "#b0ffffff"
    property color labelColor: (Theme && Theme.highlightColor) ? Theme.highlightColor : "#ffffff"

    signal clicked()

    NemoControls.Slider {
        id: slider
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        opacity: sliderItem.handleVisible ? 1.0 : 0.5
        from: sliderItem.minimumValue
        to: sliderItem.maximumValue
        stepSize: sliderItem.stepSize
        value: sliderItem.value
        onValueChanged: {
            if (sliderItem.value !== value) sliderItem.value = value
        }
    }

    onMinimumValueChanged: if (slider.from !== minimumValue) slider.from = minimumValue
    onMaximumValueChanged: if (slider.to !== maximumValue) slider.to = maximumValue
    onStepSizeChanged: if (slider.stepSize !== stepSize) slider.stepSize = stepSize
    onValueChanged: {
        if (value === undefined || isNaN(Number(value))) {
            sliderItem.value = 0
            return
        }
        if (slider.value !== value) slider.value = value
    }

    Component.onCompleted: {
        if (sliderItem.value === undefined || isNaN(Number(sliderItem.value))) sliderItem.value = 0
        slider.from = sliderItem.minimumValue
        slider.to = sliderItem.maximumValue
        slider.stepSize = sliderItem.stepSize
        slider.value = sliderItem.value
    }

    Label {
        id: sliderlabel
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: slider.bottom
        horizontalAlignment: Text.AlignHCenter
        visible: text.length > 0
        color: sliderItem.labelColor
    }

    Label {
        id: valueLabel
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: sliderlabel.visible ? sliderlabel.bottom : slider.bottom
        horizontalAlignment: Text.AlignHCenter
        visible: sliderItem.valueText.length > 0
        text: sliderItem.valueText
        color: sliderItem.valueTextColor
        font.pixelSize: Theme.fontSizeSmall
    }
}
