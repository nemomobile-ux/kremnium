import QtQuick
import QtQuick.Controls
import Nemo
import Nemo.Controls
import Sailfish.Silica 1.0

Column {
    id: sliderItem

    height: slider.height + sliderlabel.height + valueLabel.height

    property alias maximumValue: slider.to
    property alias minimumValue: slider.from
    property alias stepSize: slider.stepSize
    property alias value: slider.value
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

    Slider{
        id: slider
        width: parent.width
        opacity: sliderItem.handleVisible ? 1.0 : 0.5
    }

    Label{
        id: sliderlabel
        width: parent.width
        horizontalAlignment: Text.AlignHCenter
        visible: text.length > 0
        color: sliderItem.labelColor
    }

    Label{
        id: valueLabel
        width: parent.width
        horizontalAlignment: Text.AlignHCenter
        visible: sliderItem.valueText.length > 0
        text: sliderItem.valueText
        color: sliderItem.valueTextColor
        font.pixelSize: Theme.fontSizeSmall
    }
}
