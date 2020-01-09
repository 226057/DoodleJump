import QtQuick 2.0
import Felgo 3.0
import QtSensors 5.5
import "../"

// EMPTY SCENE

SceneBase {
    id: gameScene

    GameNetworkView {
      id: frogNetworkView
      visible: false
      anchors.fill: parent.gameWindowAnchorItem

      onShowCalled: {
        frogNetworkView.visible = true
      }

      onBackClicked: {
        frogNetworkView.visible = false
      }
    }

    // actual scene size
    width: 320
    height: 480

    state: "start"

    signal menuScenePressed

    property int score: 0

    Component.onCompleted: gameNetwork.incrementAchievement("5opens")

    Text {
        text: "Felgo"
        color: "blue"

        anchors.centerIn: parent
    }

    Image {
       anchors.fill: parent.gameWindowAnchorItem
//       source: (score >= 1000) ? "../../assets/background.png" : "../../assets/b1.png"
       function getSource()
       {
           var source = "../../assets/b1.png"
           if(score >= 200)
           {
               source = "../../assets/b2.png"
           }
           if(score >= 400)
           {
               source = "../../assets/b3.png"
           }
           if(score >= 600)
           {
               source = "../../assets/b4.png"
           }
           return source
       }
       source: getSource()

//       source: "../../assets/background.png"

     }

    PhysicsWorld {
      debugDrawVisible: false // set this to true to show the physics overlay
      updatesPerSecondForPhysics: 60
      gravity.y: 20 // how much gravity do you want?
    }

    // every platform gets recycled so we define only ten of them
    Repeater {
      model: 10
      Platform {
        x: utils.generateRandomValueBetween(0, gameScene.width) // random value
        y: gameScene.height / 10 * index // distribute the platforms across the screen
      }
    }

    // platform movement
    MovementAnimation {
      id: movement
      target: platform
      property: "y"
      velocity:  frog.impulse / 2 // impulse is y velocity of the frog
      running: frog.y < 210 // move only when the frog is jumping high enough
    }

    Frog {
      id: frog
      x: gameScene.width / 2 // place the frog in the horizontal center
      y: 220
    }

    // this platform is placed directly under the frog on the screen
     Platform {
       id: platform
       x: gameScene.width / 2
       y: 300
     }

     Keys.forwardTo: frog.controller

     Accelerometer {
       id: accelerometer
       active: true
     }

     Border {
        id: border
        x: -gameScene.width * 2
        y: gameScene.height - 10 // subtract a small value to make the border just visible in your scene
      }

     Image {
        id: scoreCounter
        source: "../../assets/scoreCounter.png"
        height: 80
        x: -15
        y: -15
        // text component to show the score
        Text {
          id: scoreText
          anchors.centerIn: parent
          color: "white"
          font.pixelSize: 32
          text: score
        }
      }

     MouseArea {
        id: mouseArea
        anchors.fill: gameScene.gameWindowAnchorItem
        onClicked: {
          if(gameScene.state === "start") { // if the game is ready and you click the screen we start the game
            gameScene.state = "playing"
          }
          if(gameScene.state === "gameOver") // if the frog is dead and you click the screen we restart the game
          {
            gameScene.state = "start"
          }
        }
      }

     Image {
        id: infoText
        anchors.centerIn: parent
        source: gameScene.state == "gameOver" ? "../../assets/gameOverText.png" : "../../assets/clickToPlayText.png"
        visible: gameScene.state !== "playing"
      }
     Image {
        id: menuButton
        source: "../../assets/optionsButton.png"
        x: gameScene.width - 96
        y: -40
        scale: 0.5
        MouseArea {
          id: menuButtonMouseArea
          anchors.fill: parent
          onClicked: {
            menuScenePressed() // trigger the menuScenePressed signal

            // reset the gameScene
            frog.die()
            gameScene.state = "start"
          }
        }
     }
//    SimpleButton {
//      text: "* Leaderboard *"
//      color: "orange"
//      visible: gameScene.state == "gameOver" // the button appears when the frog dies
//      onClicked: {
//        gameNetwork.showLeaderboard() // open the leaderboard view of the GameNetworkView
//      }
//    }
}
