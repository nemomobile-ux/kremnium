import QtQuick 2.0
import Sailfish.Silica 1.0

Flow {
    id: root
    property int preferredWidth: Theme.buttonWidthMedium
    spacing: Theme.paddingMedium
    width: parent ? parent.width : implicitWidth
}
