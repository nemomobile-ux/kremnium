import QtQuick 2.0
import Sailfish.Silica 1.0
MenuItem {
    id: root
    property string iconSource
    property alias icon: iconImage
    Image {
        id: iconImage
        source: root.iconSource
        visible: false
        width: 0; height: 0
        property bool highlight: root.highlighted
    }
}
