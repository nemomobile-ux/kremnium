import QtQuick 2.0
import Nemo.Controls

ProgressBar {
    id: progressBar
    property alias maximumValue: progressBar.to
    property alias minimumValue: progressBar.from
    property string label
    property string valueText
}
