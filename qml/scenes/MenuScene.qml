import Felgo 3.0
import QtQuick 2.0
import "../"

SceneBase {
  id:menuScene

  // signal indicating that the gameScene should be displayed
  signal gameScenePressed

  // background image
  Image {
    anchors.fill: menuScene.gameWindowAnchorItem
    source: "../../assets/background.png"
  }

  Column {
    anchors.centerIn: parent
    spacing: 20

    Rectangle {
      width: 150
      height: 50
      color: "orange"
      Image {
        id: gameSceneButton
        source: "../../assets/playButton.png"
        anchors.centerIn: parent
      }

      MouseArea {
        id: gameSceneMouseArea
        anchors.fill: parent
        onClicked: gameScenePressed()
      }
    }

    Rectangle {
      width: 150
      height: 50
      color: "orange"
      Image {
        id: scoreSceneButton
        source: "../../assets/scoreButton.png"
        anchors.centerIn: parent
      }
      MouseArea {
        id: scoreSceneMouseArea
        anchors.fill: parent
        onClicked: frogNetworkView.visible = true
      }
    }
  }
}
