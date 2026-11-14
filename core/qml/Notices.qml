pragma Singleton
import QtQuick 2.0
import Sailfish.Silica 1.0

QtObject {
    id: root
    function show(text, duration, anchor) {
        console.log("Notice:", text)
    }
}
