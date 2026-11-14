pragma Singleton
import QtQuick 2.0

QtObject {
    function formatDate(date, format) { try { return Qt.formatDate(date, Qt.DefaultLocaleShortDate) } catch(e){ return ""+date } }
    function formatDateTime(date, format) { try { return Qt.formatDateTime(date) } catch(e){ return ""+date } }
    function formatTime(date, format) { try { return Qt.formatTime(date, Qt.DefaultLocaleShortDate) } catch(e){ return ""+date } }
    function durationText(duration) { return ""+duration }
    function timeValue(date) { try { return Qt.formatTime(date, "hh:mm") } catch(e){ return "" } }
    function timeElapsed(since) { return "" }
    function formatFileSize(bytes) { return bytes + " B" }
}
