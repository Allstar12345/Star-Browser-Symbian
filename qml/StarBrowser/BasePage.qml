/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import WebViewCustom 1.0
import AppSettings 1.0
import MediaKeysObserver 1.0
import "QAComponents"
import "ComponentsSB"
import "WindowServer"
import "DownloadManager"

Rectangle {
     anchors.fill: parent
     color: "white"
     visible: true
     property alias webView: web_view1
     property bool menuOpen: false
     property string lurl:""
     property bool open:false
     property string geoLocationState: ""
     id: basepage
     QtObject { id: creator; property Component com: null;function createComponent (qmlfile){com = Qt.createComponent(qmlfile);com.createObject(basepage)} }
     property bool fullscreen: false
     property string webViewHeight: ""
     property int webViewWidth
     property bool scrollingDown: false
     property bool scrollingUp: false
     property bool applicationActive:Qt.application.active
     property bool popupButtonEnabled: true
     property bool webViewHidden: false
     property bool https:false
     signal hTTPSChanged
     property bool webAudioPlayerVisible: false
     property bool webAudioPlaying: false
     signal stopStreamAudio
     signal playStreamAudio
     signal loadFinishedMenu
     signal requestVolumeIncrease
     signal requestVolumeDecrease
     property bool imgViewerOpen: false
     property string requestedAudioURL:""
     property string requestedImageURL:""
     property string requestedVideoURL:""
     property bool extraNavigationButtons: true
     onHttpsChanged: {hTTPSChanged();}
     function openDownloadManagerUI(){creator.createComponent("DownloadManager/DownloadManagerUI.qml")}
     Connections{target: webBrowser; onOpenDMUI:{openDownloadManagerUI();}}
     onApplicationActiveChanged: {if(applicationActive){screenSaver.setScreenSaverDelayed(true)}else{if(autoreload.running===true){QMLUtils.showPopup("Warning", "Auto Reload is enabled")}screenSaver.setScreenSaverDelayed(false)}}
     Component.onCompleted: {
         checkExtraNaviStatus();
         if (appsettings.getSystemSetting("mediakeys", "")=== ""){ }
         else{
             mediakeysobserver.destroy()}
         if (appsettings.getSystemSetting("spa", "")=== "enabled"){
             passstart()}
         tipsdiofun()
         if(appsettings.getSystemSetting("pb", "")===""){}
                 else{privateBrowsing= true}}
     function checkExtraNaviStatus(){ if(appsettings.getSystemSetting("onscreennavi", "")===""){leftControl.destroy(); rightControl.destroy(); extraNavigationButtons=false;}}
     Timer{id: copydelay; interval: 400; onTriggered: {QMLUtils.copyToClipboard(web_view1.html); banner.showText("Source code copied to clipboard"); QMLUtils.opennotes()}}
     Timer{id:popupbuttonshowdelay; interval: 200; onTriggered:{popupbutton.show()} }
     function snapscreen(){fixmargins();snapdelay.start()}
     Timer{interval: 400; id:snapdelay; onTriggered:{QMLUtils.snapScreen();banner.showText("Screenshot Saved To Gallery"); popupbuttonshowdelay.start();  if(extraNavigationButtons===true)showScreenControls();}}
     property bool keyboardisOpen:false
     function openReloadPages(){creator.createComponent(Qt.resolvedUrl("SettingsDialogs/ReloadAllPages.qml")); }
     function showTextFinder(){creator.createComponent(Qt.resolvedUrl("ComponentsSB/PageFindText.qml"));}
    function showToolMenu(){creator.createComponent(Qt.resolvedUrl("PageToolMenu.qml"));}
     function saveBookmark(){creator.createComponent(Qt.resolvedUrl("ComponentsSB/BookmarkSaver.qml"));}
     function jumpToEnd(){web_view1.renderingEnabled=true; flickable1.contentY= webViewHeight}
     function toggleFullscreen(){if(fullscreen==false){hideScreenControls();popupbutton.hide();banner.showText ("Double Tap Page at any time to return"); fullscreen=true}
         else{popupbuttonshowdelay.start();fixmargins();fullscreen=false; if(extraNavigationButtons===true)showScreenControls();}
     }
     function openVideoMenu() { creator.createComponent(Qt.resolvedUrl("ComponentsSB/WebVideoMenu.qml"));}
     function openAudioPlayer(){creator.createComponent(Qt.resolvedUrl("ComponentsSB/WebAudioPlayer.qml"));webAudioPlayerVisible=true;}
     function openVideoPlayer(){creator.createComponent(Qt.resolvedUrl("ComponentsSB/WebVideoPlayer.qml"));}
     function openImageViewer(){creator.createComponent(Qt.resolvedUrl("ComponentsSB/WebImageViewer.qml"));}
     function keyboardOpened(){
         if(keyboardisOpen===true){console.debug("Closing"); scrollTo(1, -250); keyboardisOpen=false}
         else{d()}
     }
     function d(){if(flickable1.contentY <inputContext.height){console.debug("Height justified, no movement needed.")}
         else{
             if(screen.width===640){ scrollTo(1, 140); keyboardisOpen=true; console.debug("Opening");}
             else{
             scrollTo(1, 250); keyboardisOpen=true; console.debug("Opening");}}
     }

     function keyboardClosed(){
         if(keyboardisOpen===true){
             if(screen.width===640){console.debug("Closing"); scrollTo(1, -140); keyboardisOpen=false}
             else{
             console.debug("Closing"); scrollTo(1, -250); keyboardisOpen=false}}
         else{d()}
     }
     function showStopPopup(){
         web_view1.stop.trigger();
         creator.createComponent(Qt.resolvedUrl("QAComponents/StopIndicator.qml"));
      }
     function showReloadPopup(){creator.createComponent(Qt.resolvedUrl("QAComponents/ReloadIndicator.qml"));web_view1.reload.trigger();}

     function opensearchHistory(){ creator.createComponent(Qt.resolvedUrl("SearchHistory.qml"));}
     function openSourceMenu(){creator.createComponent(Qt.resolvedUrl("SourceCodeMenu.qml"));}
     function homepage(){if(appsettings.getSystemSetting("homepage", "")== "") {
             web_view1.url= globalHomepage
             banner.showText ("Homepage not defined, loading default homepage")
         } else {
             web_view1.url= appsettings.getSystemSetting("homepage", "")
         }}
     function exportSourceCode(){QMLUtils.exportSource(web_view1.html, web_view1.title); banner.showText("Source Code saved in E:/"+web_view1.title+".html")}

     function historySave(){creator.createComponent(Qt.resolvedUrl("HistorySaver.qml"));}

     function opentipspopup(){creator.createComponent(Qt.resolvedUrl("Help.qml"));}
     function tipsdiofun(){
         if(appsettings.getSystemSetting("tipsdio", "") === ""){creator.createComponent(Qt.resolvedUrl("TipsDio.qml"));}
         else{console.log ("Value Detected, Tips Dio Will Not Be Created") }
     }
     function openRSSReader(){ creator.createComponent(Qt.resolvedUrl("RSSFeeds.qml"));}
     function passstart(){ creator.createComponent(Qt.resolvedUrl("SecurityComponents/EnterPasswordStart.qml"));}
     function openhistory(){creator.createComponent(Qt.resolvedUrl("HistoryView.qml"));}
     function showpopmenu(){creator.createComponent(Qt.resolvedUrl("PopupMenu.qml")); }
     function ncovertoggle(){creator.createComponent(Qt.resolvedUrl("NightIntensityToggle.qml")); }
     function openclose(){ creator.createComponent(Qt.resolvedUrl("CloseDialog.qml"));}
     function opensearch(){creator.createComponent(Qt.resolvedUrl("SearchBox.qml"));}
     function openshare(){creator.createComponent(Qt.resolvedUrl("ShareArea.qml")); }
     function opendevsettings(){creator.createComponent(Qt.resolvedUrl("SettingsPages/DeveloperSettings.qml")); }
     function opensettings(){creator.createComponent(Qt.resolvedUrl("Settings.qml")); }
     function openbookmarks(){creator.createComponent(Qt.resolvedUrl("BookmarksView.qml"));}

     function checkForAnchor(scrollObject,webOject,url){
             var a = new String(url);
             if (a.split("#").length > 1){
                 var textPosition = webOject.evaluateJavaScript("document.getElementById('"+a.split("#")[1]+"').getClientRects()");
                 if (textPosition == 'undefined'){
                     evaluateJavaScript('function getElementsByAttribute(oElm, strTagName, strAttributeName, strAttributeValue){\
                                            var arrElements = (strTagName == "*" && oElm.all)? oElm.all : oElm.getElementsByTagName(strTagName);\
                                            var arrReturnElements = new Array();\
                                            var oAttributeValue = (typeof strAttributeValue != "undefined")? new RegExp("(w^|\\s)" + strAttributeValue + "(\\s|$)", "i") : null;\
                                            var oCurrent;\
                                            var oAttribute;\
                                            for(var i=0; i<arrElements.length; i++){\
                                            oCurrent = arrElements[i];\
                                            oAttribute = oCurrent.getAttribute && oCurrent.getAttribute(strAttributeName);\
                                            if(typeof oAttribute == "string" && oAttribute.length > 0){\
                                            if(typeof strAttributeValue == "undefined" || (oAttributeValue && oAttributeValue.test(oAttribute))){\
                                            arrReturnElements.push(oCurrent);\
                                            }\
                                            }\
                                            }\
                                            return arrReturnElements;\
                                       }')
                     textPosition = webOject.evaluateJavaScript('getElementsByAttribute(document,"*", "title", "'+a.split("#")[1]+'")[0].getClientRects()')
                 }
                 if (textPosition != undefined){
                     scrollObject.contentY = textPosition[0]["top"];
                 }
             }
         }
     function fixmargins(){
         flickable1.anchors.topMargin= 0
         flickable1.anchors.bottomMargin= 0
     }
     function fixbackground (){
       web_view1.evaluateJavaScript("\
                 if (!document.body.style.backgroundColor)  { \
                     document.body.style.backgroundColor='white';\
                 }\
             ");
     }
     function scrollTo(velocity, distance)
     {
         if(flickable1.contentY+distance>=0 && flickable1.contentY+distance<=flickable1.contentHeight)
         {
             animationtb.from = flickable1.contentY;
             animationtb.to = flickable1.contentY+distance
             animationtb.start()
         }
         if(flickable1.contentY+distance<0)
         {
             animationtb.from = flickable1.contentY;
             animationtb.to = 0
             animationtb.start()
         }
         if(flickable1.contentY+distance>flickable1.contentHeight - flickable1.height)
         {
             animationtb.from = flickable1.contentY;
             animationtb.to = flickable1.contentHeight - flickable1.height
             animationtb.start()
         }
     }
     function scrollToLR(velocity, distance)
     {
         if(flickable1.contentX+distance>=0 && flickable1.contentX+distance<=flickable1.contentWidth)
         {
             animationlr.from = flickable1.contentX;
             animationlr.to = flickable1.contentX+distance
             animationlr.start()
         }
         if(flickable1.contentX+distance<0)
         {
             animationlr.from = flickable1.contentX;
             animationlr.to = 0
             animationlr.start()
         }
         if(flickable1.contentX+distance>flickable1.contentWidth - flickable1.width)
         {
             animationlr.from = flickable1.contentX;
             animationlr.to = flickable1.contentWidth - flickable1.width
             animationlr.start()
         }
     }


     WindowServer{id:windowserver}
     NumberAnimation {id: animationlr; target: flickable1; property: "contentX"; duration: 700; easing.type: Easing.InOutQuart }
     NumberAnimation {id: animationtb; target: flickable1; property: "contentY"; duration: 700; easing.type: Easing.InOutQuart }
     NumberAnimation {id: returntozoom; target: web_view1; property: "contentsScale"; to:1; easing.type: Easing.InOutBounce}
     Timer {
         id: longpressscroll
         interval: 5
         repeat: true
         onTriggered: {
             if (mediakeysobserver.key == MediaKeysObserver.EVolIncKey) {
                if(flickable1.contentY===0){} else{scrollTo(1,-300)}
             }
             else if (mediakeysobserver.key == MediaKeysObserver.EVolDecKey) {
                 scrollTo(1,300)
         }
     }
     }

MediaKeysObserver {
         id: mediakeysobserver
         property int key
         onMediaKeyClicked: {
             if (key == MediaKeysObserver.EVolIncKey) {
                 if(webAudioPlaying===true){requestVolumeIncrease()}
                else{
                if (flickable1.contentY===0){} else{scrollTo(1,-300)}}
             }

             else if (key == MediaKeysObserver.EVolDecKey) {
                  if(webAudioPlaying===true){requestVolumeDecrease()}
                  else{
                   if(flickable1.contentY===webViewHeight){}
                      else{
                          scrollTo(1,300)}
                  }

          }
         }
         onMediaKeyPressed: {
             mediakeysobserver.key = key
             longpressscroll.start()
         }
         onMediaKeyReleased: {
             longpressscroll.stop()
         }

}
     ProgressTray{
         id: progresstray
         visible: true
         progressValue: web_view1.progress
         anchors{top:parent.top; topMargin: -15; right: parent.right;left: parent.left}
     }

 Timer {
     id: autoreload
     interval: appsettings.getSystemSetting("timerduration", "3000"); running: false; repeat: true
          onTriggered: {
              web_view1.reload.trigger();
          }
      }
Flickable {
    id: flickable1
    width: parent.width
    height: 640
    anchors.rightMargin: 0
    signal gotFocus
    signal lostFocus
    anchors.bottomMargin: 1
    anchors.leftMargin: 0
    anchors.topMargin: 0
    anchors.right: parent.right
    anchors.left: parent.left
    anchors.bottom: menuOpen?  parent.bottom:popupbutton.top
    anchors.top: parent.top
    contentWidth: Math.max(parent.width,web_view1.width)
    contentHeight: Math.max(parent.height,web_view1.height)
    maximumFlickVelocity: 9000
    flickDeceleration: 2000
    boundsBehavior: "StopAtBounds"
    flickableDirection: Flickable.AutoFlickDirection
    Timer{id:scrollingupdelayfalse; interval: 800; onTriggered:{scrollingUp=false}}
    Timer{id:scrollingdowndelayfalse; interval: 800; onTriggered:{scrollingDown=false}}
    Timer{id:scrollingupdelaytrue; interval: 800; onTriggered:{scrollingUp=true}}

    onVerticalVelocityChanged:{
        if(verticalVelocity >0){
            scrollingDown=true; scrollingupdelayfalse.start();}
        else{scrollingupdelaytrue.start(); scrollingdowndelayfalse.start()}
    }
    Keys.onPressed: {
            if (!event.isAutoRepeat) {
                switch (event.key) {
                case Qt.Key_Select:
                {

                break

                }
                    case Qt.Key_Right:
                    {
                        if(flickable1.contentY===webViewWidth){}
                        else{
                            scrollToLR(1,300)
                          event.accepted = true
                            }
                        break
                    }
                    case Qt.Key_Left:
                    {

                        if(flickable1.contentY===webViewWidth){}
                        else{
                            scrollToLR(1,-300)
                          event.accepted = true
                            }
                        break
                    }
                    case Qt.Key_Enter:{
                         event.accepted = true
                        break
                    }

                    case Qt.Key_Up: {
                        if (flickable1.contentY===0){} else{scrollTo(1,-300)}
                        event.accepted = true
                        break
                    }
                    case Qt.Key_Down: {
                        if(flickable1.contentY===webViewHeight){}
                        else{
                            scrollTo(1,300)
                          event.accepted = true
                        break
                    }
                    }
                    case Qt.Key_PageDown:{
                        if(flickable1.contentY===webViewHeight){}
                        else{
                            scrollTo(1,300)
                          event.accepted = true
                        break
                    }
                    }
                    case Qt.Key_PageUp:{
                        if (flickable1.contentY===0){} else{scrollTo(1,-300)}
                        event.accepted = true
                        break
                    }

                    default: {
                        event.accepted = false
                        break
                    }
                }
            }
        }
    onFlickStarted:{
        scrollbutton.show();
    }
    onWidthChanged : {
        if (width > web_view1.width*web_view1.contentsScale && web_view1.contentsScale < 1.0)
            web_view1.contentsScale = width / web_view1.width * web_view1.contentsScale;
    }
    onMovementStarted: {
        web_view1.renderingEnabled = false;
    }
    onMovementEnded: {
        scrollbutton.hide();
        web_view1.renderingEnabled = true;
    }
    PinchArea {
       id: pinchArea
       enabled:set_pinch
       anchors.fill: parent
       onPinchStarted: { web_view1.renderingEnabled=false}
       onPinchUpdated: {
           if (web_view1.contentsScale<1.0){flickable1.contentX=0; flickable1.contentY=0;returntozoom.start()}
          web_view1.doPinchZoom(pinch.scale/pinch.previousScale,pinch.center,pinch.previousCenter)
       }
       onPinchFinished: {
          if(pinchArea.contentX<0 || pinchArea.contentY<0){
             var sc = web_view1.contentsScale
             if(web_view1.contentsScale*web_view1.width<flickable1.width){
                sc=flickable1.width/(web_view1.width/web_view1.contentsScale)
             }
             var vx=Math.max(0,contentX)+(flickable1.width/0.1)
             var vy=Math.max(0,contentY)+(flickable1.height/0.1)
             web_view1.doZoom(sc,vx,vy);
          }else{
             web_view1.renderingEnabled=true;
          }
       }
       Decorator{
        id: decorator; flickableItem: flickable1}

    WebViewCustom {
        id: web_view1
        smooth: false
        function fixUrl(url)
              {
                  if (url == "") return url
                  if (url[0] == "/") return "file://"+url
                  if (url.indexOf(":")<0) {
                      if (url.indexOf(".")<0 || url.indexOf(" ")>=0) {
                          return "http://www.google.com/m?q="+url
                      } else {return "http://"+url}
                  }
                  return url
              }

        url: fixUrl(urlString=== ""? globalHomepage: urlString)
        focus: true
        visible: webViewHidden? false: true
        settings.offlineStorageDatabaseEnabled : true
        settings.offlineWebApplicationCacheEnabled : true
        settings.javascriptCanOpenWindows: true
        settings.localStorageDatabaseEnabled : true
        settings.localContentCanAccessRemoteUrls: true
        settings.minimumFontSize: 16
        settings.javascriptEnabled: set_js
        settings.minimumLogicalFontSize: 16
        settings.privateBrowsingEnabled: appsettings.getSystemSetting("pb", "")===""? false: appsettings.getSystemSetting("pb", "")
        settings.javascriptCanAccessClipboard: appsettings.getSystemSetting("jsclip","")===""? true: appsettings.getSystemSetting("jsclip","")
        settings.autoLoadImages: set_img
        settings.defaultFontSize:fontSize
        preferredHeight: flickable1.height
        preferredWidth: flickable1.width
        property int dataLastLoad
        property int bytesSettings: parseInt(appsettings.getSystemSetting("totalBytes", ""));
        onTitleChanged: {windowserver.w0Title=web_view1.title}
        Connections{
        target: web_view1
        onDownloadRequested:{
            if(appsettings.getSystemSetting("DownloadManagerType", "")==="old"){downloadBackend.add(url, fileName);}
            else{if(downloadManager.inUse===false){downloadManager.download(url, fileName);}
            else if(downloadManager2.inUse===false){downloadManager2.download(url, fileName);}
            else{banner.showText("Maximum Downloads Reached")}}
            }
        onPageBlocked:{creator.createComponent("ComponentsSB/PageBlockedPage.qml");}
        onWindowCloseRequestedPage:{console.log("Close Requested")}
        onGeoLocationRequested:{}
        onGeoLocationPermissionAccepted:{geoLocationState="Allowed"; creator.createComponent("ComponentsSB/GeoSaver.qml");}
        onGeoLocationPermissionDenied:{geoLocationState="Disallowed"; creator.createComponent("ComponentsSB/GeoSaver.qml");}
        onDataUsed:{
            web_view1.dataLastLoad= bytes; console.log("Last Loaded Bytes " + web_view1.dataLastLoad)
            console.log("Bytes Settings Value stage 1   -- " +web_view1.bytesSettings )
            web_view1.dataLastLoad   += web_view1.bytesSettings ;
            console.log("Added " + web_view1.dataLastLoad)
            appsettings.saveSystemSetting("totalBytes",  web_view1.dataLastLoad)
            console.log("LAST STEP ---"  + appsettings.getSystemSetting("totalBytes", ""))
        }
        }
        Connections{
            target: windowserver
            onReloadAll:{web_view1.reload.trigger();}
            onReloadW0:{web_view1.reload.trigger();}
        }

        onAudioRequested:{
            if(webViewHidden===false){ if(webAudioPlaying==true)stopStreamAudio();requestedAudioURL= data; openAudioPlayer()}}
        onImageRequested:{
             if(webViewHidden===false){console.log("IMAGE REQUESTED URL    "+data); if(imgViewerOpen===false){imgViewerOpen=true; requestedImageURL= data; openImageViewer();stopTimer.start();}}}
        Timer{id:stopTimer; interval: 5000; onTriggered:{web_view1.back.trigger();}}

        onVideoRequested:{
             if(webViewHidden===false){
            console.log("VIDEO REQUESTED URL    " + data); requestedVideoURL=data; openVideoMenu()}}
        onDoubleClick: {
            if(fullscreen==false){showToolMenu();}
            popupbuttonshowdelay.start();fixmargins();fullscreen=false; if(extraNavigationButtons===true)showScreenControls();}
                 onZoomTo: doZoom(zoom,centerX,centerY)

        onUrlChanged: {
            urlString= web_view1.url;
            web_view1.focus = true;
            if(urlString.indexOf("https://") > -1) {https=true;}
            else{https=false;}
        }
        onVisibleChanged: console.debug("WebView Visible: " + visible)
        function doZoom(zoom,centerX,centerY)
        {
            if (centerX) {
               var sc = zoom/contentsScale;
               scaleAnim.to = zoom;
               flickVX.from = flickable1.contentX
               flickVX.to = Math.max(0,Math.min(centerX-flickable1.width/0.1,web_view1.width*sc-flickable1.width))
               finalX.value = flickVX.to
               flickVY.from = flickable1.contentY
               flickVY.to = Math.max(0,Math.min(centerY-flickable1.height/0.1,web_view1.height*sc-flickable1.height))
               finalY.value = flickVY.to
            }
        }
        function doPinchZoom(zoom,center,centerPrev)
        {
           var sc=zoom*contentsScale
           if(sc<=10 ){
              flickable1.contentX=(center.x*zoom)-(center.x-flickable1.contentX)+(centerPrev.x-center.x)
              flickable1.contentY=(center.y*zoom)-(center.y-flickable1.contentY)+(centerPrev.y-center.y)
              contentsScale=sc
           }
        }
        onFocusChanged: {
           if ( focus == true ) { flickable1.gotFocus(); }
           else { flickable1.lostFocus(); }
         }
         onContentsSizeChanged: {
             web_view1.contentsScale = Math.min(1,flickable1.width / contentsSize.width);
         }
         property string urlerr: ""
         onLoadStarted: {
             windowserver.w0Loading=true;
             urlerr=web_view1.url;
             progresstray.open()
             fixbackground()
         }

         onLoadFailed:{
             windowserver.w0Loading=false;
             progresstray.close();
             fixbackground();
             if(menuOpen===false)pageSnapper.snapPage(0);
             else{loadFinishedMenu();}

        }
        onLoadFinished: {
            windowserver.w0Url=web_view1.url;
            windowserver.w0Loading=false;
            urlString= web_view1.url;
            if(urlString.indexOf("https://") > -1) { https=true}
            progresstray.close()
           fixbackground()
            appsettings.saveSystemSetting("lasturl", web_view1.url)
            if(privateBrowsing===false){historySave();}
            if(webViewHidden===true){}
            else{
            if(menuOpen===false)pageSnapper.snapPage(0);
            else{loadFinishedMenu();}
            }
            checkForAnchor(flickable1,web_view1, web_view1.url)
            webViewHeight=web_view1.height -screen.height;
            webViewWidth= web_view1.width-screen.width;

    }
    }
    }
}
function hideScreenControls(){
    if(extraNavigationButtons===true){leftControl.hide(); rightControl.hide()}}
function showScreenControls(){
    if(extraNavigationButtons===true){leftControl.show(); rightControl.show()}}

PopupButton{
    id: popupbutton}
OnScreenControlButtonLeft{id: leftControl; imgSource: "img/back_flat.svg";anchors{bottom:parent.bottom; bottomMargin: -31; leftMargin: -20;left:parent.left} onClicked:{web_view1.back.trigger();}}
OnScreenControlButtonRight{id: rightControl; imgSource: "img/next_flat.svg";anchors{bottom:parent.bottom; bottomMargin: -31; rightMargin: -20;right:parent.right}onClicked:{web_view1.forward.trigger();} }

ScrollButton{id: scrollbutton}
}
