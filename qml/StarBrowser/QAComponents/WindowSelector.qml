/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import "../ComponentsSB"
import "../"
Rectangle{
    color: "black"
    id: root
    opacity: 0
    z:2
    anchors.fill:parent
    Behavior on opacity{NumberAnimation{}}
    Component.onCompleted: opacity=0.8
    function close(){ root.opacity=0; root.destroy(1500); rectangle1.anchors.bottomMargin=-400;}
    MouseArea{anchors.fill: parent; enabled:true; onClicked: {close();}}
     Rectangle{
     MouseArea{anchors.fill: parent; enabled:true}
    id: rectangle1
    Behavior on anchors.bottomMargin {SmoothedAnimation{duration:2000; maximumEasingTime:2600}}
    opacity: 1
    height: windowserver.maxWindows==6? 360:205
    Component.onCompleted: {anchors.bottomMargin=0}
    anchors{left: parent.left; right:parent.right; bottom: parent.bottom; bottomMargin: -380}
    z: 10
    color: popupbutton.color
MouseArea{anchors.fill: parent; enabled:true}
    ToolButtonSenseFloat{id: s; anchors{top:parent.top;horizontalCenter: parent.horizontalCenter }
        imgsource: "../img/add_flat.svg"; buttonBackground: false
        onClicked: {
            if(windowserver.w1open===false){windowserver.openWindow(1);close();}
            else if(windowserver.w2open===false){windowserver.openWindow(2);close();}
             else if(windowserver.w3open===false){windowserver.openWindow(3);close();}
             else if(windowserver.w4open===false){windowserver.openWindow(4);close();}
             else if(windowserver.w5open===false){windowserver.openWindow(5);close();}
             else if(windowserver.w6open===false){windowserver.openWindow(6);close();}
        }
    }
    ToolButtonSenseFloat{id: closer; anchors.left: parent.left; anchors.leftMargin: 0; anchors{top:parent.top;}
        imgsource: "../img/back_flat.svg"; buttonBackground: false
        onClicked: {
            close();
        }
    }
    ButtonSenseFloat{
         buttonText:"Close All"
         buttonBackground: false
         opacity: windowserver.openWindows? 1:0
         anchors.right:parent.right; anchors{top:parent.top;topMargin:4}
         onClicked:windowserver.closeAllWindows();
    }

    Column{
        anchors.top: s.bottom
    WindowListItem{
        text: screen.width===640?windowserver.w1Title.length > 40 ? windowserver.w1Title.substring(0,100) + "..." :windowserver.w1Title:  windowserver.w1Title.length > 40 ? windowserver.w1Title.substring(0,100) + "..." :windowserver.w1Title
         opacity:windowserver.w1open? 1:0
         onClicked: {windowserver.openWindow(1); close();}
        ToolButtonSenseDialog{
          z: 11
          imgsource: "../img/close_stop_flat.svg"; height: largeQAButtons?65:50; width:largeQAButtons?65:50;
          anchors.right: parent.right
          anchors.rightMargin: 10
          visible: windowserver.w1open
          onClicked: windowserver.closew1()
        }
    }
    WindowListItem{
       opacity:windowserver.w2open? 1:0
       text: screen.width===640?windowserver.w2Title.length > 40 ? windowserver.w2Title.substring(0,170) + "..." :windowserver.w2Title:  windowserver.w2Title.length > 40 ? windowserver.w2Title.substring(0,40) + "..." :windowserver.w2Title
        onClicked: {windowserver.openWindow(2); close();}
        ToolButtonSenseDialog{
          z: 11
          imgsource: "../img/close_stop_flat.svg"; height: largeQAButtons?60:50; width: largeQAButtons?60:50;
          anchors.right: parent.right
          anchors.rightMargin: 10
          visible: windowserver.w2open
          onClicked: windowserver.closew2()
        }
    }
    WindowListItem{
        id:w3i
         opacity:windowserver.w3open? 1:0
          Component.onCompleted:{if(windowserver.maxWindows==2) w3i.destroy()}
         text: screen.width===640?windowserver.w3Title.length > 40 ? windowserver.w3Title.substring(0,170) + "..." :windowserver.w3Title:  windowserver.w3Title.length > 40 ? windowserver.w3Title.substring(0,40) + "..." :windowserver.w3Title

        onClicked: {windowserver.openWindow(3); close();}
        ToolButtonSenseDialog{
          z: 11
          imgsource: "../img/close_stop_flat.svg"; height: largeQAButtons?60:50; width:largeQAButtons?60:50;
          anchors.right: parent.right
          anchors.rightMargin: 10
          visible: windowserver.w3open
          onClicked: windowserver.closew3()
        }
    }
    WindowListItem{
        id: w4i
        opacity:windowserver.w4open? 1:0
        text: screen.width===640?windowserver.w4Title.length > 40 ? windowserver.w4Title.substring(0,170) + "..." :windowserver.w4Title:  windowserver.w4Title.length > 40 ? windowserver.w4Title.substring(0,40) + "..." :windowserver.w4Title

        onClicked: {windowserver.openWindow(4); close();}
        Component.onCompleted:{if(windowserver.maxWindows==3) w4i.destroy()}
        ToolButtonSenseDialog{
          z: 11
          imgsource: "../img/close_stop_flat.svg"; height: largeQAButtons?60:50; width: largeQAButtons?60:50;
          anchors.right: parent.right
          anchors.rightMargin: 10
          visible: windowserver.w4open
          onClicked: windowserver.closew4()
        }
    }
    WindowListItem{
        id: w5i
        opacity:windowserver.w5open? 1:0
        text: screen.width===640?windowserver.w5Title.length > 40 ? windowserver.w5Title.substring(0,170) + "..." :windowserver.w5Title:  windowserver.w5Title.length > 40 ? windowserver.w5Title.substring(0,40) + "..." :windowserver.w5Title

        onClicked: {windowserver.openWindow(5); close();}
         Component.onCompleted:{if(windowserver.maxWindows==3) w5i.destroy()}
         ToolButtonSenseDialog{
           z: 11
           imgsource: "../img/close_stop_flat.svg"; height:largeQAButtons?60:50; width: largeQAButtons?60:50;
           anchors.right: parent.right
           anchors.rightMargin: 10
           visible: windowserver.w5open
           onClicked: windowserver.closew5()
         }
    }
    WindowListItem{
        id: w6i
        opacity:windowserver.w6open? 1:0
        text: screen.width===640?windowserver.w6Title.length > 40 ? windowserver.w6Title.substring(0,170) + "..." :windowserver.w6Title:  windowserver.w6Title.length > 40 ? windowserver.w6Title.substring(0,40) + "..." :windowserver.w6Title

        onClicked: {windowserver.openWindow(6); close();}
         Component.onCompleted:{if(windowserver.maxWindows==3) w6i.destroy()}
         ToolButtonSenseDialog{
           z: 11
           imgsource: "../img/close_stop_flat.svg"; height: largeQAButtons?60:50; width: largeQAButtons?60:50;
           anchors.right: parent.right
           anchors.rightMargin: 10
           visible: windowserver.w6open
           onClicked: windowserver.closew6()
         }
    }

    }
}

}
