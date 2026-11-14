import QtQuick 2.0

NumberAnimation {
    property string easing: "InOutQuad"
    property var target
    duration: 200
    property: "opacity"
}
