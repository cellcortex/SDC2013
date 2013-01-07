import QtQuick 2.0
import Qt.labs.presentation 1.0

Item {
    id: slide;
    visible: false
    anchors.fill: parent

    property string notes
    property bool isSlide: true
    property var animationStates: []
    property int animationStep: 0

    onVisibleChanged: {
        animationStep = 0;
        state = animationStates[0];
    }
}
