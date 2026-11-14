import QtQuick 2.0
import Sailfish.Silica 1.0
Column {
    id: root
    property int currentIndex: -1
    property bool animateToExpandedSection: true
    default property alias _content: root.data
    width: parent ? parent.width : implicitWidth
}
