/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../"

Rectangle{
    id: newpass
    anchors.fill: parent
    color: "black"
    z: 10
    opacity:0
    onWidthChanged: {if(screen.width===360) {if(cpf.focus===true){
                toolbar.appear()}
        }
        if(screen.width===640){
            if(cpf.focus===true){
            toolbar.disappear();}
        }
        if(screen.width===360) {if(phrasefield.focus===true){
                        toolbar.appear();cpf.height=55}
                }
                if(screen.width===640){
                    if(phrasefield.focus===true){
                    toolbar.disappear();
                     cpf.height=40}
                }
    }
    Behavior on opacity{NumberAnimation{}}
    Component.onCompleted: {newpass.opacity=1;toolbar.appear();contentappear.start()}
    Timer{id: contentappear; interval:550; onTriggered: {listheading1.opacity=1; pf.opacity=1;cpf.opacity=1; phrasefield.opacity=1;newpassrow.opacity=1;cancel.opacity=1;}}
    function close(){newpass.opacity=0; killTimer.start(); opensecurity();}
    Timer{id: killTimer; interval: 400; onTriggered:{newpass.destroy();}}
    MouseArea{
        anchors.fill: parent
    }
    TopToolBar{
        id: toolbar
        setDuration: "500"
                ToolButtonSense {
                    id: btnBack
                    imgsource: "../img/back_flat.svg"
                    onClicked: {  newpass.opacity=0; killTimer.start();
                 }
              }
                }

    ListHeader{
        id: listheading1
        z: 1
        Behavior on opacity{ NumberAnimation {} }
        opacity: 0
        anchors.top: toolbar.bottom

        headerText:"Please Enter A Password And Phrase"
}

TextField{
    id: pf
    Behavior on opacity{ NumberAnimation {} }
    opacity: 0
    anchors.right: parent.right
    anchors.left: parent.left
    height: 55
    anchors.top: listheading1.bottom
    anchors.topMargin: 15
    errorHighlight: pf.text? false: true
    echoMode: TextInput.Password
    placeholderText: "Enter your password here"
}
TextField{
    id: cpf
    Behavior on opacity{ NumberAnimation {} }
    opacity: 0
    anchors.right: parent.right
    anchors.left: parent.left
    height: 55
    Behavior on height {NumberAnimation{easing.type: Easing.InOutQuart}}
    text:""
    anchors.top: pf.bottom
    errorHighlight: cpf.text? false: true
   echoMode: TextInput.Password
    placeholderText: "Confirm Password"
    onActiveFocusChanged: {if(screen.height===360){
            if(cpf.focus===true){
                toolbar.disappear();
            }
            else if (cpf.focus===false){toolbar.appear();}

        }}
}

TextField{
    height: 55
    Behavior on opacity{ NumberAnimation {} }
    opacity: 0
    id: phrasefield
    anchors.right: parent.right
    anchors.left: parent.left
    echoMode: TextInput.Password
     inputMethodHints: Qt.ImhNoAutoUppercase
    errorHighlight: phrasefield.text? false: true
    anchors.top: cpf.bottom
    placeholderText: "Enter Your Secret Passphrase Here"
    onActiveFocusChanged: {if(screen.height===360){
            if(phrasefield.focus===true){
                cpf.height=40
                toolbar.disappear();
            }
            else if (phrasefield.focus===false){toolbar.appear();cpf.height=55}

        }}
}


ButtonRow{
id: newpassrow
Behavior on opacity{ NumberAnimation {} }
opacity: 0
anchors.top: phrasefield.bottom
anchors.topMargin: 2
anchors.left: parent.left
anchors.right: parent.right
ToolButton{
    text: "Save Password & Phrase"
    onClicked:{

        if(pf.text===cpf.text){ appsettings.saveSystemSetting("ap", pf.text)
            appsettings.saveSystemSetting("fpa", phrasefield.text)
            console.debug(appsettings.getSystemSetting("ap", ""))
            close()
            openSecurityMain()}
        else{banner.showText("Passwords do not match")}

    }

}
}
ButtonRow{
    id: cancel
    Behavior on opacity{ NumberAnimation {} }
    opacity: 0
    anchors.top: newpassrow.bottom
    anchors.topMargin: 2
    anchors.left: parent.left
    anchors.right: parent.right
    ToolButton{
        text: "Cancel"
        onClicked:{
            newpass.opacity=0; killTimer.start();
        }
    }
}
}
