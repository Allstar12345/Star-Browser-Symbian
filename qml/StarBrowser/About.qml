/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1

AppPage{
    Component.onDestruction: { console.debug ("About Destroyed")}
Behavior on opacity { NumberAnimation {} }
scale: 1
color: "black"
anchors.fill: parent
z: 10
opacity: 0
Component.onCompleted: {show(); toolbar.appear();listappear.start();}
QtObject { id: creat; property Component com: null;function createComponent (qmlfile){com = Qt.createComponent(qmlfile);com.createObject(about)} }
function closePage(){close();}
id: about
Timer{interval: 430; id: listappear; onTriggered:{flickableabout.opacity=1}}
TopToolBar{
    setDuration: "390"
    id: toolbar
    ToolButtonSense {
        id: btnBac
        imgsource: "img/back_flat.svg"
        onClicked: {close();}
  }
    ButtonSense{sourceSize.width:140; anchors.centerIn: parent;buttonText: "Other Apps" ; onClicked: {creat.createComponent("QAComponents/OtherAppsDialog.qml")}}
}
    Flickable {
        id: flickableabout
        opacity: 0
        Behavior on opacity{NumberAnimation{}}
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: toolbar.bottom
        contentHeight: cola.height
        contentWidth: cola.width

        Column {
           spacing: 1
           id: cola
           height: 570

           ListItemer {
                id: fuonfb
                enabled: true
                height: 39
                onClicked:{
                   web_view1.url="http://www.mbasic.facebook.com/Allstarsoftware"
                close();
                    settingsbrowsingpage.opacity=0; closeTimed(500);}

                ListItemText {
                    anchors.centerIn: parent
                    color: "#33b5e5"
                    role: "Title"
                    text: "Find Me On Facebook"
                }
           }
           ListItemer {
                id: fuontwit
                enabled: true
                height: 39
                onClicked:{
                   web_view1.url= "http://www.twitter.com/paulwallace1234"
                     close();
                    settingsbrowsingpage.opacity=0;killTimed(500); }

                ListItemText {
                    color: "#33b5e5"
                    role: "Title"
                    text: "Find Me On Twitter"
                    anchors.centerIn: parent
                }
           }
           ListItemer {
                id: yt
                enabled: true
                height: 39
                onClicked:{
                    QMLUtils.openBrowser("https://www.youtube.com/channel/UCPzRDBnfgvQVRslv48fmehw");close();
                    settingsbrowsingpage.opacity=0;killTimed(500); }

                ListItemText {
                    color: "#33b5e5"
                    role: "Title"
                    text: "Find Me On YouTube"
                    anchors.centerIn: parent
                }
           }
               ListItemer {
                    id: email
                    enabled: true
                    height: 39
                    onClicked:
                       Qt.openUrlExternally('mailto:contact@allstarsoftware.co.uk')
                    ListItemText {
                        color: "#33b5e5"
                        role: "Title"
                        text: "Email Me"
                        anchors.centerIn: parent
                    }
               }
               ListHeader {
                   id: sectionHeadingg
                   headerText: "Special Thanks To:"
               }
               ListItemer {
                    id: apex
                    enabled: true
                    height: 39
                    onClicked:{
                    web_view1.url=('https://www.facebook.com/ApexDesignsInc?fref=ts')
                        close();
                        settingsbrowsingpage.opacity=0;closeTimed(500);}
                    ListItemText {
                        color: "#33b5e5"
                        role: "Title"
                        text: "Apex Designs"
                       anchors.centerIn: parent
                    }
               }
               ListItemer {
                    id: abdoul
                    enabled: true
                    height: 39
                    onClicked: {
                          web_view1.url=('http://m.twitter.com/a_hamameh');close();
                            settingsbrowsingpage.opacity=0;
                    }

                    ListItemText {
                        color: "#33b5e5"
                        role: "Title"
                        text: "BelleXDesigns"
                       anchors.centerIn: parent
                    }
               }
               ListItemer {
                    id: fab
                    enabled: true
                    height: 39
                    onClicked:{
                      web_view1.url=('https://github.com/huellif');close();settingsbrowsingpage.opacity=0;}

                    ListItemText {
                        color: "#33b5e5"
                        role: "Title"
                        text: "Fabian Hüllmantel"
                       anchors.centerIn: parent
                    }
               }
               ListItemer {
                    id: maj
                    enabled: true
                    height: 39
                    onClicked:{
                     web_view1.url=('https://github.com/ksiazkowicz');
                        close();settingsbrowsingpage.opacity=0;}
                    ListItemText {
                        color: "#33b5e5"
                        role: "Title"
                        text: "Maciej Janiszewski"
                       anchors.centerIn: parent
                    }
               }
               ListItemer {
                    id: ma
                    enabled: true
                    height: 39
                    onClicked:{
                   web_view1.url=('https://github.com/mangolazi/');close();settingsbrowsingpage.opacity=0;}
                    ListItemText {
                        color: "#33b5e5"
                        role: "Title"
                        text: "Mangolazi"
                       anchors.centerIn: parent
                    }
               }
               ListItemer {
                    id: mat
                    enabled: true
                    height: 39
                    onClicked:{
                   web_view1.url=('http://forum.symbian-developers.net/profile/?u=19686');close(); settingsbrowsingpage.opacity=0;}
                    ListItemText {
                        color: "#33b5e5"
                        role: "Title"
                        text: "Matthew kühl"
                       anchors.centerIn: parent
                    }
               }
               ListItemer {
                    id: mo
                    enabled: true
                    height: 39
                    onClicked:{
                   web_view1.url=('https://www.facebook.com/motaz.alnuweiri');close(); settingsbrowsingpage.opacity=0}
                    ListItemText {
                        color: "#33b5e5"
                        role: "Title"
                        text: "Motaz Alnuweiri"
                       anchors.centerIn: parent
                    }
               }
               Text {
                   id: txt1
                   width: 312
                   anchors.centerIn: mo
                   height: 21
                   color: "#FFFFFF"
                   text: qsTr("Star Browser v1.75EOL")
                   anchors.verticalCenterOffset: 42
                   anchors.horizontalCenterOffset: 85
                   font.pixelSize: 17
               }
               Image {
                   id: image1
                   width: 115
                   height: 115
                   anchors.verticalCenterOffset: 72
                   anchors.horizontalCenter: parent.horizontalCenter
                   anchors.verticalCenter: txt1.verticalCenter
                   fillMode: Image.PreserveAspectFit
                   sourceSize.height: 115
                   sourceSize.width: 115
                   source: "img/icon.svg"
               }
    }
}

}
