import QtQuick
import Nemo.Controls

ProgressBar {
    id: progressBar
    property alias maximumValue: progressBar.to
    property alias minimumValue: progressBar.from

}
