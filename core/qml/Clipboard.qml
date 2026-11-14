pragma Singleton
import QtQuick 2.0

QtObject {
    property string text: ""
    property bool hasText: text.length > 0
    function clear() { text = "" }
}
