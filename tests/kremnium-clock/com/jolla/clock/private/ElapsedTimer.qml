import QtQuick 2.0
QtObject {
    property int elapsed: 0
    function start() {}
    function restart() { return 0 }
    function reset() { elapsed = 0 }
    function getMilliseconds() { return 0 }
}
