import QtQuick 2.0

Rectangle {
    color: "black"
    width: 1024
    height: 768

    //Image { source: "console.png"; scale: 1280/1920; anchors.centerIn: parent } // Simulate startup screen

    MouseArea {
        anchors.fill: parent
        onClicked: {
            fs.focus = true
        }
    }

    MouseArea {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        width: 2
        height: 2
        hoverEnabled: true
        onEntered: {
            fs.focus = true
        }
        z: 10
    }

    FocusScope {
        id: fs
        focus: true
        clip: true
        anchors.fill: parent
        Talk {
            anchors.centerIn: parent
            width: 1920
            height: 1080
            scale: 1024/1920
            id: background
            focus: true
            clip: true
        }
    }
}
