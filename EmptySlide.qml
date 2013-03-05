import QtQuick 2.0
// a very simple slide. Overrides the 'Slide' from presentation system which is too heavy for me
Item {
    property bool isSlide: true
    property string notes: ""
    property real fontSize: parent.height * 0.05
    visible: false
    property string transition: ""
    width: parent.width
    height: parent.height
}
