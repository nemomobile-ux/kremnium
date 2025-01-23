import QtQuick 2.2
import Sailfish.Silica 1.0

ApplicationWindow {
    initialPage: Component {
        Page {
            Column {
                width: parent.width

                // an interactive slider with a 0-100 range that steps by 1 when slided.
                Slider {
                    id: slider
                    label: "A simple slider"
                    width: parent.width
                    minimumValue: 0; maximumValue: 100; stepSize: 1
                    valueText: value
                }

                Button {
                    text: "Save"
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked: {
                        listModel.append({"sliderValue": "Value: " + slider.value})
                    }
                }

                Repeater {
                    model: ListModel { id: listModel }

                    Label { text: model.sliderValue }
                }
            }
        }
    }
}
