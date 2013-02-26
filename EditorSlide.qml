import QtQuick 2.0
import Qt.labs.presentation 1.0


EmptySlide {
    id: slide;

    property string title
    property string codeFontFamily: parent.codeFontFamily
    property string code
    property string cheatedCode
    property string __savedCode
    property real codeFontSize: fontSize * 0.6
    property bool autointerpret: true
    property var errors: null
    property int __errorIndex: 0

    property bool editorFocus: false
    property bool showEditor: true

    property var testparent: testhook

    onVisibleChanged: {
        slide.focus = true;
        if (slide.showEditor) {
            scope.focus = true;
            editorFocus = slide.visible;
            editor.forceActiveFocus();
        }
    }

    onShowEditorChanged: {
        if (slide.focus && showEditor) {
            editor.forceActiveFocus();
        }
    }

    onFocusChanged: {
        //console.log("Slide Focus: ", slide.focus);
        if (slide.focus && editorFocus) {
            editor.forceActiveFocus();
        }
    }

    Item {
        id: title
        anchors { left: parent.left; right: parent.right; top: parent.top }
        height: parent.height * 1 / 4
        Text {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 100
            color: "#77000000"
            text: slide.title
            font.pixelSize: title.height / 3
            font.family: headFont.name
        }
    }



    FocusScope {
        id: scope
        anchors { left: parent.left; bottom: parent.bottom; right: parent.right; top: title.bottom }
        clip: true
        Item {
            property Item test;
            id: testhook
            anchors.fill: parent
        }
        Rectangle {
            id: background
            anchors.fill: parent
            anchors.leftMargin: slide.showEditor ? 100 : 2000
            //radius: height / 10
            opacity: slide.showEditor ? 1. : 0.
            color: "#77000000"
            /*
            gradient: Gradient {
                GradientStop { position: 0; color: Qt.rgba(0.8, 0.8, 0.8, 0.5); }
                GradientStop { position: 1; color: Qt.rgba(0.2, 0.2, 0.2, 0.5); }
            }*/
            //border.color: slide.textColor;
            //border.width: height / 250;
            antialiasing: true
            Behavior on opacity { NumberAnimation { duration: 300 } }
            Behavior on anchors.leftMargin { SpringAnimation {spring: 2; damping: 0.2 } }

            Flickable {
                id: flick
                opacity: 1
                anchors.margins: 30
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

                    cursorDelegate: Rectangle { width: 10; color: "yellow"; opacity: 0.5 }
                    onTextChanged: {
                        if (autointerpret) {
                            try {
                                var newtest = Qt.createQmlObject(text, testparent, "test");
                                if (newtest) {
                                    if (testparent.test) testparent.test.destroy();
                                    testparent.test = newtest;
                                    //testparent.test.anchors.centerIn = testparent;
                                    slide.errors = null;
                                }
                            } catch (err) {
                                //console.log("errorrrr");
                                slide.errors = err.qmlErrors;
                            }
                        }
                    }
                    Component.onCompleted: {
                        text=slide.code;
                    }
                    color: "white"
                    onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
                }
            }
        }
        Rectangle {
            color: slide.errors ? "red" : "green"
            width: 50
            height: 50
            anchors { right: parent.right; bottom: parent.bottom; margins: 0 }
        }

        Keys.onPressed: {
            if (event.key === Qt.Key_F1) {
                if (slide.showEditor) {
                    slide.showEditor = false;
                    slide.focus = false;
                } else {
                    slide.editorFocus = true; slide.focus = true;
                    slide.showEditor = true;
                }
            }

            else if (event.key === Qt.Key_F3) {
                if (!__savedCode) {
                    console.log("posting solution");
                    // do the solution
                    __savedCode = editor.text;
                    editor.text = slide.cheatedCode;
                } else {
                    console.log("restoring old code");
                    editor.text = __savedCode;
                    delete __savedCode;
                }
            }
            else if (event.key === Qt.Key_F4) {
                if (slide.errors) {
                    // go to next error
                    var splitted = editor.text.split("\n");
                    var skip = 0;
                    for (var i = 0; i < slide.errors[slide.__errorIndex].lineNumber-1; ++i) {
                        skip += splitted[i].length + 1
                    }
                    var ln = splitted[slide.errors[slide.__errorIndex].lineNumber-1];
                    skip += slide.errors[slide.__errorIndex].columnNumber;
                    editor.cursorPosition = skip;
                    console.log(slide.errors[slide.__errorIndex].message);
                    slide.__errorIndex = slide.__errorIndex % slide.errors.length;
                }
            }
        }
        Keys.onEscapePressed: { slide.editorFocus = false; slide.focus = true; }
        Keys.onTabPressed: {
            // TAB doesn't work on the raspberry pi
            var old;
            old = cursorPosition;
            text = text.slice(0, old) + "\t" + text.slice(old, text.length);
            cursorPosition = old + 1;
        }

    }
    Keys.onPressed: {
        if (event.key === Qt.Key_F1) {
            if (slide.focus) {
                if (slide.showEditor) {
                    slide.showEditor = false;
                    slide.focus = false;
                } else {
                    slide.editorFocus = true; slide.focus = true;
                    slide.showEditor = true;
                    editor.forceActiveFocus();
                }
            } else {
                slide.focus = true;
            }
        }
        if (event.key === Qt.Key_Escape) {
            slide.editorFocus = false; slide.focus = true;
        }
    }
}
