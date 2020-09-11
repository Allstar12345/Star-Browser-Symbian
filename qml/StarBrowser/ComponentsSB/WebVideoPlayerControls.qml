/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../"

Rectangle{
    opacity:0
    z: 11
    id: root
    anchors.fill: parent;color:"Transparent"
    property bool open
    function hide(){open=false; controls.opacity=0}
    function show(){open=true;root.opacity=1; controls.opacity= largeQAButtons? 0.9:0.7
        controlstimer.start(); open=true;}
    Timer{
        id: controlstimer
        interval: 6000
        repeat: false
        running: false
        onTriggered: {hide()}
    }
    function getTimeFromMSec(msec) {
        if (msec <= 0 || msec == undefined) {
            return "0:00"

        } else {
            var sec = "" + Math.floor(msec / 1000) % 60
            if (sec.length == 1)
                sec = "0" + sec

            var hour = Math.floor(msec / 3600000)
            if (hour < 1) {
                return Math.floor(msec / 60000) + ":" + sec
            } else {
                var min = "" + Math.floor(msec / 60000) % 60
                if (min.length == 1)
                    min = "0" + min

                return hour + ":" + min + ":" + sec
            }
        }
    }

Rectangle{
    id: controls
    Behavior on opacity{NumberAnimation{}}
    visible: true
    height: largeQAButtons?190:150
    opacity: 0
    color: "black"
    anchors{
        right: parent.right
        left: parent.left
        bottom: parent.bottom
    }
    onWidthChanged: {
        if (controls.width=== 640){

        }

        else if (controls.width=== 360){

        }

    }

    Timer {
        id: longpressff
        interval: 100
        repeat: true
        onTriggered:{
         video.position += 2000
     }
    }

    Timer {
        id: longpressrw
        interval: 100
        repeat: true
        onTriggered:{
         video.position -= 2000
     }
    }

    Text {
        id: currentTime
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -41
        color:largeQAButtons?"white": "lightgray"
        font.pixelSize: largeQAButtons?25:18
        text: getTimeFromMSec(slider.value)
    }
    Slider {
         id: slider
         anchors.top: parent.top
         anchors.left: parent.left
         anchors.right: parent.right
         anchors.rightMargin: largeQAButtons?60:50
         anchors.leftMargin: largeQAButtons?60:50
         width: parent.width
         maximumValue: video.duration
         stepSize: 1000
         onPressedChanged: {if (!pressed)  video.position = value
         }

         Binding {
             target: slider
             property: "value"
             value: video.position
             when: !slider.pressed
       }
    }
    Text {
        id: durationTime
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -41
        color:largeQAButtons?"white": "lightgray"
        font.pixelSize:largeQAButtons?25: 18
        text: getTimeFromMSec(video.duration)
    }

    MenuButton{
        id: playpause
        anchors{centerIn: parent;verticalCenterOffset: 20}
        height:largeQAButtons? 120: 90
        width: largeQAButtons? 120: 90
        customIconSize: true
        customIconWidth: largeQAButtons? "85": "65"
        imgSource: (video.paused == true || video.playing == false) ? "../img/play.svg" : "../img/pause.svg"
        onClicked:  if (video.playing == true) {
                        if (video.paused == true) {
                            video.play();
                      }
              else {
                   video.pause()
         } }
    }
    MenuButton{
        id: volumer
        buttonEnabled:video.hasAudio?true: false
        buttonPressed: video.volume===0?true: false
        anchors{right:parent.right; rightMargin: 20; verticalCenter: parent.verticalCenter;verticalCenterOffset: 18}
        height: largeQAButtons? 95:65
        width:  largeQAButtons? 95:65
        customIconSize: true
        customIconWidth:largeQAButtons? "62": "42"
        imgSource: video.volume===0? "../img/mute.svg": "../img/volume_increase.svg"
        //onClicked:
        //onHold: mute();

    }
    MenuButton{
        id:stoper
        anchors{left:parent.left; leftMargin: 20; verticalCenter: parent.verticalCenter;verticalCenterOffset: 18}
        height: largeQAButtons? 95:65
        width: largeQAButtons? 95:65
        customIconSize: true
        customIconWidth: largeQAButtons? "62": "42"
        imgSource:"../img/volume_decrease.svg"
       // onClicked:
    }

}

}
