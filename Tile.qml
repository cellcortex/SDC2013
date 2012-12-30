import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
  id: rooty
  width: 180
  height: 100
  property alias color: tile.color
  property alias animation: ani

  Rectangle {
    id: tile
    anchors.fill: parent
    anchors.margins: 1
    color: "white"
  }

  PropertyAnimation {
    id: ani
    duration: 2000
    property: "opacity"
    target: rooty
    to: 1.0
  }
}
