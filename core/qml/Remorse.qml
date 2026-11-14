pragma Singleton
import QtQuick 2.0

QtObject {
    id: root

    property string deletedText: "Deleted"

    function _exec(callback) {
        if (callback !== undefined && callback !== null) {
            if (typeof callback === "function") callback()
            else if (callback.trigger) callback.trigger()
        }
    }

    function _make(parent, text, callback, timeout) {
        var ms = (timeout !== undefined && timeout !== null && timeout > 0) ? timeout : 2500
        var obj = Qt.createQmlObject('import QtQuick 2.0; QtObject { id: o; signal canceled(); signal triggered(); property bool _done: false; property var _cb; property Timer _t: Timer { interval: 2500; repeat: false; onTriggered: o.trigger() } function trigger() { if (_done) return; _done = true; _t.stop(); triggered(); if (_cb) { if (typeof _cb === "function") _cb(); else if (_cb.trigger) _cb.trigger(); } } function cancel() { if (_done) return; _done = true; _t.stop(); canceled() } function execute() { trigger() } Component.onCompleted: _t.start() }', parent ? parent : root, "RemorseObj")
        obj._cb = callback
        obj._t.interval = ms
        return obj
    }

    function popupAction(page, text, callback, timeout) {
        return _make(page, text, callback, timeout)
    }

    function itemAction(item, text, callback, timeout) {
        return _make(item, text, callback, timeout)
    }
}
