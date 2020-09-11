/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import WebViewCustom 1.0
import "../"
import "../QAComponents"

AppPage{
    colour:"white"
    id: page
    pageId: "3"
    property string geoLocationStateW: ""
    property string urlerr3: ""
    property bool wmenuOpen: false
    signal loadFinishedMenuWindow
    property bool https:false
    property string urlStringw3:appsettings.getSystemSetting("StartRestore", "") == "True" ? appsettings.getSystemSetting("StartURL", "") : appsettings.getSystemSetting("homepage", "") ;
    QtObject { id: create; property Component com: null;
        function createComponent (qmlfile){
            com = Qt.createComponent(qmlfile)
            com.createObject(page)} }
    MouseArea{anchors.fill: parent; enabled:true}
    Component.onDestruction: console.log("Window 3 Destroyed");
    Component.onCompleted: {show(); webViewHidden=true; windowserver.w3open=true;}
Connections{target: windowserver
    onOpenw3:{show(); webView.visible=true;  webViewHidden=true}
    onHide:{hide();webView.visible=false;  webViewHidden=false}
    onClosew3:{close(); webViewHidden=false; windowserver.w3open=false; windowserver.openWindows-=1;appsettings.saveSystemSetting("externalaccessbool", "true");}
    onCloseAll:{close(); webViewHidden=false; windowserver.w3open=false}
    onReloadAll:{webView.reload.trigger();}
    onReloadW3:{webView.reload.trigger();}
     onOpenLinkW3:{webView.url=url}

}
function openJSEval(){create.createComponent(Qt.resolvedUrl("../QAComponents/EvaluateJSPopup.qml"))}
function openConsole(){create.createComponent(Qt.resolvedUrl("../QAComponents/ConsoleViewer.qml"))}
 function historySave(){create.createComponent(Qt.resolvedUrl("HistorySaver.qml"));}
function showTextFinder(){create.createComponent(Qt.resolvedUrl("WindowFindText.qml"));}
function showWindowToolMenu(){create.createComponent(Qt.resolvedUrl("WindowToolMenu.qml"));}
function openPageBlocked(){ create.createComponent(Qt.resolvedUrl("../ComponentsSB/PageBlockedPage.qml"));}
function snapscreenshot(){fixmargins();snapdelay.start()}
ProgressTray{
    id: progressarea
    visible: true
    progressValue: webView.progress
    anchors{top:parent.top; topMargin: -15; right: parent.right;left: parent.left}
}
Timer{interval: 400; id:snapdelay; onTriggered:{QMLUtils.snapScreen();banner.showText("Screenshot Saved To Gallery"); popupbuttonshowdelay.start();}}
NumberAnimation {id: animationlr; target: flickable; property: "contentX"; duration: 700; easing.type: Easing.InOutQuart }
NumberAnimation {id: animationtb; target: flickable; property: "contentY"; duration: 700; easing.type: Easing.InOutQuart }
NumberAnimation {id: returntozoom; target: webView; property: "contentsScale"; to:1; easing.type: Easing.InOutBounce}
  Timer{id:popupbuttonshowdelay; interval: 200; onTriggered:{popupbut.show()} }
function openswmenu(){create.createComponent(Qt.resolvedUrl("PopupMenu.qml"));}
function scrollTo(velocity, distance)
{
    if(flickable.contentY+distance>=0 && flickable.contentY+distance<=flickable.contentHeight)
    {animationtb.from = flickable.contentY;
        animationtb.to = flickable.contentY+distance
        animationtb.start()
    }
    if(flickable.contentY+distance<0)
    {animationtb.from = flickable.contentY;
        animationtb.to = 0
        animationtb.start()
    }
    if(flickable.contentY+distance>flickable.contentHeight - flickable.height)
    {animationtb.from = flickable.contentY;
        animationtb.to = flickable.contentHeight - flickable.height
        animationtb.start()
    }
}
function scrollToLR(velocity, distance)
{
    if(flickable.contentX+distance>=0 && flickable.contentX+distance<=flickable.contentWidth)
    {
        animationlr.from = flickable.contentX;
        animationlr.to = flickable.contentX+distance
        animationlr.start()
    }
    if(flickable.contentX+distance<0)
    {
        animationlr.from = flickable.contentX;
        animationlr.to = 0
        animationlr.start()
    }
    if(flickable.contentX+distance>flickable.contentWidth - flickable.width)
    {
        animationlr.from = flickable.contentX;
        animationlr.to = flickable.contentWidth - flickable.width
        animationlr.start()
    }
}
  function fixbackground (){
      webView.evaluateJavaScript("\if (!document.body.style.backgroundColor)  { \
                  document.body.style.backgroundColor='white';\
              }\
          ");
  }

Flickable{
    id: flickable
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
    anchors.bottom: wmenuOpen?  parent.bottom:popupbut.top
    anchors.top: parent.top
    contentWidth: Math.max(parent.width,webView.width)
    contentHeight: Math.max(parent.height,webView.height)
    maximumFlickVelocity: 9000
    flickDeceleration: 2000
    boundsBehavior: "StopAtBounds"
    Decorator{flickableItem: flickable}

    flickableDirection: Flickable.AutoFlickDirection
    Keys.onPressed: {
            if (!event.isAutoRepeat) {
                switch (event.key) {
                case Qt.Key_Select:
                {
                break
                }
                    case Qt.Key_Right:
                    {
                        scrollToLR(1,300)
                        break
                    }
                    case Qt.Key_Left:
                    {
                        scrollToLR(1,-300)
                        break
                    }
                    case Qt.Key_Enter:{
                         event.accepted = true
                        break
                    }
                    case Qt.Key_Up: {
                        if (flickable.contentY===0){} else{scrollTo(1,-300)}
                        event.accepted = true
                        break
                    }
                    case Qt.Key_Down: {
                        scrollTo(1,300)
                        break
                    }
                    case Qt.Key_PageDown:{

                            scrollTo(1,300)
                          event.accepted = true
                        break

                    }
                    case Qt.Key_PageUp:{
                        if (flickable.contentY===0){} else{scrollTo(1,-300)}
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

    PinchArea {
       id: pinchArea
       enabled:set_pinch
       anchors.fill: parent
       onPinchStarted: {
          webView.renderingEnabled=false
       }
       onPinchUpdated: {
           if (webView.contentsScale<1.0){flickable.contentX=0; flickable.contentY=0;returntozoom.start()}
          webView.doPinchZoom(pinch.scale/pinch.previousScale,pinch.center,pinch.previousCenter)
       }
       onPinchFinished: {
          if(contentX<0 || contentY<0){
             var sc = webView.contentsScale
             if(webView.contentsScale*webView.width<flickable.width){
                sc=flickable.width/(webView.width/webView.contentsScale)
             }
             var vx=Math.max(0,contentX)+(flickable.width/0.1)
             var vy=Math.max(0,contentY)+(flickable.height/0.1)
             webView.doZoom(sc,vx,vy);
          }else{
             webView.renderingEnabled=true;
          }
       }
       WebViewCustom {
           id: webView
           smooth: false
           function fixUrl(url)
                 {
                     if (url == "") return url
                     if (url[0] == "/") return "file://"+url
                     if (url.indexOf(":")<0) {
                         if (url.indexOf(".")<0 || url.indexOf(" ")>=0) {
                             return "http://www.google.com/m?q="+url
                         } else {
                             return "http://"+url
                         }
                     }
                     return url
                 }
           url: fixUrl(urlStringw3=== ""? globalHomepage: urlStringw3)
           focus: true
           settings.offlineStorageDatabaseEnabled : true
           settings.offlineWebApplicationCacheEnabled : true
           settings.javascriptCanOpenWindows: true
           settings.localStorageDatabaseEnabled : true
           settings.localContentCanAccessRemoteUrls: true
           settings.minimumFontSize: 16
           settings.javascriptEnabled: set_js
           settings.minimumLogicalFontSize: 16
           settings.privateBrowsingEnabled: appsettings.getSystemSetting("pb", "")===""? false: appsettings.getSystemSetting("pb", "")
           settings.javascriptCanAccessClipboard:appsettings.getSystemSetting("jsclip", "")===""? true: appsettings.getSystemSetting("jsclip", "")
           settings.autoLoadImages: set_img
           settings.defaultFontSize: fontSize
           preferredHeight: flickable.height
           preferredWidth: flickable.width
           onAudioRequested:{}
           onImageRequested:{}
           onVideoRequested:{}
           onTitleChanged: {windowserver.w3Title= webView.title}
           onDoubleClick: {showWindowToolMenu();}
           property int dataLastLoad
           property int bytesSettings: parseInt(appsettings.getSystemSetting("totalBytes", ""));
           Connections{
               target: webView
               onWindowCloseRequestedPage:{console.log("Close Requested")}
               onGeoLocationRequested:{}
               onGeoLocationPermissionAccepted:{geoLocationStateW="Allowed"; create.createComponent("GeoSaver.qml");}
               onGeoLocationPermissionDenied:{geoLocationStateW="Disallowed"; create.createComponent("GeoSaver.qml");}

           onDataUsed:{
               webView.dataLastLoad= bytes; console.log("Last Loaded Bytes " +  webView.dataLastLoad)
               console.log("Bytes Settings Value stage 1   -- " + webView.bytesSettings )

                webView.dataLastLoad   += webView.bytesSettings ;
               console.log("Added " +  webView.dataLastLoad)
               appsettings.saveSystemSetting("totalBytes",   webView.dataLastLoad)

               console.log("LAST STEP ---"  + appsettings.getSystemSetting("totalBytes", ""))

           }

           }


           onUrlChanged: {
               urlStringw3= webView.url
               webView.focus = true;
               windowserver.w3Url=webView.url;

               if(urlStringw3.indexOf("https://") > -1) {console.log("HTTPS"); https=true}
               else{https=false}
           }
           onVisibleChanged: console.debug("WebView Visible: " + visible)
           function doZoom(zoom,centerX,centerY)
           {
               if (centerX) {
                  var sc = zoom/contentsScale;
                  scaleAnim.to = zoom;
                  flickVX.from = flickable.contentX
                  flickVX.to = Math.max(0,Math.min(centerX-flickable.width/0.1,webView.width*sc-flickable.width))
                  finalX.value = flickVX.to
                  flickVY.from = flickable.contentY
                  flickVY.to = Math.max(0,Math.min(centerY-flickable.height/0.1,webView.height*sc-flickable.height))
                  finalY.value = flickVY.to
               }
           }
           function doPinchZoom(zoom,center,centerPrev)
           {
              var sc=zoom*contentsScale
              if(sc<=10 ){
                 flickable.contentX=(center.x*zoom)-(center.x-flickable.contentX)+(centerPrev.x-center.x)
                 flickable.contentY=(center.y*zoom)-(center.y-flickable.contentY)+(centerPrev.y-center.y)
                 contentsScale=sc
              }
           }
           onFocusChanged: {
              if ( focus == true ) { flickable.gotFocus(); }
              else { flickable.lostFocus(); }
            }
            onContentsSizeChanged: {
                webView.contentsScale = Math.min(1,flickable.width / contentsSize.width);
            }
            onLoadStarted: {
                  windowserver.w3Loading=true;
                urlerr3=webView.url;
                progressarea.open()
                fixbackground()
                if(blockedmanager.checkURL(urlerr3)===true){ openPageBlocked();stopblockeddelay.start();}
                else{}
            }
            Timer{id: stopblockeddelay; running: false; interval:200; onTriggered: {webView.stop.trigger();}}

            onLoadFailed:{
                  windowserver.w3Loading=false;
               progressarea.close();
               fixbackground();
               console.log("Page Loading Failed")
                if(wmenuOpen===false)pageSnapper.snapPage(3);
                               else{loadFinishedMenuWindow();}
           }
           onLoadFinished: {
                 windowserver.w3Loading=false;
               urlStringw3= webView.url;
               if(urlStringw3.indexOf("https://") > -1) {console.log("HTTPS"); https=true}
               progressarea.close()
               fixbackground()
             appsettings.saveSystemSetting("lasturl", webView.url)
               if(privateBrowsing===false){historySave();}
               if(wmenuOpen===false)pageSnapper.snapPage(3);
                              else{loadFinishedMenuWindow();}

       }
}
    }
}
PopupBut{
    id: popupbut}
}

