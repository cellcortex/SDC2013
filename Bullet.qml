import QtQuick 2.0

Rectangle { 
  property alias text: textNode.text
  color: "#50ffffff"
  radius: 30
  height: 120
  width: 1800
  smooth: true
  anchors.horizontalCenter: parent.horizontalCenter
  Text {
    id: textNode
    textFormat: Text.StyledText
    anchors.verticalCenter: parent.verticalCenter
    color: "#ffffff"
    x: 20
//    font.family: "Helvetica"
    font.pointSize: 60
    font.weight: Font.Light
  }
}


