import QtQuick 2.0
import Qt.labs.presentation 1.0

OpacityTransitionPresentation {
    width: 1280
    height: 768

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
        case Qt.Key_Period:
            console.log("period");
            break;
        default:
            console.log("Other Code", event.key);
            break;
        }
    }

    Image {
      anchors.fill: parent
      source: "tile.jpg"
      fillMode: Image.Tile
      smooth: false
    }

    Slide {
        centeredText: "JavaScript\non the\nRaspberry Pi\n\nThomas Kroeber"
        baseFontSize: titleFontSize
      Image {
        source: "raspi_logo.png"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        //anchors.topMargin: 100
        height: 300
        fillMode: Image.PreserveAspectFit
        z: -10
      }
    }
    Slide {
      Text {
        color: "white"
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: 100
        font.family: "Helvetica"
        text: "Eben Upton"
      }
      Image {
        source: "eben.png"
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
      Image {
        source: "7805302094_f85507e71d_b_d.jpg"
        //height: 1000
        scale: 1.9
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
      }
        Text {
          font.pixelSize: 30
          anchors { bottom: parent.bottom; right: parent.right }
          text: "http://www.flickr.com/photos/33511186@N00/7805302094/in/photostream"
        }

    }
    AnimationSlide {
      animationStates: ["state1", "state2", "state3"]
      state: "state1"
      Rectangle {
        anchors.fill: parent
        clip: true
        color: "transparent"
        Image {
          id: raspi
          anchors.centerIn: parent
          width: 1400
          fillMode: Image.PreserveAspectFit
          source: "raspi.png"
          Behavior on rotation { NumberAnimation { duration: 300 } }
          transform: [
            Scale {
              id: imageScale
              property real scale: 1
              Behavior on scale { NumberAnimation { duration: 300 } }
              xScale: scale
              yScale: scale
              origin.x: 950
              origin.y: 620
            }
          ]
          Rectangle {
            id: cpuRegion
            width: 189
            height: 190
            border.width: 8
            border.color: "#77ff0000"
            //                color: "#33ffffff"
            color: "transparent"
            x: 506
            y: 440
            Behavior on width { SpringAnimation { spring: 2; damping: .2 } }
            Behavior on height { SpringAnimation { spring: 2; damping: .2 } }
            Behavior on x { SpringAnimation { spring: 2; damping: .2 } }
            Behavior on y { SpringAnimation { spring: 2; damping: .2 } }
          }
        }
      }
      states: [
        State {
          name: "state1"
          PropertyChanges {
            target: imageScale
            scale: 1.0
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
            width: 15
            height: 30
            x: 506+10
            y: 440+10
            radius: 0
            color: "#77ff0000"
          }

        }
      ]
    }
    Slide {
      anchors.topMargin: 30
      Image {
        anchors.horizontalCenter: parent.horizontalCenter
        height: 300
        fillMode: Image.PreserveAspectFit
        source: "Qt-logo.png"
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
    }
    CodeSlide {
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
\t\t\t//gl_FragColor = vec4(0., vertColor, 2. * vertColor, vertColor);
\t\t}\"
}"
      ShaderEffect {
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
      Title {
          anchors.horizontalCenter: parent.horizontalCenter
          anchors.top: parent.top
          anchors.topMargin: 20
          text: "Conclusions"
      }
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
}
