/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../"
Rectangle{
    property alias imageSource: img.source
    Behavior on height {NumberAnimation{}}
    Behavior on opacity{NumberAnimation{}}
    signal clicked
    signal released
    signal hold
    signal closeButtonClicked
    signal closeButtonReleased
    signal actionButtonClicked
    signal holdCloseButton
    property bool closeButton: closebut.visible
    property bool loadingScreen
    onLoadingScreenChanged: {if(loadingScreen===true)ind.start();
        else{ind.stop(); }
    }
    z:5
    id: rooter
    opacity: mouse.pressed?0.6 : 1
    color:"transparent"
    height: img.height
    width: img.width
    MenuButton{
        opacity: loadingScreen? 0: 0.9
        z:9
        darkHighlight: true
        customIconSize: true
        customIconWidth:"42"
        height: 60
        buttonPressed: false
        width: 60
        imgSource: "../img/refresh.svg"
        id: actionButton
        anchors{horizontalCenter:parent.horizontalCenter; bottom:parent.bottom; bottomMargin:8}
        onClicked:{actionButtonClicked();}
     }
Rectangle{
    MouseArea{  z: Infinity
        anchors.fill: parent
        onClicked: rooter.clicked();
        onReleased: rooter.released();
        onPressAndHold: rooter.hold();}
    id: loade
    anchors{top:parent.top; bottom:parent.bottom; left:parent.left; right:parent.right}
    color:"black"
    z:7
    Behavior on opacity{NumberAnimation{}}
    opacity: loadingScreen? 0.7: 0
    SwitcherLoadingIndicator{id: ind}
}


    Component.onCompleted: {
actionButton.visible=false;
        if(screen.currentOrientation===2){
        img.sourceSize.height=260; img.height= 260; rooter.height=260;actionButton.visible=true;}
        else if (screen.currentOrientation===1) {img.sourceSize.height=360; img.height= 350; rooter.height=360;actionButton.visible=true;}
        if(screen.height===480){img.sourceSize.height=360; img.height= 360; rooter.height=360;actionButton.visible=true}
    }
    QtObject {
        id: internal
        property bool portrait: screen.currentOrientation == Screen.Portrait || screen.currentOrientation == Screen.PortraitInverted
        onPortraitChanged: {
     actionButton.visible=false;
            if(screen.currentOrientation===2){
            img.sourceSize.height=260; img.height= 260; rooter.height=260;actionButton.visible=true;}
            else if (screen.currentOrientation===1) {img.sourceSize.height=360; img.height= 360; rooter.height=360;actionButton.visible=true;}
        }
    }
    Image{
        id: closebut
        z:7
        Behavior on opacity {NumberAnimation{duration: 50;easing.type: Easing.Linear;}}
        visible: closeButton
        source:"../img/window_switcher_close.svg"
        sourceSize.height:largeQAButtons? 45:35
        sourceSize.width: largeQAButtons? 45:35
        opacity: closeMouse.pressed? 0.6:0.90
        smooth: true
        height: sourceSize.height
        width: sourceSize.width
        anchors{top:parent.top; right:parent.right; rightMargin: -10; topMargin:-10}
        MouseArea{anchors.fill:parent; id: closeMouse
            onClicked:rooter.closeButtonClicked();
            onPressAndHold: rooter.holdCloseButton();
            onReleased: rooter.closeButtonReleased()
        }
    }

    Image{
        z:6
        id: img
        opacity: mouse.pressed?0.6 : 1
        cache:false
        clip:true
        smooth:true
        onStatusChanged:{if(img.status===Image.Error)source="../img/web_page.svg";  }
        Behavior on opacity {NumberAnimation{duration: 80;easing.type: Easing.Linear;}}
        asynchronous: true
        anchors.fill: parent
        Behavior on height {NumberAnimation{}}
        fillMode: Image.PreserveAspectCrop
        width: 210
        MouseArea{id:mouse
            z: 8
            anchors.fill: parent
            onClicked: rooter.clicked();
            onReleased: rooter.released();
            onPressAndHold: rooter.hold();
        }
    }
}
