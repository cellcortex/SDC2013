import QtQuick 2.0
import Qt.labs.presentation 1.0


Slide {
    id: slide;

    property string codeFontFamily: parent.codeFontFamily
    property string code
    property string cheatedCode
    property real codeFontSize: baseFontSize * 0.6
    property bool autointerpret: true

    property bool editorFocus: false

    onVisibleChanged: {
        scope.focus = true;
        editorFocus = slide.visible;
        //editor.forceActiveFocus();
    }

    onFocusChanged: {
        console.log("Slide Focus: ", slide.focus);
        if (slide.focus && editorFocus) {
            editor.forceActiveFocus();
        }
    }

    FocusScope {
        id: scope
        anchors.fill: parent
        clip: true
        Item {
            property Item test;
            id: testparent
            anchors.fill: parent
        }

        Rectangle {
            id: background
            anchors.fill: parent
            radius: height / 10;
            gradient: Gradient {
                GradientStop { position: 0; color: Qt.rgba(0.8, 0.8, 0.8, 0.5); }
                GradientStop { position: 1; color: Qt.rgba(0.2, 0.2, 0.2, 0.5); }
            }
            border.color: slide.textColor;
            border.width: height / 250;
            antialiasing: true
        }
        Flickable {
            id: flick
            opacity: 1
            Behavior on opacity { NumberAnimation { duration: 300 } }
            anchors.fill: parent
            contentWidth: background.width
            contentHeight: background.height
            z: 100
            Behavior on contentX { SpringAnimation {spring: 2; damping: 0.2 } }
            Behavior on contentY { SpringAnimation {spring: 2; damping: 0.2 } }
            function ensureVisible(r)
            {
                if (contentX >= r.x)
                    contentX = r.x;
                else if (contentX+width <= r.x+r.width)
                    contentX = r.x+r.width-width;
                if (contentY >= r.y)
                    contentY = r.y;
                else if (contentY+height <= r.y+r.height)
                    contentY = r.y+r.height-height;
            }
            TextEdit {
                id: editor
                anchors.fill: parent;
                anchors.margins: background.radius / 2
                //clip: true
                font.family: slide.codeFontFamily
                font.pixelSize: slide.codeFontSize
                focus: editorFocus

                onFocusChanged: { console.log("TextEdit focus", focus); }
                cursorDelegate: Rectangle { width: 10; color: "yellow"; opacity: 0.5 }
                onTextChanged: {
                  if (autointerpret) {
                    var newtest = Qt.createQmlObject(text,testparent,"test");
                    if (newtest) {
                      if (testparent.test) testparent.test.destroy();
                      testparent.test = newtest;
                      //testparent.test.anchors.centerIn = testparent;
                    }
                  }
                }
                Component.onCompleted: {
                  text=slide.code;
                }
                //font.weight: Font.Bold
                color: "white"
                /*Keys.onTabPressed: {
                    // Wierd... tab didn't work on HW??
                    var ocp;
                    ocp = cursorPosition;
                    text = text.slice(0,ocp) + "\t" + text.slice(ocp,text.length);
                    cursorPosition = ocp+1;
                }*/

                Keys.onPressed: {
                    if (event.key==Qt.Key_F1) {
                      if (flick.opacity==1) {
                        flick.opacity=0.;
                      } else {
                        flick.opacity=1.0;
                        slide.editorFocus = true; slide.focus = true;
                      }
                    }
                }
                Keys.onEscapePressed: { slide.editorFocus = false; slide.focus = true; }
                onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
            }
        }
    }

}
