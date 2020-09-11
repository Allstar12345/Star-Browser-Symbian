/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/

import QtQuick 1.1
import com.nokia.symbian 1.1
import QtMobility.systeminfo 1.1
import DownloadManager 1.0
import DownloadManager 1.1
import DownloadBackend 1.0
import AppSettings 1.0
import "ComponentsSB"
import "QAComponents"
import "DownloadManager"

Window {
    visible: true
    id: webBrowser
    property string customJS
    QtObject { id: create; property Component com: null;function createComponent (qmlfile){com = Qt.createComponent(qmlfile);com.createObject(webBrowser)} }
    property bool privateBrowsing: false
    property string nE6: screen.height === 480
    property bool largeQAButtons: appsettings.getSystemSetting("visualImpaired", "false")
    property string globalHomepage:"http://google.com"
    property bool sensitiveMode: appsettings.getSystemSetting("pm", "")==="" ?false:true
    property string fontSize:appsettings.getSystemSetting("fontsize", "")===""? 16: appsettings.getSystemSetting("fontsize", "");
    property bool set_img : appsettings.getSystemSetting("images", "") ?appsettings.getSystemSetting("images", "") : true;
    property bool set_js: appsettings.getSystemSetting("javaScript", "") ?appsettings.getSystemSetting("javaScript", "") : true;
    property bool set_pinch: appsettings.getSystemSetting("pinchenabled", "") != '' ? appsettings.getSystemSetting("pinchenabled", "") : true;
    property bool set_scroll: appsettings.getSystemSetting("scrollbut", "") != '' ? appsettings.getSystemSetting("scrollbut", "") : true;
    property string homeString : appsettings.getSystemSetting("StartRestore", "") == "True" ? appsettings.getSystemSetting("StartURL", "") : appsettings.getSystemSetting("homepage", "") ;
    property string urlString : homeString;
    property string ncqueryopen: "false"
    property string progressColour: appsettings.getSystemSetting("progresscolour", "") ? appsettings.getSystemSetting("progresscolour", ""): "red"
    property bool coveralreadyopen: false
    property real downloadProgressSlot1
    property bool downloadPausedSlot1:false
    property bool downloadActiveSlot1:false
    property int downloadedbytesSlot1
    property double downloadPercentageSlot1
    property string downloadURLSlot1
    property real downloadProgressSlot2
    property bool downloadPausedSlot2:false
    property bool downloadActiveSlot2:false
    property int downloadedbytesSlot2
    property double downloadPercentageSlot2
    property string downloadURLSlot2
    signal openDMUI
    BasePage{id: basepage; visible: true}
    NightCover{ clip: true;id: nightcover;visible: false;anchors.fill: parent;z: Infinity}
    QtObject { id: createMain; property Component com: null;function createComponent (qmlfile){com = Qt.createComponent(qmlfile);com.createObject(basepage)} }
DownloadManager{id: downloadManager; property bool inUse:false}
DownloadManager2{id: downloadManager2; property bool inUse:false}
DownloadBackend{id:downloadBackend}

Connections{target: downloadManager2
    onDownloadStarted: {console.log("Download Slot 2 Started");downloadActiveSlot2 = true;downloadManager2.inUse=true; }
    onDownloadStatus: {downloadProgressSlot2 = currentStatus;}
    onProgressPercentage: { downloadPercentageSlot2 = percentage; }
    onDownloadComplete: {downloadActiveSlot2 = false; downloadManager2.inUse=false;QMLUtils.showPopup("Download Completed", "");}
    onDownloadPaused: {downloadPausedSlot2 = true;}
    onDownloadResumed: { downloadPausedSlot2 = false;}
    onDownloadCancelled: { downloadActiveSlot2 = false;QMLUtils.showPopup("Download Cancelled", "");}
    onDownloadedBytes: {downloadedbytesSlot2 = bytesReceived;}
    onDownloadURLChanged:{downloadURLSlot2= downloadURL}
}
Connections{target: downloadManager
    id: dmCon

    onDownloadStarted: {
        console.log("Download Slot1 Started");
        downloadActiveSlot1 = true
        downloadManager.inUse=true;
        openDMUI();
    }
    onDownloadStatus: {
        downloadProgressSlot1 = currentStatus;
    }
    onProgressPercentage: {
        downloadPercentageSlot1 = percentage
    }
    onDownloadComplete: {
        downloadActiveSlot1 = false;
        downloadManager2.inUse=false;
        QMLUtils.showPopup("Download Completed", "");
    }
    onDownloadPaused: {
        downloadPausedSlot1 = true;
    }
    onDownloadResumed: {
        downloadPausedSlot1 = false;
    }
    onDownloadCancelled: {
        downloadActiveSlot1 = false;
         QMLUtils.showPopup("Download Cancelled", "");

    }
    onDownloadedBytes: {downloadedbytesSlot1 = bytesReceived;}
    onDownloadURLChanged:{downloadURLSlot1= downloadURL}

}

  AppSettings{id: appsettings;}

  Timer{id:nightcovertimecheck; interval:3000000 ;repeat: true; running: appsettings.getSystemSetting("nightcoverauto", "false");onTriggered: {if(nightcover.visible===false){if (symbian.currentTime>"19:00"){console.log("Time greater than minimum value");if(ncqueryopen==="true"){} else{ console.debug("Should open night cover query here");opennightcoverautocheckerpopup()}} }else{console.debug("Auto Night Cover Ask Not Triggered")}   }
     Component.onCompleted: {console.debug("Auto Night Cover Checker= "+ nightcovertimecheck.running)}}
   ScreenSaver { id: screenSaver;Component.onCompleted: {screenSaver.setScreenSaverDelayed(true) }}
   Timer{id: autonetworkcheck; interval: 3000000;repeat: true; running: appsettings.getSystemSetting("autocheck", "false"); onTriggered: {if(networkMonitor.online== true){console.log("Auto check online")}else{banner.showText("Internet Connection Is Not Available")}} Component.onCompleted: {console.debug("Network Check component= "+ autonetworkcheck.running)}}
    Banner{z: 10;id: banner;function showText(text) {banner.text = qsTr(text);banner.banneropen()}}
    WebPageSnapper{id: pageSnapper}
    function quitStarbrowser(){
        if(downloadActiveSlot1===true){QApp.downloadCloseDialog();}
        else if(downloadActiveSlot2===true){QApp.downloadCloseDialog();}
        else{

        if (appsettings.getSystemSetting("cookonclose", "")=== "true"){nami.clearCookies();QMLUtils.purgecookies()}
        if(appsettings.getSystemSetting("historyonclose", "")){openHistoryCleaner();}
        if(privateBrowsing===false){
            appsettings.saveSystemSetting("StartURL", appsettings.getSystemSetting("lasturl", ""))}
        appsettings.saveSystemSetting("externalaccessbool", "true");
        QMLUtils.purgeWindowImages();
        Qt.quit();}}
    function restartStarBrowser(){
        if (appsettings.getSystemSetting("cookonclose", "")=== "true"){nami.clearCookies();QMLUtils.purgecookies()}
        if(appsettings.getSystemSetting("historyonclose", "")){openHistoryCleaner();}
        if(privateBrowsing===false){
            appsettings.saveSystemSetting("StartURL",appsettings.getSystemSetting("lasturl", ""))}
        appsettings.saveSystemSetting("externalaccessbool", "true");
        QMLUtils.purgeWindowImages();
        QMLUtils.restart();
    }

    function openHistoryCleaner(){create.createComponent(Qt.resolvedUrl("HistoryCleaner.qml"));}

    function opennightcoverautocheckerpopup(){create.createComponent(Qt.resolvedUrl("AutoNightCoverDialog.qml"));ncqueryopen="true"}
    function firstrun(){create.createComponent(Qt.resolvedUrl("FirstRunDialog.qml"));}
    function firstrunE6(){create.createComponent(Qt.resolvedUrl("FirstRunScreenEType.qml"));}
    Timer{id:visibleDelay; interval: 20000; onTriggered:{basepage.visible=false;}}
    Connections {
           target: QApp
           onCloseWithoutDialog:
           {
               if (appsettings.getSystemSetting("cookonclose", "")=== "true"){nami.clearCookies();QMLUtils.purgecookies()}
               if(appsettings.getSystemSetting("historyonclose", "")){openHistoryCleaner();}
               if(privateBrowsing===false){
                   appsettings.saveSystemSetting("StartURL", appsettings.getSystemSetting("lasturl", ""))}
               appsettings.saveSystemSetting("externalaccessbool", "true");
               QMLUtils.purgeWindowImages();
               if(downloadActiveSlot1===true){downloadManager.cancel();}
               if(downloadActiveSlot2===true){downloadManager2.cancel();}
               Qt.quit();}

           onEndKey:{basepage.jumpToEnd();}
           onHomeKey:{basepage.homepage();}
           onF6Key:{basepage.openSourceMenu()}
           onF4Key:{basepage.toggleFullscreen();}
           onF3Key:{basepage.opentipspopup();}
           onReloadKey:{basepage.showReloadPopup();}
           onInFocus:{basepage.visible=true; visibleDelay.stop();}
           onInBackground:{visibleDelay.start();}
           onRedPressed:{quitStarbrowser();}
           onKeyboardEventChanged:{
            if(screen.height===480){}
            else{if(appsettings.getSystemSetting("keyboardTextFieldMoveExperimental", "")==="true"){
             basepage.keyboardOpened();}}
        }
    }

    Component.onCompleted:{
        if(appsettings.getSystemSetting("firstrunnn", "")=== ""){ basepage.destroy();if(screen.height===480){firstrunE6();}else{firstrun();}}
        if(appsettings.getSystemSetting("tskm", "")==="false"){QMLUtils.hideFromSight()}
    }
}
