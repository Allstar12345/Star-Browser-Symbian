/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../"
Rectangle{
    Behavior on opacity {NumberAnimation{}}
    opacity: 0
    Component.onCompleted: {root.opacity=1;}
    anchors.fill: parent
    z: 10
    color: "#00aaff"
    visible: true
    id: root
    MouseArea{anchors.fill: parent; enabled: true}

    Image {
        id: errorimage
        sourceSize.height: 200
        sourceSize.width: 200
        width: sourceSize.width
        height: sourceSize.height
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenterOffset: -110
        anchors.verticalCenter: parent.verticalCenter
        source: "../img/error.svg"
    }

    Text{id: basetext
    color: "#ffffff"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        text:"This website has been marked as suspicious, we do not recommend continuing"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 11
        width: root.width/1.2
        elide: Text.ElideRight
        wrapMode: Text.Wrap
        maximumLineCount: 5
        styleColor: "#ffffff"
        anchors.verticalCenterOffset: 85
    }
    ButtonSenseFloat{anchors{horizontalCenter: parent.horizontalCenter; bottom:root.bottom; horizontalCenterOffset: -width/1.5}buttonText: "Go Back";onClicked:{webView.back.trigger();root.opacity=0; root.destroy();}}
    ButtonSenseFloat{anchors{horizontalCenter: parent.horizontalCenter; bottom:root.bottom; horizontalCenterOffset: width/1.5}buttonText: "Proceed";onClicked:{root.opacity=0; root.destroy();}}

}
