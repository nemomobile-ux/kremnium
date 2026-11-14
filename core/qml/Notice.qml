import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: root
    property string text
    property int duration: 2000
    property alias icon: iconItem
    property var anchor
    property int verticalOffset: 0
    property int horizontalOffset: 0
    signal clicked()
    visible: false
    Item { id: iconItem; property url source; property bool highlighted }
    function show(t) { if (t !== undefined) text = t; visible = true }
}
