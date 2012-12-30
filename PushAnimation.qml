import QtQuick 2.0

Item {
  id: pushAnimation
  anchors.fill: parent
  property int from
  property int to
  property int duration: 500
  property variant slideContainer
  property bool scrollRight: to > from
  property variant fromSlide: slideContainer.children[from]
  property variant toSlide: slideContainer.children[to]
  property alias running: ani.running

  SequentialAnimation {
    id: ani
    ScriptAction {
      script: {
        fromSlide.timeRunning = false;
        toSlide.anchors.left = undefined
        toSlide.anchors.right = undefined
        toSlide.x = pushAnimation.width * (scrollRight ? 1 : -1);
        toSlide.visible = true;
        fromSlide.width = pushAnimation.width;
        toSlide.width = pushAnimation.width;
        if (scrollRight) {
          fromSlide.anchors.right = toSlide.left;
          fromSlide.anchors.left = undefined;
          fromSlide.width = pushAnimation.width
        } else {
          fromSlide.anchors.left = toSlide.right;
          fromSlide.anchors.right = undefined;
        
        }
      }
    }
    PropertyAnimation {
      duration: pushAnimation.duration
      property: "x"
      easing.type: Easing.InQuad
      target: toSlide
      to: 0
    }
    ScriptAction {
      script: {
        fromSlide.visible = false;
        toSlide.timeRunning = true;
      }
    }
  }
}
