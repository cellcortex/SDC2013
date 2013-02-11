import QtQuick 2.0

Rectangle {
    color: "#77000000"
    anchors { left: parent.left; right: parent.right; bottom: parent.bottom }
    height: link.height * 2
    width: link.width * 1
    property alias text: link.text
    Text {
        id: link
        anchors.centerIn: parent
        color: "#444444"
        font.pixelSize: presentation.height / 30
        font.family: presentation.fontFamily
    }
}
