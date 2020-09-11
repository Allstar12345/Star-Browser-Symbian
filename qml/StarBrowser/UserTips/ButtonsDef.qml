/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import "../"

AppPage{
    id: buttonsdef
    colour:"#00aaff"
    Component.onCompleted: show();
ListHeader{
    anchors{top:parent.top}
    id: header
    headerText: "What The Symbols Stand For"
}
    Flickable{
       Decorator{flickableItem:flick }
        clip: true; id: flick; flickableDirection: Flickable.VerticalFlick; boundsBehavior: Flickable.DragOverBounds; anchors{right:parent.right;left:parent.left;top:header.bottom;topMargin:1;bottom:dismiss.top; bottomMargin: 2}
        contentHeight: 950
        FlickItemSetup{id: step2item1; itemText:"Lock Page Movement"; iconSource: "../img/lock_flat.svg"; anchors{top:parent.top}}
        FlickItemSetup{id: step2item2; itemText:"Night Cover- Night Reading"; iconSource: "../img/night_flat.svg"; anchors{top:step2item1.bottom}}
        FlickItemSetup{id: step2item3; itemText:"Extra Options"; iconSource: "../img/toolbar_extension_flat.svg"; anchors{top:step2item2.bottom}}
        FlickItemSetup{id: step2item4; itemText:"Settings"; iconSource: "../img/settings_flat.svg"; anchors{top:step2item3.bottom}}
        FlickItemSetup{id: step2item5; itemText:"Share Area"; iconSource: "../img/share_flat.svg"; anchors{top:step2item4.bottom}}
        FlickItemSetup{id: step2item6; itemText:"Bookmarks"; iconSource: "../img/favourite_flat.svg"; anchors{top:step2item5.bottom}}
        FlickItemSetup{id: step2item7; itemText:"Browsing History"; iconSource: "../img/history_flat.svg"; anchors{top:step2item6.bottom}}
        FlickItemSetup{id: step2item8; itemText:"Close Application"; iconSource: "../img/close_stop_flat.svg"; anchors{top:step2item7.bottom}}
        FlickItemSetup{id: step2item9; itemText:"Homepage"; iconSource: "../img/home_flat.svg"; anchors{top:step2item8.bottom}}
        FlickItemSetup{id: step2item10; itemText:"Search The Web"; iconSource: "../img/search_flat.svg"; anchors{top:step2item9.bottom}}
        FlickItemSetup{id: step2item11; itemText:"Window Manager"; iconSource: "../img/switch_windows_flat.svg"; anchors{top:step2item10.bottom}}
        FlickItemSetup{id: step2item12; itemText:"Open Local File"; iconSource: "../img/memory_flat.svg"; anchors{top:step2item11.bottom}}
        FlickItemSetup{id: step2item13; itemText:"Fullscreen"; iconSource: "../img/full_screen_flat.svg"; anchors{top:step2item12.bottom}}
        FlickItemSetup{id: step2item14; itemText:"Copy Page Source Code"; iconSource: "../img/Code.svg"; anchors{top:step2item13.bottom}}
        FlickItemSetup{id: step2item15; itemText:"Take A Screenshot"; iconSource: "../img/camera_flat.svg"; anchors{top:step2item14.bottom}}
        FlickItemSetup{id: step2item16; itemText:"Toggle Auto Page Reload"; anchors{top:step2item15.bottom}MenuButton{height: 38;width: 38;anchors.left:parent.left;anchors.leftMargin: 5;buttonText:"ATR"}}
        FlickItemSetup{id: step2item17; itemText:"Indicates Longpress Option" ;anchors{top:step2item16.bottom} MenuButton{height: 38;width: 38;anchors.left:parent.left;anchors.leftMargin: 3;buttonText:"ATR"; holdExtra: "true"}}
        FlickItemSetup{id: step2item18; itemText:"Indicates Enabled Option" ;anchors{top:step2item17.bottom} MenuButton{height: 38;width: 38;anchors.left:parent.left;anchors.leftMargin: 3;buttonText:"ATR";buttonPressed: true}}
        FlickItemSetup{id: step2item19; itemText:"Web Audio Player" ; iconSource: "../img/music.svg"; anchors{top:step2item18.bottom} MenuButton{height: 38;width: 38;anchors.left:parent.left;anchors.leftMargin: 3;}}
    }
    ButtonSenseFloat{
       id: dismiss
       buttonText:"Dismiss"
       z:10
       anchors.bottom: parent.bottom
       anchors.bottomMargin: 2
       anchors.horizontalCenter:parent.horizontalCenter
       onClicked: {close();}
    }

}
