/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../"
Rectangle{
    anchors.fill: parent
    z: 2
    id: root
    opacity: 0
    clip: true
    color: "black"
    property bool snapOnClose: false
    property string fileurl: ""
    property string colour: popupbut.color
    Behavior on opacity{NumberAnimation{}}
    Component.onDestruction: { console.log ("Popup Menu Window System Destroyed !") }

    Connections{
        target:page
        onLoadFinishedMenuWindow:{snapOnClose=true;}
    }

    MouseArea{
        anchors.fill: parent
        onClicked:{close();}
    }
    Component.onCompleted: {open();}
    function open(){
        wmenuOpen=true;
        root.opacity=0.850;
        startdelay.start();
        startdelayurl.start();
}
    function close(){
        wmenuOpen=false;
        root.opacity= 0;
        destroydelay.start();
        console.log ("Closed");
        popupbuttonshowdelay.start();
        if(snapOnClose===true){pageSnapper.snapPage(0);}

    }
    function closeShot(){
        wmenuOpen=false;

        root.opacity= 0
        destroydelay.start()
        console.log ("Closed For ScreenShot")
    }
    function closetoolbar(){
        root.opacity= 0
        wmenuOpen=false;

        destroydelay.start()
        popupButtonEnabled=true;
        console.log ("Closed")
        popupbutton.hide()
        }
    function fileChooser (){
        var file= QMLUtils.openFileSelectionDlg()
        if(file==""){
            banner.showText("No file chosen")
        }
        else webView.url=file;}
    function decideWindow(){
        if(pageId==="1")urlStringw1=webView.fixUrl(dropurlinput.text);
        else if (pageId==="2") urlStringw2=webView.fixUrl(dropurlinput.text);
              else if (pageId==="3") urlStringw3=webView.fixUrl(dropurlinput.text);
              else if (pageId==="4") urlStringw4=webView.fixUrl(dropurlinput.text);
              else if (pageId==="5") urlStringw5=webView.fixUrl(dropurlinput.text);
              else if (pageId==="6") urlStringw6=webView.fixUrl(dropurlinput.text);
    }

    Timer{
        id: destroydelay
        running: false; interval: 350
        onTriggered: {
            root.destroy()
        }
    }
    Rectangle{ Behavior on height{NumberAnimation{easing.type: Easing.InOutQuart}}id: urlinputqam; MouseArea{anchors.fill: parent;enabled: true}z:5;color: colour; Timer{id:startdelayurl;interval: 200;onTriggered:{appearboxurl.start();}}
        SmoothedAnimation{id: appearboxurl;target: urlinputqam;property: "anchors.topMargin"; to: 0; duration: 700}
    height: 60;anchors{right: parent.right;left: parent.left;top: parent.top; topMargin: -100}
    TextField{id: dropurlinput;placeholderText:  "Enter URL Here";text:(webView.url);anchors.fill: parent;inputMethodHints: Qt.ImhUrlCharactersOnly;onTextChanged: {
            if (text) {
                clearButton.state =! "ClearVisible"
            } else {
                clearButton.state =! "ClearHidden"
            }
        }

        Keys.onPressed: {
                 if (event.key == Qt.Key_Enter || event.key == 16777220) {
                    dropurlinput.closeSoftwareInputPanel();
                     if(dropurlinput.text==="http://"){banner.showText("Invaild URL")
                         event.accepted=true;
                    }
                     else if (dropurlinput.text==="https://"){banner.showText("Invaild URL"); event.accepted=true;}
                     else{decideWindow();
                         dropurlinput.focus=false
                         close();
                     event.accepted=true;}
                 }
                 else if (event.key == Qt.Key_Return){dropurlinput.focus=false;decideWindow(); close();}
             }
        platformRightMargin: clearButton.width + platformStyle.paddingSmall +2

        Rectangle{ Behavior on width{NumberAnimation{easing.type: Easing.InOutQuart}}Behavior on opacity{NumberAnimation{}}opacity:webView.progress == 1.0 ? 0.0 : 0.6; width: (dropurlinput.width - 20) * webView.progress; id: progressbartop; height: parent.height-4; radius: 16; anchors.left:parent.left ; anchors.verticalCenter: parent.verticalCenter; color:progressColour; }
    }
    Image {
        id: clearButton; objectName: "clearButton"
        height: sourceSize.height
        width: sourceSize.width
        sourceSize.height: 42
        sourceSize.width: 42
        Behavior on scale {NumberAnimation{}}
        anchors.right: parent.right
        anchors.rightMargin: platformStyle.paddingSmall
        anchors.verticalCenter: urlinputqam.verticalCenter
        state: "ClearHidden"
        source: "../img/stoptopbar.svg"
        MouseArea {
            id: clearMouseArea
            anchors.fill: parent
            onClicked: {
               dropurlinput.text = ""
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
    }}
    Rectangle{id: extensionBar;Behavior on opacity{NumberAnimation{}}Behavior on anchors.bottomMargin{NumberAnimation{}}opacity:0;color: box.color;width: parent.width; height: 50; property bool opened:anchors.bottomMargin>=0; anchors{bottom: box.top;bottomMargin:-extensionBar.height;}
        function show(){anchors.bottomMargin=0;opacity=1}
        function hide(){anchors.bottomMargin= -extensionBar.height;opacity=0;}
        MenuButton{z:1;height: parent.height/1.2; width: parent.height/1.2;id: tools;anchors{verticalCenter:parent.verticalCenter;left:parent.left; leftMargin: width;} imgSource: "../img/toolbox.svg"; onClicked:{showToolMenu();close();}}
        MenuButton{z:1;height: parent.height/1.2; width: parent.height/1.2;id: consolebutton;anchors{verticalCenter:parent.verticalCenter;right:parent.right; rightMargin: width;} imgSource: "../img/console.svg"; onClicked:{openConsole();close();}}
        MenuButton{z:1;height: parent.height/1.2; width: parent.height/1.2;id: js;anchors{horizontalCenter: parent.horizontalCenter;verticalCenter:parent.verticalCenter} imgSource: "../img/javascript.svg"; onClicked:{openJSEval(); close();}}

    }
Rectangle {
    id: box
    z: 5
    clip: false
    visible: true
    SmoothedAnimation{id: appearbox; target: box; property: "anchors.bottomMargin"; to: 0;duration: 700}
    color: colour
    height: 150
    Timer{id: startdelay; interval: 200; onTriggered:{appearbox.start()}}
  anchors{
      right: parent.right
      left: parent.left
      bottom: parent.bottom
      bottomMargin: -150
  }
 MouseArea{anchors.fill: parent; enabled:true

 }
  Flickable{ flickDeceleration: 2000;flickableDirection: Flickable.HorizontalFlick; boundsBehavior: Flickable.DragOverBounds;anchors.fill: parent; id: menuflick; contentWidth: 640
      MenuButton{id:contentlock;anchors{left: parent.left; leftMargin: 3; top: parent.top;topMargin:3} imgSource:  flickable.interactive == false ? "../img/unlock_flat.svg":"../img/lock_flat.svg"; onClicked: {  if(flickable.interactive == true) {
                  banner.showText ("Movemement Locked")
                flickable.interactive = false
                  close();
              } else {
                  banner.showText("Movement Unlocked")
                flickable.interactive = true
                  close();
          }}}
      MenuButton{id:closemenu;anchors{left: parent.left; leftMargin:screen.height===640? 80:60; top: parent.top;topMargin:3} imgSource: "../img/toolbar_extension_flat.svg" ; onClicked: {if(extensionBar.opened)extensionBar.hide(); else extensionBar.show()} onHold: { privateStyle.play(Symbian.PopUp);platformPopupManager.privateShowIndicatorPopup()}}

      MenuButton{id:pageback;anchors{left: parent.left; leftMargin: 22; top: parent.top;topMargin:80} imgSource: "../img/back_flat.svg" ; onClicked: {webView.back.trigger();}}

        MenuButton{id:reload;height: 85;width: 85;anchors{left: parent.left;leftMargin:screen.width===640? 282:135; top: parent.top;topMargin:70} imgSource:webView.progress < 1.0 ? "../img/stop_flat.svg" : "../img/refresh_holdcontrol.svg" ; onClicked: {webView.progress < 1.0 ? webView.stop.trigger() : webView.reload.trigger()}}
        MenuButton{id:nightcoverbutton; holdExtra: "true";  buttonPressed: nightcover.visible? true: false; anchors{left: parent.left; leftMargin: screen.width===640?210:190; top: parent.top;topMargin:3} imgSource: "../img/night_flat.svg"; onHold: {ncovertoggle();close();}onClicked: { if (nightcover.visible == true){
             nightcover.visible=false}
             else{
                 nightcover.visible= true
             }}}
        MenuButton{id:pageforward;anchors{left: parent.left; leftMargin:screen.width===640? 550:273; top: parent.top;topMargin:80} imgSource: "../img/next_flat.svg" ; onClicked: {webView.forward.trigger()}}

        MenuButton{id:share;anchors{left: parent.left; leftMargin:screen.width===640? 108:363; top: parent.top;topMargin:80} imgSource: "../img/share_flat.svg" ; onClicked: {  if (appsettings.getSystemSetting("pm", "")=== "enabled"){
                     banner.showText ("Access Denied, Restricted Mode Activated")
                     close()
                 }
                 else{
                     close()
                     create.createComponent("ShareAreaWindows.qml")
                 }}}
          MenuButton{id:closebutton;holdExtra: "true";anchors{left: parent.left; leftMargin:screen.width===640? 372:363; top: parent.top;topMargin:3} imgSource: "../img/close_stop_flat.svg" ; onClicked: {openclose();close();}}
          MenuButton{id:snapbutton;anchors{left: parent.left; leftMargin: screen.width===640? 120:572; top: parent.top;topMargin:screen.width===640? 3:80} imgSource: "../img/camera_flat.svg" ; onClicked: {closeShot();snapscreenshot();}}
          MenuButton{id:homebutton; holdExtra: "true"; anchors{left: parent.left; leftMargin: 467.5; top: parent.top;topMargin:80} imgSource: "../img/home_flat.svg" ; onHold:{if (appsettings.getSystemSetting("pm", "")=== "enabled"){
                      banner.showText ("Access Denied, Restricted Mode Activated")
                  }
                  else{
                      if (webView.url === ""){ banner.showText ("No Webpage Is Loaded.")}
                      else{
                           appsettings.saveSystemSetting("homepage", webView.url);
                           banner.showText ("Homepage set: "+ webView.title);
                          close();
                      }
                  }} onClicked: {if(appsettings.getSystemSetting("homepage", "")== "") {
                      webView.url= globalHomepage
                      banner.showText ("Homepage not defined, loading default homepage")
                      close();
                  } else {
                      webView.url= appsettings.getSystemSetting("homepage", "")
                      close();
                  }}}

          MenuButton{id:secondwindowbutton; holdExtra:"true"; anchors{left: parent.left; leftMargin: 292; top: parent.top;topMargin:3} imgSource: "../img/switch_windows_flat.svg" ; onClicked: {windowserver.hide();close()} onHold:{ if(appsettings.getSystemSetting("switcherType", "")==="") { create.createComponent("FullScreenSwitcher.qml");} else{ create.createComponent("../QAComponents/WindowSelector.qml");}  close();}}
          MenuButton{id:localfilebutton;anchors{left: parent.left; leftMargin: 467.5; top: parent.top;topMargin:3} imgSource: "../img/memory_flat.svg" ; onClicked: {fixbackground();fileChooser();close();}}
          MenuButton{id:settings;anchors{left: parent.left; leftMargin: 572; top: parent.top;topMargin:3} imgSource: "../img/settings_flat.svg" ; onClicked: { opensettings();close();}}

  }
  }
}
