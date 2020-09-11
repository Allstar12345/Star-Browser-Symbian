/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
Rectangle {
    id:page
     anchors.fill: parent
     property alias colour: page.color
     property string pageId:""
     property int intervall
     color: "white"
     visible: true
     Timer{id: closer; interval: intervall; running: false; repeat: false; onTriggered:{page.destroy(0)}}
     function show(){opacity=1}
     function showCustomOpacity(opa){opacity=opa}
     function hide(){opacity=0}
     function close(){opacity=0; page.destroy(500)}
     function closeTimed(intervall) {closer.start();}
     opacity:0
     z: 10
     Behavior on opacity{NumberAnimation{}}
}
