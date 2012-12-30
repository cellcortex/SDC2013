import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
  id: bg
  property real time;
  property real completion: time*0.000000556 // (1.0/(1000.0*30.0*60.0))

  Image {
    anchors.fill: parent
    source: "tile.jpg"
    fillMode: Image.Tile
    smooth: false
  }

  /*
    ShaderEffect {
      id: noise
      anchors.fill: parent
      fragmentShader: "
          float rand(vec2 co) {
              return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
          }
          uniform lowp float qt_Opacity;
          varying highp vec2 qt_TexCoord0;
          void main() {
              if (rand(qt_TexCoord0) > .4) {
                gl_FragColor = vec4(.1,.1,.1,.5); 
              } else {
                gl_FragColor = vec4(.4,.4,.4,.5);
              }
          }
      "
    }

    ShaderEffectSource {
      id: src
      hideSource: true
      sourceItem: noise
      smooth: true
    }
    DirectionalBlur {
      anchors.fill: parent
      id: eff1
      angle: 90
      length: 32
      samples: 32
      source: noise
      smooth: true
    }
    DirectionalBlur {
      anchors.fill: parent
      angle: 0
      length: 32
      samples: 32
      source: src
      smooth: true
    }
    */
  }
