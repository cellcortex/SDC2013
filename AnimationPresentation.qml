import QtQuick 2.0
import Qt.labs.presentation 1.0

// based on the example AnimationPresentation in qt presentation system
Presentation {

    id: deck

    textColor: "white"

    property bool inTransition: false;

    // Use Empty Object here so we don't get illegal assignment warnings in transitions
    property variant fromSlide: QtObject {}
    property variant toSlide: QtObject {}

    property int transitionTime: 500;

    SequentialAnimation {
        id: forwardTransition
        running: false
        PropertyAction { target: deck; property: "inTransition"; value: true }
        PropertyAction { target: toSlide; property: "visible"; value: true }
        PropertyAction { target: deck; property: "y"; value: 0 }
        PropertyAction { target: deck; property: "x"; value: 0 }
        ParallelAnimation {
            NumberAnimation { target: fromSlide; property: "opacity"; from: 1; to: 0; duration: deck.transitionTime; easing.type: Easing.OutQuart }
            NumberAnimation { target: fromSlide; property: "scale"; from: 1; to: 1.1; duration: deck.transitionTime; easing.type: Easing.InOutQuart }
            NumberAnimation { target: toSlide; property: "opacity"; from: 0; to: 1; duration: deck.transitionTime; easing.type: Easing.InQuart }
            NumberAnimation { target: toSlide; property: "scale"; from: 0.7; to: 1; duration: deck.transitionTime; easing.type: Easing.InOutQuart }
        }
        PropertyAction { target: fromSlide; property: "visible"; value: false }
        PropertyAction { target: fromSlide; property: "scale"; value: 1 }
        PropertyAction { target: deck; property: "inTransition"; value: false }
        PropertyAction { target: toSlide; property: "focus"; value: true }
    }
    SequentialAnimation {
        id: backwardTransition
        running: false
        PropertyAction { target: deck; property: "inTransition"; value: true }
        PropertyAction { target: toSlide; property: "visible"; value: true }
        PropertyAction { target: deck; property: "y"; value: 0 }
        PropertyAction { target: deck; property: "x"; value: 0 }
        ParallelAnimation {
            NumberAnimation { target: fromSlide; property: "opacity"; from: 1; to: 0; duration: deck.transitionTime; easing.type: Easing.OutQuart }
            NumberAnimation { target: fromSlide; property: "scale"; from: 1; to: 0.7; duration: deck.transitionTime; easing.type: Easing.InOutQuart }
            NumberAnimation { target: toSlide; property: "opacity"; from: 0; to: 1; duration: deck.transitionTime; easing.type: Easing.InQuart }
            NumberAnimation { target: toSlide; property: "scale"; from: 1.1; to: 1; duration: deck.transitionTime; easing.type: Easing.InOutQuart }
        }
        PropertyAction { target: fromSlide; property: "visible"; value: false }
        PropertyAction { target: fromSlide; property: "scale"; value: 1 }
        PropertyAction { target: deck; property: "inTransition"; value: false }
        PropertyAction { target: toSlide; property: "focus"; value: true }
    }
    SequentialAnimation {
        id: pushUpTransition
        running: false
        PropertyAction { target: deck; property: "inTransition"; value: true }
        PropertyAction { target: toSlide; property: "visible"; value: true }
        PropertyAction { target: toSlide; property: "y"; value: deck.height }
        PropertyAction { target: deck; property: "x"; value: 0 }
        ParallelAnimation {
            NumberAnimation { target: deck; property: "y"; from: 0; to: -deck.height; duration: 200; easing.type: Easing.InOutQuad }
        }
        PropertyAction { target: fromSlide; property: "visible"; value: false }
        PropertyAction { target: toSlide; property: "y"; value: 0 }
        PropertyAction { target: deck; property: "y"; value: 0 }
        PropertyAction { target: deck; property: "inTransition"; value: false }
        PropertyAction { target: toSlide; property: "focus"; value: true }
    }
    SequentialAnimation {
        id: pushDownTransition
        running: false
        PropertyAction { target: deck; property: "inTransition"; value: true }
        PropertyAction { target: toSlide; property: "visible"; value: true }
        PropertyAction { target: toSlide; property: "y"; value: -deck.height }
        PropertyAction { target: deck; property: "x"; value: 0 }
        ParallelAnimation {
            NumberAnimation { target: deck; property: "y"; from: 0; to: deck.height; duration: 200; easing.type: Easing.InOutQuad }
        }
        PropertyAction { target: fromSlide; property: "visible"; value: false }
        PropertyAction { target: toSlide; property: "y"; value: 0 }
        PropertyAction { target: deck; property: "y"; value: 0 }
        PropertyAction { target: deck; property: "inTransition"; value: false }
        PropertyAction { target: toSlide; property: "focus"; value: true }
    }
    SequentialAnimation {
        id: pushRightTransition
        running: false
        PropertyAction { target: deck; property: "inTransition"; value: true }
        PropertyAction { target: toSlide; property: "visible"; value: true }
        PropertyAction { target: toSlide; property: "x"; value: deck.width }
        PropertyAction { target: deck; property: "x"; value: 0 }
        ParallelAnimation {
            NumberAnimation { target: deck; property: "x"; from: 0; to: -deck.width; duration: 600; easing.type: Easing.InOutQuad }
        }
        PropertyAction { target: fromSlide; property: "visible"; value: false }
        PropertyAction { target: toSlide; property: "x"; value: 0 }
        PropertyAction { target: deck; property: "x"; value: 0 }
        PropertyAction { target: deck; property: "inTransition"; value: false }
        PropertyAction { target: toSlide; property: "focus"; value: true }
    }
    SequentialAnimation {
        id: pushLeftTransition
        running: false
        PropertyAction { target: deck; property: "inTransition"; value: true }
        PropertyAction { target: toSlide; property: "visible"; value: true }
        PropertyAction { target: toSlide; property: "x"; value: -deck.width }
        ParallelAnimation {
            NumberAnimation { target: deck; property: "x"; from: 0; to: deck.width; duration: 600; easing.type: Easing.InOutQuad }
        }
        PropertyAction { target: fromSlide; property: "visible"; value: false }
        PropertyAction { target: toSlide; property: "x"; value: 0 }
        PropertyAction { target: deck; property: "x"; value: 0 }
        PropertyAction { target: deck; property: "inTransition"; value: false }
        PropertyAction { target: toSlide; property: "focus"; value: true }
    }
    function switchSlides(from, to, forward)
    {
        if (deck.inTransition)
            return false

        deck.fromSlide = from
        deck.toSlide = to

        //console.log("Switching ", from, to);

        if (forward) {
            if (to.transition === "pushup") {
                pushUpTransition.running = true;
            } else if (to.transition === "pushright") {
                pushRightTransition.running  = true;
            } else {
                forwardTransition.running = true;
            }
        }
        else
            if (from.transition === "pushup") {
                pushDownTransition.running = true;
            } else if (from.transition === "pushright") {
                pushLeftTransition.running = true;
            } else {
                backwardTransition.running = true
            }

        return true
    }

    function goToNextSlide() {
        deck._userNum = 0;
        if (_faded)
            return
        var s = slides[currentSlide];
        if (deck.inTransition)
            return false;
        if (s.animationStates && s.animationStates.length-1 > s.animationStep) {
            s.animationStep += 1;
            s.state = s.animationStates[s.animationStep];
            return;
        }

        if (deck.currentSlide + 1 < deck.slides.length) {
            var from = slides[currentSlide]
            var to = slides[currentSlide + 1]
            if (switchSlides(from, to, true)) {
                currentSlide = currentSlide + 1;
                deck.focus = true;
            }
        }
    }
}
