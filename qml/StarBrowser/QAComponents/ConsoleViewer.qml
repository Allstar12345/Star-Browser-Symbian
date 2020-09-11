/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import "../"
import com.nokia.symbian 1.1


Rectangle {
 id: root
 anchors.fill:parent
 color:nightMode? "black": popupbutton.colour
 Behavior on color {ColorAnimation{}}
 Behavior on opacity {NumberAnimation{}}
 opacity: 0
 property bool nightMode
 Component.onCompleted: {root.opacity=1;if(appsettings.getJSSetting()===false){off.visible=true;settingsbut.visible=true;} else{off.visible=false; settingsbut.visible=false; night.visible=true;textArea.visible=true;refresh.visible=true;textArea.text= QMLUtils.jsLog();}}
TextAreaa{readOnly: true;id:textArea; nightMode: root.nightMode;visible:false; anchors{top:parent.top; bottom: closeBut.top;bottomMargin:largeQAButtons?15:10} width:parent.width;}


 Text{id: off
     color: "#ffffff"
     text:"Logging not turned on\nturn on from Settings"
     verticalAlignment: Text.AlignVCenter
     horizontalAlignment: Text.AlignHCenter
     font.pointSize: 13
     styleColor: "#ffffff"
     anchors.centerIn: parent
 }
 ToolButtonSenseFloat{buttonBackground: nightMode?false:true;onClicked:{nightMode= !nightMode}id: night;visible:false;imgsource:"../img/night_flat.svg";anchors{right: parent.right; rightMargin:5;bottom:parent.bottom; bottomMargin:5;}}
 ToolButtonSenseFloat{buttonBackground: nightMode?false:true;onClicked:{textArea.text=""; textArea.text=QMLUtils.jsLog(); }id: refresh;visible:false;imgsource:"../img/refresh_flat.svg";anchors{horizontalCenter: parent.horizontalCenter;bottom:parent.bottom; bottomMargin:5;}}
 ToolButtonSenseFloat{buttonBackground: nightMode?false:true;onClicked:{root.opacity=0;root.destroy(600)} id:closeBut;imgsource:"../img/close_stop_flat.svg"; anchors{left:parent.left;leftMargin:5; bottom:parent.bottom; bottomMargin:5}}

 ButtonSenseFloat{buttonBackground: nightMode?false:true;id: settingsbut;onClicked:{opendevsettings(); root.destroy(600)}buttonText:"Settings"; anchors{horizontalCenter:parent.horizontalCenter; bottom:parent.bottom; bottomMargin:5}}
// add button for nightmode, black backround white text

}
