import QtQuick 2.0

Item {
    property bool isSlide: true
    property string notes: ""
    property real fontSize: parent.height * 0.05
    visible: false
    property string transition: ""
    width: parent.width
    height: parent.height
}
