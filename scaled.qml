import QtQuick 2.0

Rectangle {
  id: scr
  anchors.fill: parent
  color: "black"

  SlideDeck {
    anchors.centerIn: parent
    width: 1920
    height: 1080
    scale: src.width / width
    focus: true
    clip: true
  }
}
