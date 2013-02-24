import QtQuick 2.0
import Qt.labs.presentation 1.0

AnimationPresentation {
    id: presentation
    width: 1920
    height: 1080
    //width: 1024
    //height: 768

    Keys.onTabPressed: { slides[currentSlide].focus = true; }

    Keys.onPressed: {
        switch (event.key) {
        case Qt.Key_PageUp:
            goToPreviousSlide();
            break;
        case Qt.Key_PageDown:
            goToNextSlide();
            break;
        case Qt.Key_Escape:
            console.log("ESCAPE!!!");
            break;
        case Qt.Key_F5:
            console.log("F5");
            break;
        case Qt.Key_F2:
            if (!terminal.focus) {
                presentation.focus = false;
                terminal.focus = true;
                //terminal.opacity = 1;
                spring.spring = 3;
                drop.angle = 0;
            }
            else {
                terminal.focus = false;
                presentation.focus = true;
                //terminal.opacity = 0;
                spring.spring = 0.5;
                drop.angle = 100;
            }
            break;
        case Qt.Key_Period:
            //console.log("period");
            break;
        default:
            //console.log("Other Code", event.key);
            break;
        }
    }

    Image {
        x: - parent.width
        y: - parent.height
        height: parent.height * 3
        width: parent.width * 3
        source: "pictures/tile.jpg"
        fillMode: Image.Tile
        smooth: false
    }

    ShaderEffect {
        id: shader
        visible: shaderSlide.visible
        anchors.fill: parent
        property real time: 0.0
        NumberAnimation on time {
            from: 0; to: 10; duration: 100000; running: true; loops: -1;
        }
        fragmentShader: "
          varying highp vec2 qt_TexCoord0;
          uniform float time;

          void main(void) {
              vec2 uPos = qt_TexCoord0;
              uPos.y += sin( time + uPos.x * 6.0) * 0.45;
              uPos.x += sin(-time + uPos.y * 3.0) * 0.25;
              float value = sin(uPos.y * 2.5) + sin(uPos.x * 10.0);
              float vertColor = 1.0/sqrt(abs(value))/4.0;
              gl_FragColor = vec4(0., vertColor, 2. * vertColor, vertColor);
          }"
    }

    EmptySlide {
        Text {
            color: "#77000000"
            text: "JavaScript\non the\nRaspberry Pi"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 20
            font.pixelSize: parent.height / 6
            font.family: "Impact"
        }

        Rectangle {
            id: titleBox
            anchors { left: parent.left; right: parent.right; bottom: parent.bottom }
            height: parent.height * 1 / 3;
            color: "#77000000"
            Text {
                color: "#33ffffff"
                text: "Thomas Kroeber"
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 20
                font.pixelSize: parent.height / 5
                font.family: "Impact"
            }
        }
        Image {
            source: "pictures/raspi_logo.png"
            anchors.right: parent.right
            anchors.verticalCenter: titleBox.top
            anchors.rightMargin: parent.width / 10
            height: parent.height / 3
            fillMode: Image.PreserveAspectFit
        }
    }
    AnimationSlide {
        id: consoleSlide
        transition: "pushright"
//        anchors.fill:parent
        animationStates: ["state1", "state2"]
        state: "state1"

        Rectangle {
            id: gBox
            anchors { left: parent.left; right: parent.right; bottom: parent.bottom }
            height: parent.height * 1 / 3;
            color: "#77000000"
        }
        Image {
            anchors.left: parent.left
            anchors.leftMargin: 100
            y: 215
            source: "pictures/kid.png"
            fillMode: Image.PreserveAspectCrop
        }
        Image {
            id: ps3
            height: 600
            x: parent.width * 2 / 10
            y: -10000
            fillMode: Image.PreserveAspectFit
            source: "pictures/ps31.png"
        }

        Image {
            id: xbox
            height: 600
            x: parent.width / 2
            y: -10000
            fillMode: Image.PreserveAspectFit
            source: "pictures/xbox.png"
        }
        Image {
            id: wii
            height: 600
            y: -1000
            x: parent.width * 7 / 10

            fillMode: Image.PreserveAspectFit
            source: "pictures/Wii_console.png"
        }
        transitions: Transition {
                NumberAnimation {
                targets: [xbox, wii, ps3]
                properties: "y"
                duration: 500
                easing.type: Easing.OutQuad
            }
        }

        states: [
            State {
                 name: "state1"
                 PropertyChanges { target: ps3; y: -10000 }
                 PropertyChanges { target: wii; y: -6000 }
                 PropertyChanges { target: xbox; y: -3000 }
             },
             State {
                 name: "state2"
                 PropertyChanges { target: ps3; y: 100 }
                 PropertyChanges { target: wii; y: 100 }
                 PropertyChanges { target: xbox; y: 100 }
             }
        ]
    }
    Slide {
        height: parent.height
        property string transition: "pushup"
        //anchors.fill: parent
        Text {
            color: "white"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 100
            font.family: "Helvetica"
            text: "Eben Upton"
        }
        Image {
            source: "pictures/eben.png"
            anchors.bottom: parent.bottom
            anchors.left: parent.horizontalCenter
            width: parent.width / 2
            fillMode: Image.PreserveAspectFit
            Text {
                font.pixelSize: 30
                anchors { bottom: parent.bottom; right: parent.right }
                text: "http://www.flickr.com/photos/jimkillock/7862804896"
            }
        }
    }
    Slide {
        anchors.fill: parent
        Image {
            source: "pictures/7805302094_f85507e71d_b_d.jpg"
            width: parent.masterWidth
            height: parent.masterHeight
            anchors.centerIn: parent
            fillMode: Image.PreserveAspectCrop
        }
        Text {
            font.pixelSize: 30
            anchors { bottom: parent.bottom; right: parent.right }
            text: "http://www.flickr.com/photos/33511186@N00/7805302094/in/photostream"
        }

    }
    AnimationSlide {
        id: animationslide
        anchors.fill: parent
        animationStates: ["state1", "state2", "state3"]
        state: "state1"
        Rectangle {
            anchors.fill: parent
            clip: true
            color: "transparent"
            Image {
                id: raspi
                anchors.centerIn: parent
                height: presentation.height * .9
                fillMode: Image.PreserveAspectFit
                source: "pictures/raspi.png"
                Behavior on rotation { NumberAnimation { duration: 300 } }
                transform: [
                    Scale {
                        id: imageScale
                        property real scale: 1
                        Behavior on scale { NumberAnimation { duration: 300 } }
                        xScale: scale
                        yScale: scale
                        origin.x: .600 * raspi.width
                        origin.y: .650 * raspi.height
                    }
                ]
                Rectangle {
                    id: cpuRegion
                    width: .142 * raspi.width
                    height: .205 * raspi.height
                    border.width: 8
                    border.color: "#77ff0000"
                    //                color: "#33ffffff"
                    color: "transparent"
                    x: .357 * raspi.width
                    y: .450 * raspi.height
                    Behavior on width { SpringAnimation { spring: 2; damping: .2 } }
                    Behavior on height { SpringAnimation { spring: 2; damping: .2 } }
                    Behavior on x { SpringAnimation { spring: 2; damping: .2 } }
                    Behavior on y { SpringAnimation { spring: 2; damping: .2 } }

                    PropertyAnimation on opacity  {
                        id: opacityAnimation
                    }
                }
            }
            Text {
                text: "Broadcom BCM2835\n12mm x 12mm\nARM11"
            }
        }
        states: [
            State {
                name: "state1"
                PropertyChanges {
                    target: imageScale
                    scale: 1
                }
                PropertyChanges {
                    target: raspi
                    rotation: 0
                }
            },
            State {
                name: "state2"
                PropertyChanges {
                    target: imageScale
                    scale: 4.0
                }
                PropertyChanges {
                    target: raspi
                    rotation: -90
                }
                PropertyChanges {
                    target: opacityAnimation
                    loops: 20
                    running: true
                    easing.type: Easing.InOutQuad
                    from: 0
                    to: 1.0
                    duration: 300
                }
            },
            State {
                name: "state3"
                PropertyChanges {
                    target: imageScale
                    scale: 4.0
                }
                PropertyChanges {
                    target: raspi
                    rotation: -90
                }
                PropertyChanges {
                    target: cpuRegion
                    width: .142 * raspi.width / 11
                    height: .30 * raspi.height * 2 / 11
                    x: .4 * raspi.width
                    y: .5 * raspi.height
                    radius: 1
                    color: "#77ff0000"
                    border.width: 2
                    border.color: "#ffff0000"
                }

            }
        ]
    }
    EmptySlide {
        id: nonode
        Rectangle {
            color: "#77000000"
            anchors { left: parent.left; right: parent.right; bottom: parent.bottom }
            height: parent.height * 1 / 4
        }
        Image {
            anchors.centerIn: parent
            source: "pictures/node.png"
        }
        Image {
            id: nosign
            anchors.centerIn: parent
            source: "pictures/no-sign.png"
            height: 300
            width: 300
            opacity: 0
            scale: 3
        }
        SequentialAnimation {
            PauseAnimation { duration: 500 }
            running: nonode.visible && !nonode.inTransition
            ParallelAnimation {
                NumberAnimation { target: nosign; property: "opacity"; from: 0; to: 1; duration: 500; easing.type: Easing.OutQuart }
                NumberAnimation { target: nosign; property: "scale"; from: 4; to: 1; duration: 500; easing.type: Easing.InOutQuart }
            }
            NumberAnimation {
                target: presentation
                property: "anchors.topMargin"
                from: 0
                to: -300
                duration: 5000
            }
        }
    }

    EmptySlide {
        id: qtslide
        transition: "pushup"
        Rectangle {
            id: qttitle
            color: "#77000000"
            anchors { left: parent.left; right: parent.right; top: parent.top }
            height: parent.height * 1 / 3
            Image {
                id: qtlogo
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.margins: parent.width / 20
                height: parent.height * .8
                fillMode: Image.PreserveAspectFit
                source: "pictures/Qt-logo.png"
            }
            Rectangle {
                anchors.left: qtlogo.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 100
                border.width: 1
                border.color: "red"
                height: qt5.height + qturl.height
                Text {
                    id: qt5
                    color: "#33ffffff"
                    text: "Qt 5"
                    //anchors.bottom: parent.verticalCenter
                    font.pixelSize: qttitle.height / 4
                    font.family: "Impact"
                }
                Text {
                    id: qturl
                    color: "#33ffffff"
                    text: "http://qt-project.org"
                    anchors.top: qt5.bottom
                    font.pixelSize: qttitle.height / 8
                    font.family: "Impact"
                }
            }
        }
        Text {
            anchors.top: qttitle.bottom
            //anchors.leftMargin: parent.width / 20
            anchors.topMargin: parent.height * .05
            anchors.left: parent.left
            textFormat: Text.StyledText
            text: "<ul><li>Cross Platform C++ Framework</li>
<li><b>QML</b>: Declarative Language - much like (s)CSS</li>
<li>OpenGL</li>
<li>JavaScript for scripting</li>
<li>items can be implemented in C++</li>
<li>Shaders, Canvas, Particles</li></ul>"
            font.pixelSize: parent.height * 0.05
            font.weight: Font.Light
            font.family: presentation.fontFamily
            color: "#77ffffff"
        }
    }
    EditorSlide {
        id: qmlintroslide
        title: "QML"
        code: "import QtQuick 2.0
Rectangle {
\tcolor: \"#C42C6B\"
\twidth: 300
\theight: 200
\tanchors.centerIn: parent
}

"
        cheatedCode: "import QtQuick 2.0
Rectangle {
\tcolor: \"#C42C6B\"
\twidth: 100 * Math.cos(rotation/180*Math.PI) + 200
\theight: 30+200 * Math.sin(rotation/360*Math.PI)
\tanchors.centerIn: parent
\tradius: 40
\tNumberAnimation on rotation {
\t\tfrom: 0
\t\tto: 360
\t\tloops: -1
\t\tduration: 3000
\t}
}

"
    }
    CodeSlide {
        id: shaderSlide
        title: "Shaders"
        code: "import QtQuick 2.0
ShaderEffect {
\tanchors.fill: parent
\tproperty real time: 0.0
\tNumberAnimation on time {
\t\tfrom: 0; to: 10; duration: 100000; running: true; loops: -1;
\t}
\tfragmentShader: \"
\t\tvarying highp vec2 qt_TexCoord0;
\t\tuniform float time;
\t\tvoid main(void) {
\t\t\tvec2 uPos = qt_TexCoord0;
\t\t\tuPos.y += sin( time + uPos.x * 6.0) * 0.45;
\t\t\tuPos.x += sin(-time + uPos.y * 3.0) * 0.25;
\t\t\tfloat value = sin(uPos.y * 2.5) + sin(uPos.x * 10.0);
\t\t\tfloat vertColor = 1.0/sqrt(abs(value))/4.0;
\t\t\tgl_FragColor = vec4(0., vertColor, 2. * vertColor, vertColor);
\t\t}\"
}"
        clip: false

    }
    ContentSlide {
        transition: "pushup"
        title: "GPIO"
        content: "<ul><li>CPU pins that can be programmed</li>
<li>Serial</li>
<li>I<sup>2</sup>C</li>
<li>Data pins (in/out)</li>
<li>PWM generator</li></ul>"
    }
    CodeSlide {
        title: "C++"
        code: "#include <QtQuick/QQuickItem>
#include <QtQml/QQmlExtensionPlugin>
#include <bcm2835.h>

class GPIO : public QQuickItem
{
Q_OBJECT
public:
GPIO(QQuickItem *parent = 0) : QQuickItem(parent) {
    if (!(bcm2835_init()) {
      // Throw error
    }
  }

Q_INVOKABLE void digitalWrite(int pin, bool value) {
  bcm2835_gpio_fsel(pin, BCM_GPIO_FSEL_OUTP);
  bcm2835_gpio_write(pin, (int)value);
}
};

/////////////////////////

class GPIOPlugin : public QQmlExtensionPlugin
{
Q_OBJECT
Q_PLUGIN_METADATA(IID \"org.qt-project.Qt.QQmlExtensionInterface\" FILE \"gpio.json\")

public:
void registerTypes(const char *uri) {
    qmlRegisterType<GPIO>(uri, 1, 0, \"GPIO\");
}
};"
    }
    EditorSlide {
        title: "JavaScript"
        code: "import QtQuick 2.0
import \"experimental\" 1.0
GPIO {
\tid: gpio
\tfunction player() {
\t\tvar pinMap = { 'C':3, 'D':6, 'F':5, 'G':7, 'A':4, 'H':2 };
\t\tvar song = \"CDF G G A G F C D F F D C D      CDF G G A G F C D F F D D C    \";
\t\tvar current = song[metronom.counter % song.length];
\t}
}
"
        cheatedCode: "import QtQuick 2.0
import \"experimental\" 1.0
GPIO {
\tid: gpio
\tTimer {
\t\tid: tone
\t\tinterval: 1
\t\tproperty int pin
\t\tonTriggered: {
\t\t\tgpio.digitalWrite(pin, 0);
\t\t}
\t\tfunction play(thePin) {
\t\t\tpin = thePin;
\t\t\tgpio.digitalWrite(thePin, 1);
\t\t\ttone.start();
\t\t}
\t}
\tTimer {
\t\tid: metronom
\t\tproperty int counter: 0
\t\trepeat: true
\t\tonTriggered: player()
\t\tinterval: 200
\t\trunning: false
\t}

\tfunction player() {
\t\tvar pinMap = { 'C':3, 'D':6, 'F':5, 'G':7, 'A':4, 'H':2 };
\t\tvar song = \"CDF G G A G F C D F F D C D      CDF G G A G F C D F F D D C    \";
\t\tvar current = song[metronom.counter % song.length];
\t\tvar t = pinMap[current];
\t\tif (t) {
\t\t\ttone.play(t);
\t\t}
\t\tmetronom.counter += 1;
\t}
}

"
    }
    Slide {
        title: "Conclusions"

            Text {
                color: "#1e90ff"
                font.pixelSize: 40
                anchors.horizontalCenter: parent.horizontalCenter
                text: "@cellcortex | cellcortex@gmail.com | thomas.kroeber@nokia.com"
            }

    }
    Terminal {
        id: terminal
        onActiveFocusChanged: console.log("terminal focus",activeFocus)
        onFocusChanged: console.log("terminal focus",focus)
        anchors.fill: parent
        transform: Rotation { id: drop; origin.x: 1920/2; origin.y: 0; axis { x: 1; y: 0; z: 0 }
            Behavior on angle { SpringAnimation {id: spring; spring: 2; damping: 0.2 } }
            angle: 100
        }
        opacity:(90-drop.angle)*0.01
        //focus: false
    }
}
