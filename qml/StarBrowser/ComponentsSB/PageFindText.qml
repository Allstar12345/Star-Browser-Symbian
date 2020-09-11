/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import "../"
import com.nokia.symbian 1.1
Rectangle{
    anchors.fill: parent
    z: 2
    property string colour:popupbutton.colour
    id: root
    opacity: 0
    clip: true
    Behavior on opacity {NumberAnimation{} }
    color: "transparent"
    Component.onCompleted: {open();flickable1.anchors.topMargin= 110;flickable1.anchors.bottomMargin= 80}
    function open(){
        root.opacity=0.900;
        bobappear.start();
        topappear.start();
}

    function close(){
        root.opacity=0
        root.destroy(500);
        fixmargins();
    }

    SmoothedAnimation {id: bobappear; target: bottom; property:"anchors.bottomMargin"; to:0; duration: 800}
    Rectangle{height: 80; id: bottom; color: colour ;anchors{right: parent.right; left: parent.left; bottom: parent.bottom; bottomMargin: -90}
        MenuButtonLabel{buttonText: "Close";anchors{verticalCenterOffset: -5;verticalCenter: parent.verticalCenter;horizontalCenter: parent.horizontalCenter} imgSource: "../img/close_stop_flat.svg"; onClicked:{ close();web_view1.findtxt("")}}

       // MenuButtonLabel{buttonText:"Back"; anchors{verticalCenter: parent.verticalCenter;verticalCenterOffset: -5; right:parent.right; rightMargin:90} imgSource: "../img/back_flat.svg"; onClicked: close();}

       // MenuButtonLabel{buttonText:"Next"; anchors{verticalCenter: parent.verticalCenter;verticalCenterOffset: -5;right:parent.right; rightMargin:5} imgSource: "../img/next_flat.svg"; onClicked: close();}

    }


    SmoothedAnimation {id: topappear; target: top; property:"anchors.topMargin"; to:0; duration: 800}
    Rectangle{height: 75; id: top; color: colour ;anchors{right: parent.right; left: parent.left; top:parent.top; topMargin:-75}

        TextField{
            onTextChanged: {web_view1.findtxt(text)}
            placeholderText: "Type here, all results will be highlighted"
            anchors{top:parent.top; topMargin:1; bottom: parent.bottom; bottomMargin: 1; rightMargin: 1;right:parent.right;left:parent.left; leftMargin:1}
        }

    }


}
