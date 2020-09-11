/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import "ComponentsSB"
import com.nokia.symbian 1.1
import QtQuick 1.1
SliderDialog{visible: true
    headerText: "Night Cover Intensity"
    svalue:nightcover.opacity
    transbackground: true
    round1:true
    onClosePressed:{if(coveralreadyopen===true){}else{nightcover.visible=false};appsettings.saveSystemSetting("nightcoveropa", slider.value);slider.opacity=0 }
    Component.onCompleted: {if(nightcover.visible===false){nightcover.visible=true} else{coveralreadyopen=true}}
Slider{z: 10;minimumValue: 0.550;maximumValue:0.94; onValueChanged: {
        if (pressed) nightcover.opacity=value
    }
     Behavior on opacity{NumberAnimation{duration: 100}}
    Binding {
                when: !slider.pressed
                target: slider
                property: "value"
                value: nightcover.opacity
            }
    id: slider;width: parent.width-30;anchors{horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter; verticalCenterOffset: 40}}}
