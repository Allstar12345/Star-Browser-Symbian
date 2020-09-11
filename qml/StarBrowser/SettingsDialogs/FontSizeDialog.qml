/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import "../ComponentsSB"
import com.nokia.symbian 1.1
import QtQuick 1.1
import "../"
SliderDialog{visible: true
        property int sizevalue: fontSize
    headerText: "Web Page Font Size"
    svalue:sizevalue
    transbackground: false
   // textround: "*1"
    onClosePressed:{ fs2.text="Current Size: " +Math.round (sizevalue)*1;appsettings.saveSystemSetting("fontsize", sizevalue);fontSize=sizevalue;slider.opacity=0;plusbut.opacity=0; minbut.opacity=0 }


Slider{z: 10;minimumValue: 10;maximumValue:35; onValueChanged: {
        if (pressed) sizevalue=value
    }
     Behavior on opacity{NumberAnimation{duration: 100}}
    Binding {
                when: !slider.pressed
                target: slider
                property: "value"
                value: sizevalue
            }
    id: slider;width: parent.width-85;anchors{horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter; verticalCenterOffset: 40}}
ToolButtonSenseFloat{
    id: minbut
    sourceSize.height:48;sourceSize.width: 48;z:11; buttonBackground: false;
    anchors{left:parent.left; leftMargin:-1; verticalCenter: slider.verticalCenter}
      imgsource:"../img/minus-flat.svg"
      Behavior on opacity{NumberAnimation{duration: 100}}
      onClicked:{if(sizevalue>slider.minimumValue){sizevalue-=1}
      }
}
ToolButtonSenseFloat{
    id: plusbut
     sourceSize.height:48;sourceSize.width: 48; z:11; buttonBackground: false;
    anchors{right:parent.right; rightMargin:1; verticalCenter: slider.verticalCenter}
      imgsource:"../img/add_flat.svg"
      Behavior on opacity{NumberAnimation{duration: 100}}
      onClicked:{
          if(sizevalue<slider.maximumValue){sizevalue+=1}

      }
}

}
