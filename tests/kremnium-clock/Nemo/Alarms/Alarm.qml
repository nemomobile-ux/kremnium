import QtQuick 2.0

QtObject {
    id: alarm
    property string title: ""
    property int hour: 0
    property int minute: 0
    property int hourMode: 0
    property int daysOfWeek: 0
    property bool enabled: false
    property var triggerTime: 0
    property var endTime: 0
    property int elapsed: 0
    property int countdown: 0
    property bool repeat: false
    property string cookie: ""
    property var calendarEvent
    property int type: 0
    property bool playing: false
    property string sound: ""

    signal updated()
    signal saved()

    function save() { saved(); updated() }
    function deleteAlarm() { }
    function reset() { elapsed = 0; triggerTime = 0 }
    function snooze() { }
    function dismiss() { }
}
