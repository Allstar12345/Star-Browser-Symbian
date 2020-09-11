/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "QAComponents"
Rectangle{
    anchors.fill: parent
    z: 2
    id: root
    opacity: 0
    clip: true
    signal hidehttpsIcon
    property Component httpsind: null
    color: "black"
    property string fileurl: ""
    property string colour: popupbutton.color
    property bool snapOnClose: false
    Behavior on opacity{NumberAnimation{}}
    Component.onDestruction: {console.log ("Popup Menu Destroyed !")}
    MouseArea{anchors.fill: parent; onClicked:{close();}}
    Component.onCompleted: {open();console.log ("Opening Popup Menu") ;if(https===true){httpsind= Qt.createComponent("QAComponents/HTTPSIndicator.qml");httpsind.createObject(root)}}
    Connections{
       target: basepage
       onHTTPSChanged:{
           if(https===true){httpsind= Qt.createComponent("QAComponents/HTTPSIndicator.qml")
               httpsind.createObject(root)}
           else{hidehttpsIcon()}
       }
       onLoadFinishedMenu:{snapOnClose=true;}
    }
    function open(){root.opacity=0.890;startdelay.start();startdelayurl.start()}
    function close(){menuOpen=false;root.opacity= 0;root.destroy(350);console.log ("Closed");popupButtonEnabled=true;popupbuttonshowdelay.start();if(extraNavigationButtons===true)showScreenControls();
        if(snapOnClose===true){pageSnapper.snapPage(0);}
    }
    function closeShot(){
        menuOpen=false
        root.opacity= 0
        if(extraNavigationButtons===true)hideScreenControls();
        popupButtonEnabled=true;
        root.destroy(350)
        console.log ("Closed For ScreenShot")
    }
    function closetoolbar(){menuOpen=false; root.opacity= 0;root.destroy(350);popupButtonEnabled=true;console.log ("Closed"); popupbutton.hide();}
    function fileChooser (){ var file= QMLUtils.openFileSelectionDlg();if(file==""){banner.showText("No file chosen")}else web_view1.url=file;}
    Rectangle{ Behavior on height{NumberAnimation{easing.type: Easing.InOutQuart}}id: urlinputqam; MouseArea{anchors.fill: parent;enabled: true}z:5;color: colour; Timer{id:startdelayurl;interval: 200;onTriggered:{appearboxurl.start();}}
        SmoothedAnimation{id: appearboxurl;target: urlinputqam;property: "anchors.topMargin"; to: 0; duration: 700}
    height: 80;anchors{right: parent.right;left: parent.left;top: parent.top; topMargin: -100}

    Text {
    id: text
    anchors.top:parent.top
    anchors.topMargin: 1
    anchors.leftMargin: 5
    anchors.left: parent.left
    color:"white"
    width: root.width-35
    maximumLineCount: 1
    font.pixelSize:   if(screen.height===480){largeQAButtons?20:19}else{largeQAButtons?18:17}
    text:web_view1.title
    wrapMode: Text.Wrap
    elide: Text.ElideRight
    }
    TextField{id: dropurlinput;placeholderText:  "Enter URL Here";text:(web_view1.url);anchors{right:parent.right;left:parent.left; bottom:parent.bottom; top:parent.top; topMargin: 25}inputMethodHints: Qt.ImhUrlCharactersOnly;onTextChanged: {
            if (text) {
                clearButton.state =! "ClearVisible"
            } else {
                clearButton.state =! "ClearHidden"
            }
        }
        platformRightMargin: clearButton.width + platformStyle.paddingSmall +2
        Keys.onPressed: {
                 if (event.key == Qt.Key_Enter || event.key == 16777220) {
                    dropurlinput.closeSoftwareInputPanel();
                     if(dropurlinput.text==="http://"){banner.showText("Invaild URL");event.accepted=true;}
                     else if (dropurlinput.text==="https://"){banner.showText("Invaild URL");event.accepted=true;}
                     else{ urlString=web_view1.fixUrl(dropurlinput.text);dropurlinput.focus=false;close();event.accepted=true;}}
                 else if (event.key == Qt.Key_Return){dropurlinput.focus=false; urlString=web_view1.fixUrl(dropurlinput.text);;event.accepted=true; close();}
             }
        Rectangle{ Behavior on width{NumberAnimation{easing.type: Easing.InOutQuart}}Behavior on opacity{NumberAnimation{}}opacity:web_view1.progress == 1.0 ? 0.0 : 0.6; width: (dropurlinput.width - 20) * web_view1.progress; id: progressbartop; height: parent.height-4; radius: 16; anchors.left:parent.left ; anchors.verticalCenter: parent.verticalCenter; color:progressColour; }
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
        anchors.verticalCenter: dropurlinput.verticalCenter
        state: "ClearHidden"
        source: "img/stoptopbar.svg"
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

    MenuButton{z:1;height: parent.height/1.2; width: parent.height/1.2;id: tools;anchors{verticalCenter:parent.verticalCenter;left:parent.left; leftMargin: width;} imgSource: "img/toolbox.svg"; onClicked:{showToolMenu();close();}}
    MenuButton{z:1;height: parent.height/1.2; width: parent.height/1.2;id: consolebutton;anchors{verticalCenter:parent.verticalCenter;right:parent.right; rightMargin: width;} imgSource: "img/console.svg"; onClicked:{creator.createComponent(Qt.resolvedUrl("QAComponents/ConsoleViewer.qml"));close();}}
    MenuButton{z:1;height: parent.height/1.2; width: parent.height/1.2;id: js;anchors{horizontalCenter: parent.horizontalCenter;verticalCenter:parent.verticalCenter} imgSource: "img/javascript.svg"; onClicked:{creator.createComponent(Qt.resolvedUrl("QAComponents/EvaluateJSPopup.qml")); close();}}
    }
    ExtraMenuButton{visible: extensionBar.opened?false:true; anchors.left:parent.left; width: screen.width===640?213.3:120; z: 1; id: voldec; opacity: webAudioPlaying? 1:0; anchors.bottom: box.top;imgSource: "img/volume_decrease.svg";  onClicked:{requestVolumeDecrease()}}
    ExtraMenuButton{visible: extensionBar.opened?false:true;anchors.horizontalCenter: parent.horizontalCenter;z: 1; id: streambut; opacity: webAudioPlaying? 1:0; anchors.bottom: box.top; width: screen.width===640?213.3:120; imgSource: webAudioPlaying? "img/stop.svg": "img/play.svg"; onClicked:{if(webAudioPlaying){stopStreamAudio();root.close() } else playStreamAudio()}}
    ExtraMenuButton{visible: extensionBar.opened?false:true;anchors.right:parent.right; width: screen.width===640?213.6:120; z: 1; id: volinc; opacity: webAudioPlaying? 1:0; anchors.bottom: box.top; imgSource: "img/volume_increase.svg" ; onClicked:{requestVolumeIncrease()} }
Rectangle {
    id: box
    z: 5
    QtObject { id: create; property Component com: null;function createComponent (qmlfile){com = Qt.createComponent(qmlfile);com.createObject(box)} }
    clip: false
    visible: true
    Component.onCompleted: { checkSwipeindset()}
    function checkSwipeindset(){
    if(screen.height===640){if(appsettings.getSystemSetting("swipeind", "")===""){swipeinddelay.start();}}}
    Timer{id: swipeinddelay; interval: 1200; onTriggered:{ create.createComponent("MenuSwipeIndicator.qml");appsettings.saveSystemSetting("swipeind", true); }}
    SmoothedAnimation{id: appearbox; target: box; property: "anchors.bottomMargin"; to: 0;duration: 700}
    color: colour
    height: 230
    Timer{id: startdelay; interval: 200; onTriggered:{appearbox.start()}}
     anchors{
      right: parent.right
      left: parent.left
      bottom: parent.bottom
      bottomMargin: webAudioPlaying?-230-streambut.height: -230
  }
 MouseArea{anchors.fill: parent; enabled:true}
  Flickable{ flickDeceleration: 3000;flickableDirection: Flickable.HorizontalFlick; boundsBehavior: Flickable.DragOverBounds;anchors.fill: parent; id: menuflick; contentWidth: 640
      MenuButton{id:contentlock;anchors{left: parent.left; leftMargin: 3; top: parent.top;topMargin:8} imgSource:  flickable1.interactive == false ? "img/unlock_flat.svg":"img/lock_flat.svg"; onClicked: {  if(flickable1.interactive == true) {
                  banner.showText ("Movemement Locked")
                flickable1.interactive = false
                  close();
              } else {
                  banner.showText("Movement Unlocked")
                flickable1.interactive = true
                  close();
          }}}
      MenuButton{id:settings;anchors{left: parent.left; leftMargin: 15; top: parent.top;topMargin:87} imgSource: "img/settings_flat.svg" ; onClicked: {buttonEnabled=false; opensettings();close();}}
      MenuButton{id:pageback;anchors{left: parent.left; leftMargin: 22; top: parent.top;topMargin:161} imgSource: "img/back_flat.svg" ; onClicked: {web_view1.back.trigger();}}
       MenuButton{id:fav; anchors{left: parent.left; leftMargin: 99; top: parent.top;topMargin:87} imgSource: "img/favourite_flat.svg" ; onClicked: {if (sensitiveMode=== true){
                   banner.showText ("Access Denied, Restricted Mode Activated");close();
               }
               else{buttonEnabled=false;openbookmarks();close();}
           }
           onHold:{if (sensitiveMode=== true){banner.showText ("Access Denied, Restricted Mode Activated");close();}
               else{buttonEnabled=false;saveBookmark();close();}}
       }

       MenuButton{id: audioplayer; buttonPressed: true; opacity: webAudioPlaying? 1:0;anchors{left: parent.left; leftMargin: 150; top: parent.top;topMargin:8} imgSource: "img/music.svg"; onClicked:{close();webAudioPlayerVisible=true;}}
       MenuButton{property string oldUrl;id:reload;anchors{left: parent.left; leftMargin:150 ; top: parent.top;topMargin:161} imgSource:web_view1.progress < 1.0 ? "img/stop_flat.svg" : "img/refresh_flat.svg" ;onClicked: {web_view1.progress < 1.0 ? web_view1.stop.trigger() : oldUrl=web_view1.url; web_view1.url=""; web_view1.url=oldUrl;}}
        MenuButton{id:nightcoverbutton; holdExtra: "true";  buttonPressed: nightcover.visible? true: false; anchors{left: parent.left; leftMargin: 280; top: parent.top;topMargin:87} imgSource: "img/night_flat.svg"; onHold: {ncovertoggle();close();}onClicked: { if (nightcover.visible == true){
             nightcover.visible=false}
             else{
                 nightcover.visible= true
             }}}
        MenuButton{id:pageforward;anchors{left: parent.left; leftMargin: 273; top: parent.top;topMargin:161} imgSource: "img/next_flat.svg" ; onClicked: {web_view1.forward.trigger()}}
        MenuButton{id:hist;anchors{left: parent.left; leftMargin: 190; top: parent.top;topMargin:87} imgSource: "img/history_flat.svg" ; onClicked: {
                    if (sensitiveMode=== true){ banner.showText ("Access Denied, Restricted Mode Activated");close();}
                    else{buttonEnabled=false; close();openhistory();}
            } }
         MenuButton{id:share;anchors{left: parent.left; leftMargin: 292; top: parent.top;topMargin:8} imgSource: "img/share_flat.svg" ; onClicked: {  if (sensitiveMode=== true){
                     banner.showText ("Access Denied, Restricted Mode Activated");close();}
                 else{close();openshare();}}}
         MenuButton{id:closemenu
             buttonPressed:downloadActiveSlot1?true:false; anchors{left: parent.left; leftMargin: 80; top: parent.top;topMargin:8} imgSource:downloadActiveSlot1?"img/download.svg" :"img/toolbar_extension_flat.svg" ;
             onClicked: {if(downloadActiveSlot1===true){openDownloadManagerUI();close();}else{if(extensionBar.opened)extensionBar.hide(); else extensionBar.show()}}
             onHold: { privateStyle.play(Symbian.PopUp);platformPopupManager.privateShowIndicatorPopup()}}
         MenuButton{id:rss;anchors{left: parent.left; leftMargin: 215; top: parent.top;topMargin:8} imgSource: "img/rss_feed_flat.svg" ; onClicked: {buttonEnabled=false;openRSSReader();close();}}
          MenuButton{id:closebutton;anchors{left: parent.left; leftMargin: 363; top: parent.top;topMargin:8} imgSource: "img/close_stop_flat.svg" ; onClicked: {openclose();close();}}
          MenuButton{id:snapbutton;anchors{left: parent.left; leftMargin: 572; top: parent.top;topMargin:8} imgSource: "img/camera_flat.svg" ; onClicked: {closeShot();snapscreen();}}
          MenuButton{id:homebutton; holdExtra: "true"; anchors{left: parent.left; leftMargin: 467.5; top: parent.top;topMargin:8} imgSource: "img/home_flat.svg" ; onHold:{if (sensitiveMode=== true){
                      banner.showText ("Access Denied, Restricted Mode Activated")
                  }
                  else{
                      if (web_view1.url === ""){ banner.showText ("No Webpage Is Loaded.")}
                      else{
                           appsettings.saveSystemSetting("homepage", web_view1.url)
                           banner.showText ("Homepage set: "+ web_view1.title)
                          close();
                      }
                  }} onClicked: {if(appsettings.getSystemSetting("homepage", "")== "") {
                      web_view1.url="";web_view1.url= globalHomepage;close();
                  } else {
                      web_view1.url="";web_view1.url= appsettings.getSystemSetting("homepage", "");
                      close();
                  }}}
          MenuButton{id:searchbutton;anchors{left: parent.left; leftMargin: 363; top: parent.top;topMargin:87} imgSource: "img/search_flat.svg" ; onClicked: { opensearch();dropurlinput.openSoftwareInputPanel();close();}}
          MenuButton{id:copysourcebutton;anchors{left: parent.left; leftMargin: 572; top: parent.top;topMargin:87} imgSource: "img/Code.svg" ; onClicked: {openSourceMenu();close()}}
          MenuButton{id:secondwindowbutton;buttonPressed: windowserver.openWindows==0? false:true; anchors{left: parent.left; leftMargin: 363; top: parent.top;topMargin:161} imgSource: "img/switch_windows_flat.svg" ; onClicked: { if(appsettings.getSystemSetting("switcherType", "")==="") { creator.createComponent("WindowServer/FullScreenSwitcher.qml");} else{ creator.createComponent("QAComponents/WindowSelector.qml");} close()}}
          MenuButton{id:fullscreenbutton;anchors{left: parent.left; leftMargin: 572; top: parent.top;topMargin:161} imgSource: "img/full_screen_flat.svg" ; onClicked: {toggleFullscreen(); closetoolbar();}}
          MenuButton{id:localfilebutton;anchors{left: parent.left; leftMargin: 467.5; top: parent.top;topMargin:87} imgSource: "img/memory_flat.svg" ; onClicked: {fixbackground();fileChooser();close();}}
          MenuButton{id:autoreloadbutton;buttonPressed: autoreload.running == false? false: true;anchors{left: parent.left; leftMargin: 467.5; top: parent.top;topMargin:161} buttonText: "ATR" ; onClicked: { if(autoreload.running == true) {autoreload.stop();banner.showText ("Auto Reload Disabled")} else {autoreload.start();banner.showText ("Auto Reload Enabled")};close();}}
  }
  }
}
