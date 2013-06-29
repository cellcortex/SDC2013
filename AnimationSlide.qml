import QtQuick 2.0
import Qt.labs.presentation 1.0

// A slide that supports animation by transistioning through states - needs help from AnimationPresentation

Item {
    id: slide;
    visible: false
    width: parent.width
    height: parent.height

    property string notes
    property bool isSlide: true
    property var animationStates: []
    property int animationStep: 0
    property string transition: ""

    onVisibleChanged: {
        animationStep = 0;
        state = animationStates[0];
    }
}
