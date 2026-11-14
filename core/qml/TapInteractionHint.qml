import QtQuick 2.0
import Sailfish.Silica 1.0
Item {
    property var loops
    property bool running: false
    property Item target
    function start() { running = true }
    function stop() { running = false }
    function restart() { running = true }
}
