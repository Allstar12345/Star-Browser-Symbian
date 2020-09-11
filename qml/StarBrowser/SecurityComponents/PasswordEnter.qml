/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../"

Rectangle{
    id: enterpassstart
    anchors.fill: parent
    color: "black"
    z: 10
    Timer{id: hideDelay; interval: 300; onTriggered:{enterpassstart.opacity=0; killTimer.start()}}
    Behavior on opacity{NumberAnimation{}}
    Component.onCompleted: {enterpassstart.visible=true;toolbar.appear();contentappear.start()}
    Timer{id: contentappear; interval:450; onTriggered: {listheading2.opacity=1; enterpass.opacity=1; row.opacity=1; row2.opacity=1; war.opacity=1}}
    function close(){hideDelay.start()}
    Timer{id: killTimer; interval: 400; onTriggered:{enterpassstart.destroy();}}
    MouseArea{
        anchors.fill: parent
    }
    TopToolBar{
        id: toolbar
        setDuration: "400"
                ToolButtonSense {
                    id: btnBack
                    imgsource: "../img/back_flat.svg"
                    onClicked: {close()
                 }
              }
                }
    ListHeader{
        id: listheading2
        z: 1
        Behavior on opacity{ NumberAnimation {} }
        opacity: 0
        anchors.top: toolbar.bottom
        headerText:"Please Enter Your Password"
}

    TextField{
        Behavior on opacity{ NumberAnimation {} }
        opacity: 0
        id: enterpass
        anchors.top: listheading2.bottom
        anchors.topMargin: 10
        text:""
        inputMethodHints: Qt.ImhNoAutoUppercase
        anchors.right: parent.right
        errorHighlight: enterpass.text? false: true
        anchors.left: parent.left
        echoMode: TextInput.Password
        placeholderText: "Enter Password Here"

    }
    ButtonRow{
        Behavior on opacity{ NumberAnimation {} }
        opacity: 0
        id: row
        anchors.top: enterpass.bottom
        anchors.topMargin: 2
        anchors.right: parent.right
        anchors.left: parent.left
        ToolButton{
            text: "Continue"
            onClicked: {
                var bob
                bob=appsettings.getSystemSetting("ap", "");
                console.log(bob)
                if (enterpass.text ===bob){
               banner.showText ("Password Accepted")
                   close();
                    openSecurityMain();
            }
            else{
                banner.showText ("Password Incorrect");enterpass.text=""
            }
        }
    }
    }
    ButtonRow{
        id: row2
        Behavior on opacity{ NumberAnimation {} }
        opacity: 0
        anchors.top: row.bottom
        anchors.bottomMargin: 2
        anchors.right: parent.right
        anchors.left: parent.left
        ToolButton{
            text: "Forgot Your Password?"
            onClicked:{
                openforgotpassword()
                close()
            }
        }
    }
    Text{
        id: war
        anchors.top:row2.bottom
        Behavior on opacity{ NumberAnimation {} }
        anchors.topMargin: 2
        opacity: 0
        width: parent.width-20
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 5
        wrapMode: Text.Wrap
        maximumLineCount: 2
        anchors.horizontalCenter: parent.horizontalCenter
        color:"white"
        text:"Ensure Password is hidden before pressing Continue"
    }
}
