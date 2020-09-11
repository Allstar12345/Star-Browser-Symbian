/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import "../"
AppPage{
    id: root
    z: 4
    property int selectedWindow
    colour: popupbutton.color
    property bool imgLocation:  QMLUtils.checkImagesource()
    property bool wasHidden:false
    Component.onCompleted: {if(webViewHidden===false){webViewHidden=true; wasHidden=false}  else{wasHidden=true;}show();}
    QtObject { id: creatorW; property Component com: null;function createComponent (qmlfile){com = Qt.createComponent(qmlfile);com.createObject(basepage)} }

    function checkWebViewHidden(){if(wasHidden===true) {webViewHidden=true} else{webViewHidden=false} }
    QtObject {
        id: internal
        property bool portrait: screen.currentOrientation == screen.Portrait || screen.currentOrientation == screen.PortraitInverted
    }
    ToolButtonSenseFloat{id: closer; anchors.left: parent.left;  anchors{top:parent.top;}
        imgsource: "../img/back_flat.svg"; buttonBackground: false
        onClicked: {
          checkWebViewHidden();
            close();
        }
    }
        ToolButtonSenseFloat{id: s; anchors{top:parent.top;horizontalCenter: parent.horizontalCenter }
            imgsource: "../img/add_flat.svg"; buttonBackground: false
            opacity: windowserver.maxWindows===windowserver.openWindows? 0:1
            onClicked: {
                if(windowserver.w1open===false){checkWebViewHidden();closeTimed(0);windowserver.openWindow(1);}
                else if(windowserver.w2open===false){checkWebViewHidden();closeTimed(0);windowserver.openWindow(2);}
                 else if(windowserver.w3open===false){checkWebViewHidden();closeTimed(0);windowserver.openWindow(3);close();}
                 else if(windowserver.w4open===false){checkWebViewHidden();closeTimed(0);windowserver.openWindow(4);close();}
                 else if(windowserver.w5open===false){checkWebViewHidden();closeTimed(0);windowserver.openWindow(5);close();}
                 else if(windowserver.w6open===false){checkWebViewHidden();closeTimed(0);windowserver.openWindow(6);close();}
            }
        }
        ButtonSenseFloat{
             buttonText:"Close All"
             buttonBackground: false
             opacity: windowserver.openWindows? 1:0
             anchors.right:parent.right; anchors{top:parent.top;topMargin:4; rightMargin: screen.height===480? 15:0}
             onClicked:windowserver.closeAllWindows();
        }
        function openLongPressMenu() {
            creatorW.createComponent("SwitcherLongPressMenu.qml");
        }

        function decideFlickContentWidth(){
            if(screen.currentOrientation===1){
            if(windowserver.openWindows===0){
               return 360;
            }
            else if(windowserver.openWindows===1){return 610;}
            else if(windowserver.openWindows===2){return 840;}
            else if(windowserver.openWindows===3){return 1070;}
            else if(windowserver.openWindows===4){return 1320;}
            else if(windowserver.openWindows===5){return 1570}
            else if(windowserver.openWindows===6){return 1820;}
            else{return 360}
            }
            if(screen.currentOrientation===2){
                if(windowserver.openWindows===0){
                   return 640;
                }
                else if(windowserver.openWindows===1){return 640;}
                else if(windowserver.openWindows===2){return 840;}
                else if(windowserver.openWindows===3){return 1070;}
                else if(windowserver.openWindows===4){return 1320;}
                else if(windowserver.openWindows===5){return 1570}
                else if(windowserver.openWindows===6){return 1820;}
                else{return 640}

                }
        }

    Flickable{
        id: flickable
        flickableDirection: Flickable.HorizontalFlick;boundsBehavior: Flickable.DragOverBounds;
        anchors{top:s.bottom; topMargin:5 ; bottom:parent.bottom; left:parent.left; right:parent.right}
        contentWidth: decideFlickContentWidth()
        contentHeight: flickable.height

        FullScreenSwitcherItem{
            id: window1Main
            onHold: {selectedWindow=0;openLongPressMenu();}
            onActionButtonClicked: {windowserver.reloadWindow(0);}
            loadingScreen: windowserver.w0Loading?true:false
            closeButton: false
            onClicked: {checkWebViewHidden();closeTimed(0); windowserver.hideWindow()}
            anchors{verticalCenter: parent.verticalCenter; left: parent.left; leftMargin: 80}
            imageSource: imgLocation? "file:///e:/AllStarSoftware/StarBrowser/TabImagesCache/0.png": "file:///c:/AllStarSoftware/StarBrowser/TabImagesCache/0.png"

        }
        FullScreenSwitcherItem{
            id: window2
            onHold: {selectedWindow=1;openLongPressMenu();}
            onActionButtonClicked: {windowserver.reloadWindow(1);}
            loadingScreen: windowserver.w1Loading?true:false
            opacity:windowserver.w1open? 1:0
            onCloseButtonClicked: {windowserver.closew1();
             if(windowserver.w2open===true) window3.anchors.left= window1Main.right; decideFlickContentWidth()
            }
            onClicked: {checkWebViewHidden();closeTimed(0);windowserver.openWindow(1); }
            closeButton: true
            anchors{left: window1Main.right; leftMargin: 30;verticalCenter: parent.verticalCenter; }
            imageSource: imgLocation? "file:///e:/AllStarSoftware/StarBrowser/TabImagesCache/1.png": "file:///c:/AllStarSoftware/StarBrowser/TabImagesCache/1.png"
        }
        FullScreenSwitcherItem{
            onHold: {selectedWindow=2;openLongPressMenu();}
            onActionButtonClicked: {windowserver.reloadWindow(2);}
            loadingScreen: windowserver.w2Loading?true:false
            opacity:windowserver.w2open? 1:0
            id: window3
              onCloseButtonClicked: {windowserver.closew2();if(windowserver.w3open===true) window4.anchors.left= window2.right; decideFlickContentWidth()
              }
            onClicked: {checkWebViewHidden();closeTimed(0);windowserver.openWindow(2); }
            closeButton: true
            anchors{left: window2.right; leftMargin: 30;verticalCenter: parent.verticalCenter; }
            imageSource: imgLocation? "file:///e:/AllStarSoftware/StarBrowser/TabImagesCache/2.png": "file:///c:/AllStarSoftware/StarBrowser/TabImagesCache/2.png"
        }
        FullScreenSwitcherItem{
            onHold: {selectedWindow=3;openLongPressMenu();}
            onActionButtonClicked: {windowserver.reloadWindow(3);}
             opacity:windowserver.w3open? 1:0
                  loadingScreen: windowserver.w3Loading?true:false
          onCloseButtonClicked: {windowserver.closew3();
           if(windowserver.w4open===true) window5.anchors.left= window3.right;decideFlickContentWidth()
          }
            id: window4
            onClicked: {checkWebViewHidden();closeTimed(0);windowserver.openWindow(3); }
            closeButton: true
            anchors{left: window3.right; leftMargin: 30;verticalCenter: parent.verticalCenter; }
            imageSource: imgLocation? "file:///e:/AllStarSoftware/StarBrowser/TabImagesCache/3.png": "file:///c:/AllStarSoftware/StarBrowser/TabImagesCache/3.png"
        }
        FullScreenSwitcherItem{
            onHold: {selectedWindow=4;openLongPressMenu();}
            onActionButtonClicked: {windowserver.reloadWindow(4);}
            id: window5
                 loadingScreen: windowserver.w4Loading?true:false
             opacity:windowserver.w4open? 1:0
              onCloseButtonClicked: {windowserver.closew4();
                  if(windowserver.w5open===true) window6.anchors.left= window4.right;decideFlickContentWidth()
              }

              Component.onCompleted:{if(windowserver.maxWindows==3) window5.destroy(50)}

            onClicked: {checkWebViewHidden();closeTimed(0);windowserver.openWindow(4); }
            closeButton: true
            anchors{left: window4.right; leftMargin: 30;verticalCenter: parent.verticalCenter; }
            imageSource: imgLocation? "file:///e:/AllStarSoftware/StarBrowser/TabImagesCache/4.png": "file:///c:/AllStarSoftware/StarBrowser/TabImagesCache/4.png"
        }
        FullScreenSwitcherItem{
            onHold: {selectedWindow=5;openLongPressMenu();}
            onActionButtonClicked: {windowserver.reloadWindow(5);}
                 loadingScreen: windowserver.w5Loading?true:false
             opacity:windowserver.w5open? 1:0
            onCloseButtonClicked: {windowserver.closew5(); decideFlickContentWidth();if(windowserver.w6open===true) window7.anchors.left= window5.right;decideFlickContentWidth()}
            id: window6
            Component.onCompleted:{if(windowserver.maxWindows==3) window6.destroy(50)}
            onClicked: {checkWebViewHidden();closeTimed(0);windowserver.openWindow(5); }
            closeButton: true
            anchors{left: window5.right; leftMargin: 30;verticalCenter: parent.verticalCenter; }
            imageSource: imgLocation? "file:///e:/AllStarSoftware/StarBrowser/TabImagesCache/5.png": "file:///c:/AllStarSoftware/StarBrowser/TabImagesCache/5.png"
        }
        FullScreenSwitcherItem{
            onHold: {selectedWindow=6;openLongPressMenu();}
            onActionButtonClicked: {windowserver.reloadWindow(6);}
            loadingScreen: windowserver.w6Loading?true:false
            Component.onCompleted:{if(windowserver.maxWindows==3) window7.destroy(50)}
            opacity:windowserver.w6open? 1:0
            onCloseButtonClicked: {windowserver.closew6(); decideFlickContentWidth();}
            id: window7
            onClicked: {checkWebViewHidden();closeTimed(0);windowserver.openWindow(6); }
            closeButton: true
            anchors{left: window6.right; leftMargin: 30;verticalCenter: parent.verticalCenter; }
            imageSource: imgLocation? "file:///e:/AllStarSoftware/StarBrowser/TabImagesCache/6.png": "file:///c:/AllStarSoftware/StarBrowser/TabImagesCache/6.png"

        }
    }
}
