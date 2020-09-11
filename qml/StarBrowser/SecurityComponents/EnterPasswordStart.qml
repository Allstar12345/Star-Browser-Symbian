/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../"
AppPage{
    id: enterpassrun
    colour: "black"
    z: Infinity
    visible: true
    MouseArea{
        anchors.fill: parent
    }
    Component.onCompleted: show();
    ListHeader{
        id: listheading2
        z: 1
        headerText:"Please Enter Your Password"
}
    TextField{
        height: 60
        id: enterpassstart
        anchors.top: listheading2.bottom
        inputMethodHints: Qt.ImhNoAutoUppercase
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.left: parent.left
        errorHighlight: enterpassstart.text? false: true
        echoMode: TextInput.Password
        placeholderText: "Enter Password Here"
    }
    ButtonRow{
        id:row2
        anchors.top: enterpassstart.bottom
        anchors.topMargin: 2
        anchors.right: parent.right
        anchors.left: parent.left
        ToolButton{
            text: "Continue"
            onClicked: {
                if (enterpassstart.text === appsettings.getSystemSetting("ap", "")){
            banner.showText ("Password Accepted")
                close();

            }
             else{
                if (enterpassstart.text=== ""){ banner.showText ("No Value Entered")}

                else{
                    banner.showText ("Password Incorrect")
                }
            }
        }
    }
    }
    Text{
        id: war
        anchors.top:row2.bottom
        anchors.topMargin: 2
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

    Image{anchors.centerIn: parent; source:"../img/lock_flat.svg"; sourceSize.height: 100; sourceSize.width: 100; height: sourceSize.height; anchors.verticalCenterOffset: 50; width:sourceSize.width

    }
}
