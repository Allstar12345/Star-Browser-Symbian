/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "dbcore.js" as DBcore

Rectangle{
    anchors.fill: parent
    z: Infinity
    color: "#00aaff"
    visible: true
    id: root
    Component.onCompleted: {next1.opacity=1; starttext.opacity=1; starttext2.opacity=1; starticon.opacity=1}

    Timer{
        id: timer
        interval: 100
        onTriggered: {
            step4info1.text="Restarting.."

            appsettings.saveSystemSetting("firstrunnn", "true")
            DBcore.openDB();
            var itemnew = DBcore.defaultItem();
            itemnew.title = "Delight Custom Firmwares";
            itemnew.url = "http://n8delight.blogspot.co.uk/?m=1";
                       itemnew.creationdate = Qt.formatDateTime(new Date(), "dd/MM/yy");;
                       DBcore.createBookmark(itemnew);
            QMLUtils.restart();
        }
    }

    Image{height: 120;width:120;sourceSize.height:120; sourceSize.width: 120; opacity: 0;id: starticon;Behavior on opacity{NumberAnimation{duration: 700}}anchors.horizontalCenter: parent.horizontalCenter;anchors.top:parent.top;anchors.topMargin:20; source: "img/icon.svg"}

    Text{anchors{centerIn: parent
            verticalCenterOffset: -44}
        Behavior on opacity{NumberAnimation{duration: 800}}
        opacity:0
      id: starttext
        color: "white"
        font.pointSize: 16
        text: "Star Browser"
        font.bold: false
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
   }
    Text{anchors{centerIn: parent
            verticalCenterOffset: 25}
        Behavior on opacity{NumberAnimation{duration: 800}}
        opacity:0
      id: starttext2
        color: "white"
        font.pointSize: 16
        text: "v1.75"
        font.bold: false
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
   }

    ButtonSenseFloat{Behavior on opacity{NumberAnimation{duration: 800}}opacity:0; id: next1; buttonText:"Next"; anchors{horizontalCenter: parent.horizontalCenter;bottom:parent.bottom;bottomMargin:2}onClicked:{step1.opacity=1;next1.opacity=0;starttext.opacity=0; starttext2.opacity=0; starticon.opacity=0; step1usage.opacity=1;step1qaimg.opacity=1; step1qabinfo.opacity=1; next2.opacity=1}}

    Rectangle{id: step1
        anchors.fill: parent
        z: 3
        color: "#00aaff"
        visible: true
        opacity:0
        Behavior on opacity{NumberAnimation{}}
        Text{
            id: step1usage
            anchors{
                centerIn: parent
                verticalCenterOffset: -200
            }
            color: "white"
            font.pointSize: 13
            text: "The Basics"
            horizontalAlignment: Text.AlignHCenter
        }
        Image{Behavior on opacity{NumberAnimation{}} opacity: 0;id: step1qaimg; source:"img/Setup/button.png";anchors{centerIn: parent;verticalCenterOffset: -140} }
        Text{
            id: step1qabinfo
            Behavior on opacity{NumberAnimation{}}
            anchors{
                centerIn: parent
                verticalCenterOffset: -93
            }
            opacity: 0
            color: "white"
            font.pointSize: 6
            text: "Press this once to access the Menu"
            horizontalAlignment: Text.AlignHCenter
        }

        ButtonSenseFloat{id: next2; buttonText:"Next"; anchors{horizontalCenter: parent.horizontalCenter;bottom:parent.bottom;bottomMargin:2} onClicked:{step1.opacity=0;step2.opacity=1;}}


    }
    Rectangle{id: step2
        anchors.fill: parent
        z: 3
        color: "#00aaff"
        visible: true
        opacity:0
        Behavior on opacity{NumberAnimation{}}
        Text{
            id: step2usage
            anchors{
                centerIn: parent
                verticalCenterOffset: -200
            }
            color: "white"
            font.pointSize: 9
            text: "What the symbols stand for"
            horizontalAlignment: Text.AlignHCenter
        }
        Flickable{
           Decorator{flickableItem:step2usageflick }
            clip: true; id: step2usageflick; flickableDirection: Flickable.VerticalFlick; boundsBehavior: Flickable.DragOverBounds; anchors{right:parent.right;left:parent.left;top:step2usage.bottom;topMargin:7;bottom: next3.top; bottomMargin: 7}
            contentHeight: 950
            FlickItemSetup{id: step2item1; itemText:"Lock Page Movement"; iconSource: "img/lock_flat.svg"; anchors{top:parent.top}}
            FlickItemSetup{id: step2item2; itemText:"Night Cover- Night Reading"; iconSource: "img/night_flat.svg"; anchors{top:step2item1.bottom}}
            FlickItemSetup{id: step2item3; itemText:"Extra Options"; iconSource: "img/toolbar_extension_flat.svg"; anchors{top:step2item2.bottom}}
            FlickItemSetup{id: step2item4; itemText:"Settings"; iconSource: "img/settings_flat.svg"; anchors{top:step2item3.bottom}}
            FlickItemSetup{id: step2item5; itemText:"Share Area"; iconSource: "img/share_flat.svg"; anchors{top:step2item4.bottom}}
            FlickItemSetup{id: step2item6; itemText:"Bookmarks"; iconSource: "img/favourite_flat.svg"; anchors{top:step2item5.bottom}}
            FlickItemSetup{id: step2item7; itemText:"Browsing History"; iconSource: "img/history_flat.svg"; anchors{top:step2item6.bottom}}
            FlickItemSetup{id: step2item8; itemText:"Close Application"; iconSource: "img/close_stop_flat.svg"; anchors{top:step2item7.bottom}}
            FlickItemSetup{id: step2item9; itemText:"Homepage"; iconSource: "img/home_flat.svg"; anchors{top:step2item8.bottom}}
            FlickItemSetup{id: step2item10; itemText:"Search The Web"; iconSource: "img/search_flat.svg"; anchors{top:step2item9.bottom}}
            FlickItemSetup{id: step2item11; itemText:"Window Manager"; iconSource: "img/switch_windows_flat.svg"; anchors{top:step2item10.bottom}}
            FlickItemSetup{id: step2item12; itemText:"Open Local File"; iconSource: "img/memory_flat.svg"; anchors{top:step2item11.bottom}}
            FlickItemSetup{id: step2item13; itemText:"Fullscreen"; iconSource: "img/full_screen_flat.svg"; anchors{top:step2item12.bottom}}
            FlickItemSetup{id: step2item14; itemText:"Copy Page Source Code"; iconSource: "img/Code.svg"; anchors{top:step2item13.bottom}}
            FlickItemSetup{id: step2item15; itemText:"Take A Screenshot"; iconSource: "img/camera_flat.svg"; anchors{top:step2item14.bottom}}
            FlickItemSetup{id: step2item16; itemText:"Toggle Auto Page Reload"; anchors{top:step2item15.bottom}MenuButton{height: 38;width: 38;anchors.left:parent.left;anchors.leftMargin: 5;buttonText:"ATR"}}
            FlickItemSetup{id: step2item17; itemText:"Indicates Longpress Option" ;anchors{top:step2item16.bottom} MenuButton{height: 38;width: 38;anchors.left:parent.left;anchors.leftMargin: 3;buttonText:"ATR"; holdExtra: "true"}}
            FlickItemSetup{id: step2item18; itemText:"Indicates Enabled Option" ;anchors{top:step2item17.bottom} MenuButton{height: 38;width: 38;anchors.left:parent.left;anchors.leftMargin: 3;buttonText:"ATR";buttonPressed: true}}
             FlickItemSetup{id: step2item19; itemText:"Web Audio Player" ; iconSource: "img/music.svg"; anchors{top:step2item18.bottom} MenuButton{height: 38;width: 38;anchors.left:parent.left;anchors.leftMargin: 3;}}
        }
        ButtonSenseFloat{id: next3; buttonText:"Next"; anchors{horizontalCenter: parent.horizontalCenter;bottom:parent.bottom;bottomMargin:2} onClicked:{step2.opacity=0;step3.opacity=1; timer.start();}}
}
        Rectangle{id: step3
            anchors.fill: parent
            z: 3
            color: "#00aaff"
            visible: true
            opacity:0
            Behavior on opacity{NumberAnimation{}}

            Text{
                id: step4info1
                anchors{
                    horizontalCenter: parent.horizontalCenter
                    verticalCenterOffset: -200

                }
                color: "white"
                font.pointSize: 7
                text: "Setting a few things up"
                horizontalAlignment: Text.AlignHCenter
            }
             BusyIndicator{running: true; id: spinner;anchors.centerIn:parent; height: 80; width: 80}


}
}
