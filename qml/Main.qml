import Felgo 3.0
 import QtQuick 2.0
 import "scenes"

 GameWindow {
   id: gameWindow

   // window size
   screenWidth: 640
   screenHeight: 960

   activeScene: gameScene

   EntityManager {
     id: entityManager
     entityContainer: gameScene
   }

   FelgoGameNetwork {
     id: gameNetwork
     gameId: 802 // put your gameId here
     secret: "sccr345smth534random23144ff42" // put your game secret here
     gameNetworkView: frogNetworkView

     achievements: [
       Achievement {
         key: "5opens"
         name: "Game Opener"
         target: 5
         points: 10
         description: "Open this game 5 times"
       },

       Achievement {
         key: "die100"
         name: "Y U DO DIS?"
         iconSource: "../assets/achievementImage.png"
         target: 100
         description: "Die 100 times"
       }
     ]
   }

   GameScene {
     id: gameScene
     onMenuScenePressed: gameWindow.state = "menu"
   }

   MenuScene {
     id: menuScene
     onGameScenePressed: gameWindow.state = "game"

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
   }

   // starting state is menu
   state: "menu"

   // state machine, takes care of reversing the PropertyChanges when changing the state. e.g. it changes the opacity back to 0
   states: [
    State {
      name: "menu"
      PropertyChanges {target: menuScene; opacity: 1}
      PropertyChanges {target: gameWindow; activeScene: menuScene}
    },
    State {
      name: "game"
      PropertyChanges {target: gameScene; opacity: 1}
      PropertyChanges {target: gameWindow; activeScene: gameScene}
    }
   ]
 }
