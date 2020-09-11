/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "SearchSuggestions"
import "GoogleSuggest.js" as SuggestFunctions

Rectangle{
    anchors.fill: parent
    z: 2
    QtObject { id: create; property Component com: null;function createComponent (qmlfile){com = Qt.createComponent(qmlfile);com.createObject(root)} }

    property string colour:popupbutton.colour
    id: root
    opacity: 0
    clip: true

    Behavior on opacity {NumberAnimation{} }
    color: "black"
    property GoogleSearchSuggestion gsComponent
    function googleSuggest_item_choosen(text)
    {
        if(privateBrowsing===true){console.debug("Private Browsing enabled")}
        else{ appsettings.saveSystemSetting("lastsearch", text)}

        web_view1.url= appsettings.getSystemSetting("searchengine", "")== ""?  "http://www.google.com/m?q=" + searchinput.text : appsettings.getSystemSetting("searchengine", "") + text
        close();
    }

    Timer {
        id: timerPopupGS
        running: false
        interval: 300
        repeat: false
        triggeredOnStart: false
        onTriggered: {
            if (searchinput.focus && searchinput.text !== "" && searchinput.text.length > 2) {
                // Pop up GoogleSuggest and catch itemChoosen signal
                root.gsComponent = SuggestFunctions.popupGoogleSuggest(searchinput, searchinput.text, "");
               root.gsComponent.itemChoosen.connect(root.googleSuggest_item_choosen);
            }
            if (searchinput.text.length<3) SuggestFunctions.deleteGoogleSuggest();
        }
    }

    function openenginechooser(){ create.createComponent(Qt.resolvedUrl("SettingsDialogs/SearchEngineChooser.qml"));}
    function openglobalgoogle(){ create.createComponent(Qt.resolvedUrl("SettingsDialogs/GlobalGoogleSearch.qml"));}
    function saveSearchHistory(){create.createComponent(Qt.resolvedUrl("SearchHistorySaver.qml")); }


    MouseArea{
        anchors.fill: parent
        onClicked: close()
    }

    Component.onCompleted: {
        open();
        console.log ("Opening Search")
    }
    function open(){
        root.opacity=0.800;
        appearboxstart.start();
        bobappear.start();
}

    function close(){
        root.opacity=0
        disappearbox.start();
        searchbox.opacity=0;
        timer.start();

    }

    SmoothedAnimation {id: bobappear; target: bob; property:"anchors.bottomMargin"; to:0; duration: 800}
    Rectangle{height: 80; id: bob; color: colour ;anchors{right: parent.right; left: parent.left; bottom: parent.bottom; bottomMargin: -90}

        MenuButton{id: history; imgSource: "img/history_flat.svg";anchors{verticalCenter: parent.verticalCenter; horizontalCenter: parent.horizontalCenter; horizontalCenterOffset: screen.width===640?-270:-120}onClicked:{ opensearchHistory();close(); }}
        MenuButton{id: engine;imgSource: "img/settings_flat.svg"; anchors{verticalCenter: parent.verticalCenter; horizontalCenter: parent.horizontalCenter; horizontalCenterOffset: screen.width===640?270:120} onClicked:{openenginechooser();}}
        MenuButton{id: hide;imgSource: "img/close_stop_flat.svg"; anchors{verticalCenter: parent.verticalCenter;horizontalCenter: parent.horizontalCenter} onClicked:{close();}}
    }

    Rectangle{id: searchbox; MouseArea{anchors.fill: parent;enabled: true}z:5;color: colour;
        SmoothedAnimation{id: disappearbox; to:-80; property:"anchors.topMargin"; duration:800; target:searchbox}
        SmoothedAnimation{id: appearboxstart;target: searchbox;property: "anchors.topMargin"; to: 0; duration: 600}
    height: 60;anchors{right: parent.right;left: parent.left;top: parent.top; topMargin: -150}
    opacity: 0.9
    Behavior on opacity {NumberAnimation{}}

    Timer{
        id: timer
        interval: 700
        onTriggered:{ searchbox.destroy();
        }
    }


    TextField{
        id: searchinput
        height: 60
        anchors.left: parent.left
        anchors.right: searchbutton.left
        anchors.rightMargin: 3
        placeholderText: "Enter your search here"
        text: appsettings.getSystemSetting("lastsearch", "")
        onTextChanged: {
         timerPopupGS.restart();
          if (text.length<3) SuggestFunctions.deleteGoogleSuggest();

             if (text) {
                 clearButton.state =! "ClearVisible"
             } else {
                 clearButton.state =! "ClearHidden"
             }
         }
        platformRightMargin: clearButton.width + platformStyle.paddingSmall +2

        Keys.onPressed: {
                 if (event.key == Qt.Key_Enter || event.key == 16777220) {
                    searchinput.closeSoftwareInputPanel();
                     web_view1.url= appsettings.getSystemSetting("searchengine", "")== ""?  "http://www.google.com/m?q=" + searchinput.text : Setting.get ("searchengine") + searchinput.text
                     saveSearchHistory();
                     appsettings.saveSystemSetting("lastsearch", searchinput.text)
                     close();

                 }
        }

        Image {
            id: clearButton; objectName: "clearButton"
            height: sourceSize.height
            Behavior on scale {NumberAnimation{}}
            width: sourceSize.width
            sourceSize.height: 42
            sourceSize.width: 42
            anchors.right: parent.right
            anchors.rightMargin: platformStyle.paddingSmall
            anchors.verticalCenter: searchinput.verticalCenter
            state: "ClearHidden"
            source: "img/stoptopbar.svg"
            MouseArea {
                id: clearMouseArea
                anchors.fill: parent
                onClicked: {
                   searchinput.text = ""
                    clearButton.state = "ClearHidden"
                }
            }
            states: [
                State {
                    name: "ClearVisible"
                    PropertyChanges {target: clearButton; scale: 1}
                },
                State {
                    name: "ClearHidden"
                    PropertyChanges {target: clearButton; scale: 0}
                }
            ]
        }
    }
    ToolButtonSense{
        id: searchbutton
        z: 2
        height: 54
        anchors.bottom: parent.bottom
        imgsource: "img/search_flat.svg"
        anchors.right: parent.right
        onClicked:{

            web_view1.url= appsettings.getSystemSetting("searchengine", "")== ""?  "http://www.google.com/m?q=" + searchinput.text : appsettings.getSystemSetting("searchengine", "") + searchinput.text
                console.debug(web_view1.url)
            if(privateBrowsing===true){console.debug("Private Browsing enabled")}
            else{appsettings.saveSystemSetting("lastsearch", searchinput.text)}

                saveSearchHistory();
                close()
            }

    }
}


}
