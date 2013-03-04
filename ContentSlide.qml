import QtQuick 2.0

EmptySlide {
    id: slide
    property string title
    property string content
    property alias titleBox: qttitle
    Rectangle {
        id: qttitle
        color: "#77000000"
        anchors { left: parent.left; right: parent.right; top: parent.top }
        height: parent.height * 1 / 3
        Text {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 100
            height: slide.height / 12
            color: "#333333"
            text: title
            font.pixelSize: qttitle.height / 4
            font.family: headFont.name
        }
    }
    Text {
        anchors.top: qttitle.bottom
        //anchors.leftMargin: parent.width / 20
        anchors.topMargin: parent.height * .05
        anchors.left: parent.left
        textFormat: Text.StyledText
        lineHeight: 1.5
        text: content
        font.pixelSize: parent.height * 0.05
        font.weight: Font.Light
        font.family: presentation.fontFamily
        color: "#777777"
    }
}
