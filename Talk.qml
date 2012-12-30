import QtQuick 2.0
import "experimental" 1.0
import QtGraphicalEffects 1.0

FocusScope {
    id: show
    Behavior on opacity { NumberAnimation { duration: 5000 } }
    opacity: 0
    property real time: 0.0
    /*NumberAnimation on time {
        from: 0; to: 40*60*1000; duration: 40*60*1000
        //running: foregroundSlide.currentItem.needsTime
        //onRunningChanged: { console.log("time running",running); }
    }*/
    Background {
        time:show.time
        anchors.fill: parent 
    }
    Component.onCompleted: {
      var s = slides.children[currentSlide];
      s.visible = true;
      s.timeRunning = true;
      s.x = 0;
      s.y = 0;
      opacity = 1.0;
    }
    focus: true
    onFocusChanged: console.log("show focus",focus)
    onActiveFocusChanged: console.log("show active focus",focus)
    property int currentSlide: 0
    property bool behaviorEnabled: false
    Keys.onEscapePressed: {
        if (slides.children[currentSlide].focus)
            slides.children[currentSlide].focus = false;
        else
            Qt.quit();
    }
    Keys.onReturnPressed: {
      var s = slides.children[currentSlide];
      s.focus=true;
      s.currentItem.focus = true;
      console.log("focusing!");
    }
    Keys.onRightPressed: { slide(true); }
    Keys.onLeftPressed: { slide(false); }
    Keys.onTabPressed: { slides.children[currentSlide].focus = true; }
    function slide(right) {
      if (pushAnimation.running) {
        //pushAnimation.complete();
        return;
      }
      var s = slides.children[currentSlide];
      if (right) {
        if (s.animationStates.length-1 > s.animationStep) {
          s.animationStep += 1;
          s.state = s.animationStates[s.animationStep];
        } else if (currentSlide < slides.children.length-1) {
          pushAnimation.from = currentSlide;
          pushAnimation.to = currentSlide + 1;
          pushAnimation.running = true;
          currentSlide = pushAnimation.to;
        }
      } else {
        if (s.animationStep > 0) {
          s.animationStep -= 1;
          s.state = s.animationStates[s.animationStep];
        } else if (currentSlide > 0) {
          pushAnimation.from = currentSlide;
          pushAnimation.to = currentSlide - 1;
          pushAnimation.running = true;
          currentSlide = pushAnimation.to;
        }
      }
    }
    FocusScope {
        id: slides
        anchors.fill: parent
        // OVERSCAN COMPENSATIO
        /*
        anchors.leftMargin: 40
        anchors.rightMargin: 40
        anchors.topMargin: 25
        anchors.bottomMargin: 25 
        */
        focus: true
        onFocusChanged: console.log("slides focus",focus)
        Slide {
          Image {
            source: "raspi_logo.png"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 100
            height: 300
            fillMode: Image.PreserveAspectFit
          }
          Column {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.verticalCenter
            anchors.topMargin: -100
            Title { text: "JavaScript" }
            Body { text: "on the"; font.pixelSize: 80 }
            Title { text: "Raspberry Pi" }
            Body { text: "Thomas Kroeber"; font.pixelSize: 80; color: "#1e90ff" }
          }
        }
        Slide {
          Text {
            color: "white"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 100
            text: "Eben Upton"
          }
          Image {
            source: "eben.png"
            anchors.bottom: parent.bottom
            anchors.left: parent.horizontalCenter
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
        Slide {
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
        ColumnSlide {
          anchors.topMargin: 30
          Image {
            anchors.horizontalCenter: parent.horizontalCenter
            height: 300
            fillMode: Image.PreserveAspectFit
            source: "Qt-logo.png"
          }
          Bullet { text: "Portable C++ framework" }
          Bullet { text: "20 years" }
          Bullet { text: "Opensource" }
          Bullet { text: "Qt5 beta is the latest version" }
          Bullet { text: "Complete rewrite of the graphics pipeline" }
        }
        ColumnSlide {
          anchors.topMargin: 30
          Title { text: "Qt Quick 2.0" }
          Bullet { text: "UI markup for Qt 5"; anchors.topMargin: 30 }
          Bullet { text: "Declarative Language - much like (s)CSS" }
          Bullet { text: "JavaScript for scripting" }
          Bullet { text: "items can be implemented in C++" }
          Bullet { text: "Shaders, Canvas, Particles" }

        }
        CodeSlide {
          id: qmlintroslide
          title: "QML"
          Editor {
            focus: true
            anchors.fill: parent
            editorFocus: parent.focus
            initialtext: "import QtQuick 2.0
Rectangle {
\tcolor: \"#C42C6B\"
\twidth: 300
\theight: 200
\tanchors.centerIn: parent
}

"
          }
        }
        CodeSlide {
          title: "Shaders"
          Editor {
            focus: true
            anchors.fill: parent
            editorFocus: parent.focus
            initialtext: "import QtQuick 2.0
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
\t\t\t//uPos.y += sin( time + uPos.x * 6.0) * 0.45;
\t\t\t//uPos.x += sin(-time + uPos.y * 3.0) * 0.25;
\t\t\t//float value = sin(uPos.y * 2.5) + sin(uPos.x * 10.0);
\t\t\t//float vertColor = 1.0/sqrt(abs(value))/4.0;
\t\t\t//gl_FragColor = vec4(0., vertColor, 2. * vertColor, vertColor);
\t\t\tgl_FragColor = vec4(uPos.x, uPos.y, 0., .5);
\t\t}\"
}

"
          }
        }
        ColumnSlide {
          Title { text: "GPIO" }
          Bullet { text: "CPU pins that can be programmed" }
          Bullet { text: "Serial" }
          Bullet { text: "I<sup>2</sup>C" }
          Bullet { text: "Data pins (in/out)" }
          Bullet { text: "PWM generator" }
        }
        Slide {
          Text {
            text: "C++"
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 100
            color: "#7fffffff"
            font.pixelSize: 100
          }
          Text {
            anchors.fill: parent
            anchors.leftMargin: 70
            font.family: "Courier"
            font.pixelSize: 26
            color: "white"
            text: "#include <QtQuick/QQuickItem>
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
        }
        CodeSlide {
          title: "JavaScript"
          Editor {
            focus: true
            anchors.fill: parent
            editorFocus: parent.focus
            initialtext: "import QtQuick 2.0
import \"experimental\" 1.0
GPIO {
\tid: gpio
\tfunction playNext() {
\t\tvar pinMap = { 'C':9, 'D':8, 'F':7, 'G':6, 'A':5, 'H':4 };
\t\tvar song = \"C DF GA H CFD D  F  C\";
\t\tvar current = song[beat.counter % song.length];
\t\tif (current != ' ') {
\t\t\t//tone.play(pinMap[current]);
\t\t}
\t\tbeat.counter += 1;
\t}
}

"
          }
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

    Keys.onPressed: {
        // console.log("key pressed:",event.key)
        if (event.key==Qt.Key_F2) {

            if (!terminal.focus) {
                slides.focus = false;
                terminal.focus = true;
                //terminal.opacity = 1;
                spring.spring = 3;
                drop.angle = 0;
            }
            else {
                terminal.focus = false;
                slides.focus = true;
                //terminal.opacity = 0;
                spring.spring = 0.5;
                drop.angle = 100;
            }
        }
    }
    PushAnimation {
      id: pushAnimation
      slideContainer: slides
    }
}
