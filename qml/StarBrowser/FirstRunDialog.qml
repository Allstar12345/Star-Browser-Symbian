/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "dbcore.js" as DBcore

Rectangle{
    property string colour:  "#00aaff"

    anchors.fill: parent
    z: 10
    color: "#00aaff"
    visible: true
    id: root

    Rectangle{
        z: Infinity
        anchors.fill: parent
        MouseArea{anchors.fill:parent}
        id: landscape
    color: colour
    Text{anchors.centerIn: parent; text:"Please Turn To Portait"; color:"white"}}
    Component.onCompleted: {
        startdelay.start();
    }
    onWidthChanged: {if(screen.width===640){landscape.visible=true} else{landscape.visible=false}
        if(screen.width===360){landscape.visible=false}
    }
    Timer{
        id: timer
        interval: 200
        onTriggered: {
            step3info1.text="Restarting.."
            appsettings.saveSystemSetting("firstrunnn", "true");
            DBcore.openDB();
            var itemnew = DBcore.defaultItem();
            itemnew.title = "Delight Custom Firmwares";
            itemnew.url = "http://n8delight.blogspot.co.uk/?m=1";
                       itemnew.creationdate = Qt.formatDateTime(new Date(), "dd/MM/yy");;
                       DBcore.createBookmark(itemnew);
            QMLUtils.restart();
        }
    }

    Text{
        opacity: 0;id: starttext;Behavior on opacity{NumberAnimation{duration: 800}}
        anchors{
            centerIn: parent
        }
        color: "white"
        font.pointSize: 12
        text: "Welcome to\nStar Browser"
        horizontalAlignment: Text.AlignHCenter
    }
    Timer{id: startdelay;interval:200;onTriggered:{starticon.opacity=1
            starttext.opacity=1
            starttextversion.opacity=1
            next1.opacity=1}}
    Text{
        opacity: 0;id: starttextversion;Behavior on opacity{NumberAnimation{duration: 900}}
        anchors{
            centerIn: parent
            verticalCenterOffset: 60
        }
        color: "white"
        font.pointSize: 12
        text: "v1.75"
        horizontalAlignment: Text.AlignHCenter
    }
    Image{height: 140;width:140;sourceSize.height:140; sourceSize.width: 140  ; opacity: 0;id: starticon;Behavior on opacity{NumberAnimation{duration: 700}}anchors.horizontalCenter: parent.horizontalCenter;anchors.top:parent.top;anchors.topMargin:100; source: "img/icon.svg"}

    ButtonSenseFloat{Behavior on opacity{NumberAnimation{duration: 800}}opacity:0; id: next1; buttonText:"Next"; anchors{horizontalCenter: parent.horizontalCenter;bottom:parent.bottom; bottomMargin:2}onClicked:{step1.opacity=1;next1.opacity=0;starttext.opacity=0;starticon.opacity=0; starttextversion.opacity=0}}


    Rectangle{id: step1
        anchors.fill: parent
        z: 3
        color: "#00aaff"
        visible: true
        opacity:0
        Behavior on opacity{NumberAnimation{}}
        Text{
            id: step1usage
            anchors{centerIn: parent;verticalCenterOffset: -295
            }
            color: "white"
            font.pointSize: 10
            text: "The Basics"

            horizontalAlignment: Text.AlignHCenter
        }
        Text{
            id: step1qab
            anchors{
                centerIn: parent
                verticalCenterOffset: -240
            }
            color: "white"
            font.pointSize: 10
            font.bold: true
            text: "Quick Access Button"
            horizontalAlignment: Text.AlignHCenter
        }
        Image{id: step1qaimg; source:"img/Setup/button.png";anchors{centerIn: parent;verticalCenterOffset: -205} }
        Text{
            id: step1qabinfo
            anchors{
                centerIn: parent
                verticalCenterOffset: -165
            }
            color: "white"
            font.pointSize: 7
            wrapMode: Text.Wrap
            width: parent.width-35
            elide: Text.ElideRight
            maximumLineCount: 2
            text: "Press this once to access the Menu"
            horizontalAlignment: Text.AlignHCenter
        }
        Text{
            id: step1qam
            font.bold: true
            anchors{
                centerIn: parent
                verticalCenterOffset: -125
            }
            color: "white"
            font.pointSize: 10
            text: "Quick Access Menu"
            horizontalAlignment: Text.AlignHCenter
        }
        Image{id: step1qamimg; source:"img/Setup/QAMenu.png";anchors{centerIn: parent;verticalCenterOffset: 20} }
        Text{
            id: step1qaminfo
            anchors{
                centerIn: parent
                verticalCenterOffset: 180
            }
            color: "white"
            font.pointSize: 7
            wrapMode: Text.Wrap
            width: parent.width-35
            elide: Text.ElideRight
            maximumLineCount: 2
            text: " This is the Menu, slide to the right to reveal more options"
            horizontalAlignment: Text.AlignHCenter
        }
        ButtonSenseFloat{id: next2; buttonText:"Next"; anchors{horizontalCenter: parent.horizontalCenter; bottom:parent.bottom; bottomMargin:2} onClicked:{step1.opacity=0;step2.opacity=1;}}

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
                verticalCenterOffset: -300
            }
            color: "white"
            font.pointSize: 9
            text: "What the symbols stand for"
            horizontalAlignment: Text.AlignHCenter
        }
        Flickable{
           Decorator{flickableItem:step2usageflick }
            clip: true; id: step2usageflick; flickableDirection: Flickable.VerticalFlick; boundsBehavior: Flickable.DragOverBounds; anchors{right:parent.right;left:parent.left;top:step2usage.bottom;topMargin:10;bottom: next3.top; bottomMargin: 10}
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
        ButtonSenseFloat{id: next3; buttonText:"Next"; anchors{horizontalCenter: parent.horizontalCenter; bottom:parent.bottom; bottomMargin:2} onClicked:{step2.opacity=0;step3.opacity=1;timer.start();}}

    }
    Timer{id: setupdelay; interval: 1000; onTriggered:{timer.start();}}
    Rectangle{id: step3
        anchors.fill: parent
        z: 3
        color: "#00aaff"
        visible: true
        opacity:0
        Behavior on opacity{NumberAnimation{}}
        Text{
            id: step3title
            anchors{
                centerIn: parent
                verticalCenterOffset: -300
            }
            color: "white"
            font.pointSize: 10
            text: "Nearly Done"
            horizontalAlignment: Text.AlignHCenter
        }
        BusyIndicator{running: true; id: spinner;anchors.centerIn:parent; height: 80; width: 80}
        Text{
            id: step3info1
            anchors{
                horizontalCenter: parent.horizontalCenter
                top: step3title.bottom
                topMargin: 20
            }
            color: "white"
            font.pointSize: 7
            text: "Setting a few things up"
            horizontalAlignment: Text.AlignHCenter
        }

    }
}

