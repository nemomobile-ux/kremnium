import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: root
    property int currentIndex: 0
    property var model
    property Component header
    property real tabBarHeight: headerLoader.item ? headerLoader.item.height : 0
    default property alias _data: content.data

    function moveTo(index, action) {
        if (index < 0) index = 0
        if (model && index >= model.length) index = model.length - 1
        currentIndex = index
    }

    onCurrentIndexChanged: {
        if (headerLoader.item && headerLoader.item.hasOwnProperty("currentIndex"))
            headerLoader.item.currentIndex = currentIndex
    }

    Loader {
        id: headerLoader
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        sourceComponent: root.header
        onLoaded: {
            if (item) {
                item.width = Qt.binding(function() { return root.width })
                if (item.hasOwnProperty("tabView")) item.tabView = root
                if (item.hasOwnProperty("currentIndex")) item.currentIndex = root.currentIndex
            }
        }
    }

    Item {
        id: contentArea
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: headerLoader.bottom
        anchors.bottom: parent.bottom

        Item { id: content; anchors.fill: parent }

        Repeater {
            model: root.model
            delegate: Loader {
                id: pageLoader
                anchors.fill: contentArea
                active: index === root.currentIndex
                visible: index === root.currentIndex
                sourceComponent: modelData
                onLoaded: {
                    if (item) {
                        if (item.hasOwnProperty("isCurrentItem"))
                            item.isCurrentItem = Qt.binding(function() { return root.currentIndex === index })
                    }
                }
                onVisibleChanged: if (item && item.hasOwnProperty("isCurrentItem")) item.isCurrentItem = visible
                Binding {
                    target: pageLoader.item
                    property: "anchors.fill"
                    value: pageLoader
                    when: pageLoader.item !== null
                }
            }
        }
    }
}
