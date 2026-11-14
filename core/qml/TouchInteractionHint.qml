import QtQuick 2.0
import Sailfish.Silica 1.0
Item {
    property int direction: 0
    property int interactionMode: 0
    property var loops
    property bool running: false
    function start() { running = true }
    function stop() { running = false }
    function restart() { running = true }
}
