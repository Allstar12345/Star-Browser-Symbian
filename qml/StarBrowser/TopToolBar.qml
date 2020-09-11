/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
Rectangle{
id: toolbar
z: 5
anchors.top: parent.top
anchors.left: parent.left
anchors.right: parent.right
anchors.topMargin: -70
property string setDuration: "850"
function appear(){appearslide.start();}
function disappear(){disappearslide.start();}
PropertyAnimation{duration: setDuration;id: appearslide; to: 0; property: "anchors.topMargin"; target:toolbar}
PropertyAnimation{duration: setDuration;id: disappearslide; to: -70; property: "anchors.topMargin"; target:toolbar}

color: if (appsettings.getSystemSetting("toolbarcolour", "")=== ""){"#0f0f0a"}
       else{ appsettings.getSystemSetting("toolbarcolour", "")}

    implicitWidth: Math.max(50, screen.width)
    implicitHeight: (screen.width < screen.height)
    ? privateStyle.toolBarHeightPortrait
    : privateStyle.toolBarHeightLandscape
     opacity: 0.50
     MouseArea{anchors.fill: parent;enabled:true}
}
