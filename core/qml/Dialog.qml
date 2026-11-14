import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: root
    property bool canAccept: true
    property int acceptDestinationAction
    property var acceptDestination
    property var acceptDestinationProperties
    property int acceptDestinationInstance
    property bool acceptPending: false
    signal accepted()
    signal rejected()
    signal done()
    signal acceptBlocked()
    signal opened()

    function open(accept) { if (accept) accept(); }
    function accept() {
        if (!canAccept) { acceptBlocked(); return }
        accepted(); done(); if (pageStack) pageStack.pop()
    }
    function reject() { rejected(); done(); if (pageStack) pageStack.pop() }
    function close() { reject() }
}
