import QtQuick 2.0
import Sailfish.Silica 1.0
MenuItem {
    id: root
    property string iconSource
    property alias icon: iconItem
    Item { id: iconItem; property url source: root.iconSource; property bool highlighted: root.highlighted }
}
