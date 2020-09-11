/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import "../"
AppPage{
  colour: "#00aaff"
  id: restartDialog
  Component.onCompleted:{ show();}

  MouseArea{anchors.fill: parent; enabled: true}

  ButtonSenseFloat{id: res
     buttonText:"Restart"
     anchors.right: parent.right
     anchors.rightMargin:5
     anchors.bottom:parent.bottom
     anchors.bottomMargin: 2
 onClicked: {restartStarBrowser();}
  }
  ButtonSenseFloat{id: dismiss
  buttonText:"Later"
   anchors.bottom:parent.bottom
   anchors.left:parent.left
   anchors.leftMargin: 5
   anchors.bottomMargin: 2
 onClicked: {close()}
  }
  Text{id: basetext
  color: "#ffffff"
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.top:parent.top
      anchors.topMargin:2
      text:"Star Browser needs to restart\nTo make Changes"
      verticalAlignment: Text.AlignVCenter
      horizontalAlignment: Text.AlignHCenter
      font.pointSize: 10
      width: parent.width-10
  }
  Image{
      id: img
      source:"../img/settings_flat.svg"
      sourceSize.height: 180
      sourceSize.width: 180
      width: sourceSize.width
      height: sourceSize.height
      anchors.top:basetext.bottom
      anchors.topMargin: 45
      anchors.horizontalCenter: parent.horizontalCenter
  }



}
