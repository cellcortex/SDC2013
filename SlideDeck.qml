import QtQuick 2.0
import Qt.labs.presentation 1.0

AnimationPresentation {
    id: presentation
    width: 1920
    height: 1080

    Keys.onTabPressed: { slides.children[currentSlide].focus = true; }

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
        anchors.fill: parent
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

    Slide {
        centeredText: "JavaScript\non the\nRaspberry Pi\n\nThomas Kroeber"
        baseFontSize: titleFontSize
        Image {
            source: "pictures/raspi_logo.png"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            //anchors.topMargin: 100
            height: 300
            fillMode: Image.PreserveAspectFit
            z: -10
        }
    }
    Slide {
        anchors.fill:parent
        Image {
            anchors.centerIn: parent
            source: "pictures/kid.png"
            fillMode: Image.PreserveAspectCrop
        }
    }
    Slide {
        title: "ZX81"
        anchors.fill:parent
        Image {
            source: "pictures/1221382771_c35d0759b3_o.jpg"
            fillMode: Image.PreserveAspectCrop
        }

        Text {
            font.pixelSize: 30
            anchors { bottom: parent.bottom; right: parent.right }
            text: "http://www.flickr.com/photos/9574086@N02/1221382771"
        }
    }
    Slide {
        id: consoleSlide
        anchors.fill:parent
        title: "Game Consoles"
        Image {
            id: ps3
            height: 600
            x: parent.width / 10
            y: -10000
            fillMode: Image.PreserveAspectFit
            source: "pictures/ps31.png"
            Behavior on y {
                animation: bouncebehavior
            }
        }

        Image {
            id: xbox
            height: 600
            x: parent.width / 2
            y: -10000

            fillMode: Image.PreserveAspectFit
            source: "pictures/xbox.png"
            Behavior on y {
                animation: bouncebehavior
            }
        }
        Image {
            id: wii
            height: 600
            y: -10000
            x: parent.width * 7 / 10

            fillMode: Image.PreserveAspectFit
            source: "pictures/Wii_console.png"
            Behavior on y {
                animation: bouncebehavior
            }
        }
        SequentialAnimation {
            running: consoleSlide.visible
            PauseAnimation { duration: 500 }
            ParallelAnimation {
                id: playbanner
                NumberAnimation {
                    target: ps3
                    easing {
                        type: Easing.OutElastic
                        amplitude: 1.0
                        period: 0.5
                    }
                    property: "y"
                    from: -1000
                    to: 100
                    duration: 1000
                }
                NumberAnimation {
                    target: wii
                    easing {
                        type: Easing.OutElastic
                        amplitude: 1.0
                        period: 0.5
                    }
                    property: "y"
                    from: -800
                    to: 100
                    duration: 1000
                }
                NumberAnimation {
                    target: xbox
                    easing {
                        type: Easing.OutElastic
                        amplitude: 1.0
                        period: 0.5
                    }
                    property: "y"
                    from: -1300
                    to: 100
                    duration: 1000
                }
            }
        }
    }
    Slide {
        anchors.fill: parent
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
        property real factor: (width * .8) / 1400
        Rectangle {
            anchors.fill: parent
            clip: true
            color: "transparent"
            Image {
                id: raspi
                anchors.centerIn: parent
                width: parent.width * .8
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
                        origin.x: 900 * animationslide.factor
                        origin.y: 600 * animationslide.factor
                    }
                ]
                Rectangle {
                    id: cpuRegion
                    width: 189 * animationslide.factor
                    height: 190 * animationslide.factor
                    border.width: 8
                    border.color: "#77ff0000"
                    //                color: "#33ffffff"
                    color: "transparent"
                    x: 506 * animationslide.factor
                    y: 440 * animationslide.factor
                    Behavior on width { SpringAnimation { spring: 2; damping: .2 } }
                    Behavior on height { SpringAnimation { spring: 2; damping: .2 } }
                    Behavior on x { SpringAnimation { spring: 2; damping: .2 } }
                    Behavior on y { SpringAnimation { spring: 2; damping: .2 } }

                    PropertyAnimation on opacity  {
                        id: opacityAnimation
                    }
                }
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
                    width: 15 * animationslide.factor
                    height: 30 * animationslide.factor
                    //x: 506+10 * animationslide.factor
                    //y: 440+10 * animationslide.factor
                    radius: 0
                    color: "#77ff0000"
                }

            }
        ]
    }
    Slide {
        title: "This is not node!"
        Image {
            source: "pictures/node.png"
        }
    }

    Slide {
        anchors.topMargin: 30
        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            height: 300
            fillMode: Image.PreserveAspectFit
            source: "pictures/Qt-logo.png"
        }
        content: [ "Portable C++ framework",
            "20 years",
            "Opensource",
            "Qt5 beta is the latest version",
            "Complete rewrite of the graphics pipeline"
        ]
    }
    Slide {
        anchors.topMargin: 30
        title: "Qt Quick 2.0"
        content: [ "UI markup for Qt 5",
            "Declarative Language - much like (s)CSS",
            "JavaScript for scripting",
            "items can be implemented in C++",
            "Shaders, Canvas, Particles"
        ]
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
    Slide {
        title: "GPIO"
        content: ["CPU pins that can be programmed",
            "Serial",
            "I<sup>2</sup>C",
            "Data pins (in/out)",
            "PWM generator"
        ]
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
\t\tvar pinMap = { 'C':9, 'D':8, 'F':7, 'G':6, 'A':5, 'H':4 };
\t\tvar song = \"C DF\tGAHCFD D\tF\tC\";
\t\tvar current = song[metronom.counter % song.length];
\t\tif (current != ' ') {
\t\t\ttone.play(pinMap[current]);
\t\t}
\t\tmetronom.counter += 1;
\t}
}

"
    }
    Slide {
        title: "Conclusions"
        Column {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 40

            Column {
                anchors.left: parent.left
                anchors.right: parent.right
                Text {
                    anchors.topMargin: 40
                    color: "white"
                    font.pixelSize: 100
                    anchors.left: parent.left
                    text: "Checkout Raspberry Pi"
                }
                Text {
                    color: "#1e90ff"
                    font.pixelSize: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "http://raspberrypi.org"
                }
            }
            Column {
                anchors.left: parent.left
                anchors.right: parent.right
                Text {
                    color: "white"
                    font.pixelSize: 100
                    anchors.left: parent.left
                    text: "Checkout Qt5 and QML"
                }
                Text {
                    color: "#1e90ff"
                    font.pixelSize: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "http://qt-project.org"
                }
            }
            Column {
                anchors.left: parent.left
                anchors.right: parent.right
                Text {
                    color: "white"
                    font.pixelSize: 100
                    anchors.left: parent.left
                    text: "Checkout Nokia L&C"
                }
                Text {
                    color: "#1e90ff"
                    font.pixelSize: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "http://m.maps.nokia.com"
                }
            }
            Text {
                color: "#1e90ff"
                font.pixelSize: 40
                anchors.horizontalCenter: parent.horizontalCenter
                text: "@cellcortex | cellcortex@gmail.com | thomas.kroeber@nokia.com"
            }
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
