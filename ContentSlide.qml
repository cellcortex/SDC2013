import QtQuick 2.0

EmptySlide {
    id: slide
    property string title
    property string content
    Rectangle {
        id: qttitle
        color: "#77000000"
        anchors { left: parent.left; right: parent.right; top: parent.top }
        height: parent.height * 1 / 3
        /*Image {
            id: qtlogo
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.margins: parent.width / 20
            height: parent.height * .8
            fillMode: Image.PreserveAspectFit
            source: "pictures/Qt-logo.png"
        }*/
        Text {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 100
            height: slide.height / 12
            color: "#33ffffff"
            text: title
            font.pixelSize: qttitle.height / 4
            font.family: "Impact"
        }
    }
    Text {
        anchors.top: qttitle.bottom
        //anchors.leftMargin: parent.width / 20
        anchors.topMargin: parent.height * .05
        anchors.left: parent.left
        textFormat: Text.StyledText
        text: content
        font.pixelSize: parent.height * 0.05
        font.weight: Font.Light
        font.family: presentation.fontFamily
        color: "#77ffffff"
    }
}
