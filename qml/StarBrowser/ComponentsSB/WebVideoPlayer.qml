/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import "../"
import QtMultimediaKit 1.1

AppPage{
colour: "Black"
 id: videoPlayer
 Component.onCompleted: {show(); toolbar.appear();webViewHidden=true; volumeDecider();video.play();}
 TopToolBar{id: toolbar; setDuration: "900"
     ToolButtonSense {
         id: btnBack
         anchors.left: parent.left
         imgsource: "../img/back_flat.svg"
         onClicked: {close();}
   }
 }

 function volumeDecider(){if (appsettings.getSystemSetting ("audiovolume", "")==="") {video.volume=0.2} else{video.volume=appsettings.getSystemSetting("audiovolume", "")} ;}
 BufferIndicator{id: buff
 anchors{top:toolbar.bottom;left:parent.left; right:parent.right; bottom:parent.bottom}
 }
 Video{
     id: video
     focus: true
     visible: true
     anchors.fill: parent
     volume : 0.0;
    onBufferProgressChanged: {if(video.bufferProgress=== 0){buff.start()} else{buff.stop();}  }

     autoLoad: false
     source: requestedVideoURL
     fillMode: Video.PreserveAspectFit


     MouseArea{
          anchors.fill: parent
          enabled:true
          onClicked:{
              if (controls.open===true){controls.hide();}
              else {controls.show();}
          }
      }
      onStopped: {
              controls.hide();
              appsettings.saveSystemSetting("audiovolume", video.volume)
          appsettings.saveSystemSetting("volumeChangerValue", volumeChanger.value)

      }
      onStarted: {}

 }
 WebVideoPlayerControls{
     z:1
     id: controls
     anchors{
        fill:parent
     }
     Component.onCompleted: {controls.show();}
 }

}
