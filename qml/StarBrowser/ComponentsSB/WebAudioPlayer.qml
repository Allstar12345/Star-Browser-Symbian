/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import QtMultimediaKit 1.1
import DownloadBackend 1.0
import "../"
Rectangle{
    id: roote
    anchors.fill: parent
    color: "black"
    visible: webAudioPlayerVisible
    property string name
    property Component a: null
    Component.onCompleted: {roote.opacity=1;toolbarappeardelay.start();webViewHidden=true; volumeDecider()}
    Behavior on opacity{NumberAnimation{}}
    Timer{interval: 1150; id: listappear; onTriggered:{bmView.opacity=1}}
    Timer{id: toolbarappeardelay; interval: 200; onTriggered: {toolbar.appear();}}
    function closePage(){ webAudioPlaying=false; appsettings.saveSystemSetting("audiovolume", aud.volume);roote.opacity=0;roote.destroy(800); webViewHidden=false;}
    function volumeDecider(){if (appsettings.getSystemSetting ("audiovolume", "")==="") {aud.volume=0.2} else{aud.volume=appsettings.getSystemSetting("audiovolume", "")} ;}
    Audio{id: aud; volume : 0.0;  onBufferProgressChanged: {if(aud.bufferProgress=== 0){buff.start()} else{buff.stop();}  } onPlayingChanged: {if(playing) webAudioPlaying=true; else{ webAudioPlaying=false}} source: requestedAudioURL; onSourceChanged:{} onVolumeChanged: console.log(aud.volume)}
    Timer{interval: 500;running:true; repeat:false; onTriggered: {playbut.flash(800)}}
DownloadBackend{id:download}
Connections{
    target: basepage
    onStopStreamAudio:{aud.stop();closePage();}
    onPlayStreamAudio:{aud.play()}
    onRequestVolumeIncrease:{if(aud.volume===1.0){}
        else{volumeChanger.open(); aud.volume+=0.1;volumeChanger.value+=40;appsettings.saveSystemSetting("volumeChangerValue", volumeChanger.value)}}
    onRequestVolumeDecrease:{if(aud.volume===0.09999999403953552){aud.volume=0.0}
        else{
        volumeChanger.open(); aud.volume-=0.1;volumeChanger.value-=40;appsettings.saveSystemSetting("volumeChangerValue", volumeChanger.value) }}
}
function downloadFile(){
    var name; name= aud.metaData.title + ".mp3" ; download.addFromQML(requestedAudioURL, name)
}
    TopToolBar{
        id: toolbar
        radius: 0
               ToolButtonSense {
                   id: btnBack
                   anchors.left: parent.left
                   imgsource: "../img/back_flat.svg"
                   onClicked: {closePage();}
             }

              ToolButtonSense{
                  imgsource: "../img/save.svg"
                  anchors.centerIn: parent
                  visible: requestedAudioURL.indexOf("file:///") > -1 ? false:true
                  onClicked:{downloadFile()}
              }
               ButtonSense{
                   buttonText: "Hide"
                   visible: webAudioPlaying
                   anchors.right: parent.right
                   onClicked: {;webViewHidden=false; webAudioPlayerVisible=false}
               }

    }
    BufferIndicator{id: buff
    anchors{top:toolbar.bottom;left:parent.left; right:parent.right; bottom:parent.bottom}
    }
   WebAudioVolumeChanger{z:1
     id: volumeChanger
     anchors{top:toolbar.bottom;left:parent.left; right:parent.right; bottom:volinc.top; bottomMargin:2}
   }

   Image{
       id: img
       anchors.verticalCenterOffset: -65
       anchors.horizontalCenterOffset: 0
       anchors.centerIn: parent
       sourceSize.width: screen.width===640? 150:180
       sourceSize.height: screen.width===640? 150:180
       width: sourceSize.width
       height:sourceSize.height
       source:"../img/music.svg"
   }

    Slider {
         id: slider
         width: parent.width
         anchors.verticalCenterOffset: screen.width===640? 70:105
         anchors.horizontalCenter: parent.horizontalCenter
         anchors.verticalCenter: parent.verticalCenter
         maximumValue: aud.duration
         stepSize: 1000
         onPressedChanged: {
             if (!pressed)
                 aud.position = value
         }

         Binding {
             target: slider
             property: "value"
             value: aud.position
             when: !slider.pressed
       }
    }
    Text{
        text:aud.metaData.title
        anchors.bottom: slider.top
        anchors.bottomMargin: 10
        color:"white"
        width:parent.width-10
        font.pointSize: largeQAButtons?8:7
        anchors.horizontalCenter: parent.horizontalCenter
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        maximumLineCount: 2

    }

    MenuButton{
    id: playbut
    anchors{
        bottom:parent.bottom
        bottomMargin: 5
       horizontalCenter: parent.horizontalCenter
}
    height: 100
    customIconWidth: "50"
    customIconSize: true
    width: 100
    imgSource:aud.playing? "../img/stop.svg":"../img/play.svg"
    onClicked: {aud.playing? aud.stop(): aud.play()}
    }

    MenuButton{
        id: volinc
        buttonEnabled: webAudioPlaying
        anchors{
            right:parent.right
            bottom:parent.bottom
            bottomMargin: 5
            rightMargin: 10}
        onHold:{holdIncrease.start();}
        onReleased: {holdIncrease.stop();}
        Timer{id: holdIncrease; repeat:true; interval: 300;onTriggered:{ if(aud.volume===1.0){}
                else{volumeChanger.open(); aud.volume+=0.1;volumeChanger.value+=40;appsettings.saveSystemSetting("volumeChangerValue", volumeChanger.value)}} }
        height: 100
        customIconWidth: "50"
        customIconSize: true
        width: 100
        imgSource: "../img/volume_increase.svg"
        onClicked: {
            if(aud.volume===1.0){}
                else{volumeChanger.open(); aud.volume+=0.1;volumeChanger.value+=40;appsettings.saveSystemSetting("volumeChangerValue", volumeChanger.value)}
    }
    }
    MenuButton{
        id: voldec
         buttonEnabled: webAudioPlaying
        anchors{
            left:parent.left
            bottom:parent.bottom
            bottomMargin: 5
            leftMargin: 10}
            Timer{id: holdDecrease; repeat:true; interval: 300; onTriggered:{if(aud.volume===0.09999999403953552){}
                    else{
                    volumeChanger.open(); aud.volume-=0.1;volumeChanger.value-=40;appsettings.saveSystemSetting("volumeChangerValue", volumeChanger.value) }}}
        height: 100
        customIconWidth: "50"
        customIconSize: true
        width: 100
        imgSource: "../img/volume_decrease.svg"
        onHold:{holdDecrease.start();}
        onReleased: {holdDecrease.stop();}


          onClicked: {
              if(aud.volume===0.09999999403953552){}
              else{
              volumeChanger.open(); aud.volume-=0.1;volumeChanger.value-=40;appsettings.saveSystemSetting("volumeChangerValue", volumeChanger.value) }}
    }

}
