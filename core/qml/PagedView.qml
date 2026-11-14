import QtQuick 2.0
import Sailfish.Silica 1.0
Item {
    id: root
    property var model
    property Component delegate
    property int currentIndex: 0
    property bool interactive: true
    default property alias _data: content.data
    Item { id: content; anchors.fill: parent }
    Loader {
        anchors.fill: parent
        sourceComponent: (model && model.count !== undefined && currentIndex < model.count) ? delegate : null
    }
}
