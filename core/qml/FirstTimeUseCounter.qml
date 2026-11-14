import QtQuick 2.0

QtObject {
    property int count: 0
    property int limit: 1
    property bool active: false
    property string key: ""
    function increase() { count++ }
    function reset() { count = 0 }
}
