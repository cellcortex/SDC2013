import QtQuick 2.0

Rectangle {
  id: src
  width: 1920
  height: 1080
  color: "black"
  
  SlideDeck {
    anchors.centerIn: parent
    width: 1024
    height: 768
    clip: true
  }
}
