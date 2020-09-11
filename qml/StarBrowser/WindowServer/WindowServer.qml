/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import QtMobility.systeminfo 1.1
import "../"

Item{
id: windowserver
DeviceInfo{id: info}
property bool w1open:false
property bool w2open:false
property bool w3open:false
property bool w4open:false
property bool w5open:false
property bool w6open:false
property bool w0Loading:false
property bool w1Loading:false
property bool w2Loading:false
property bool w3Loading:false
property bool w4Loading:false
property bool w5Loading:false
property bool w6Loading:false
property string w0Title: ""
property string w1Title: ""
property string w2Title: ""
property string w3Title: ""
property string w4Title: ""
property string w5Title: ""
property string w6Title: ""
property string w0Url:""
property string w1Url: ""
property string w2Url: ""
property string w3Url: ""
property string w4Url: ""
property string w5Url: ""
property string w6Url: ""
property int openWindows:0
property Component com: null
property int maxWindows: checkDevice();
signal openw1
signal openw2
signal openw3
signal openw4
signal openw5
signal openw6
signal reloadW0
signal reloadW1
signal reloadW2
signal reloadW3
signal reloadW4
signal reloadW5
signal reloadW6
signal closew1
signal closew2
signal closew3
signal closew4
signal closew5
signal closew6
signal closeAll
signal openLinkW1 (string url)
signal openLinkW2(string url)
signal openLinkW3(string url)
signal openLinkW4(string url)
signal openLinkW5(string url)
signal openLinkW6(string url)
signal hide
signal reloadAll
Component.onCompleted: {console.debug("Allowed Windows "+maxWindows)}
function checkDevice(){if(info.model==="808 PureView") return 6
      else if(info.model==="701") return 6
      else if(info.model==="700") return 6
      else if(info.model==="603") return 6
      else if(info.model==="600") return 6
      else return 3}
function closeAllWindows(){
    closeAll();
    appsettings.saveSystemSetting("externalaccessbool", "true");
    openWindows=0;
}
function reloadAllWindows(){reloadAll();}
function reloadWindow(number){
    if(number===0){reloadW0();}
    else if(number===1){reloadW1();}
    else if(number===2){reloadW2();}
    else if(number===3){reloadW3();}
    else if(number===4){reloadW4();}
    else if(number===5){reloadW5();}
    else if(number===6){reloadW6();}
}
function openWindowIntoURL(number, url){
    var selected;
    if(openWindows===maxWindows)banner.showText("Window Limit Reached")
else{
     appsettings.saveSystemSetting("externalaccessbool", "false");
    if(number===1){if(w1open){openw1();}else{creator.createComponent("WindowServer/Window1.qml"); openWindows+=1; selected=1}}
    else if(number===2){if(w2open){openw2()}else{ creator.createComponent("WindowServer/Window2.qml"); openWindows+=1;selected=2}}
    else if(number===3){ if(w3open){openw3()}else{creator.createComponent("WindowServer/Window3.qml"); openWindows+=1;selected=3}}
    if(number===4){if(w4open){openw4()}else{creator.createComponent("WindowServer/Window4.qml"); openWindows+=1;selected=4}}
    else if(number===5){ if(w5open){openw5()}else{creator.createComponent("WindowServer/Window5.qml"); openWindows+=1;selected=5}}
    else if(number===6){ if(w6open){openw6()}else{creator.createComponent("WindowServer/Window6.qml"); openWindows+=1;selected=6}}


    if(selected===1)openLinkW1(url);
  else  if(selected===2) openLinkW2(url);
  else  if(selected===3) openLinkW3(url);
  else  if(selected===4) openLinkW4(url);
   else if(selected===5) openLinkW5(url);
    else if(selected===6) openLinkW6(url);

    }

}

function hideWindow() {hide();appsettings.saveSystemSetting("externalaccessbool", "true");}
function openWindow(number){
    hide();
    if(openWindows===maxWindows)banner.showText("Window Limit Reached")
    else {
    appsettings.saveSystemSetting("externalaccessbool", "false");
    if(number===1){if(w1open){openw1();}else{creator.createComponent("WindowServer/Window1.qml"); openWindows+=1;}}
    else if(number===2){if(w2open){openw2()}else{ creator.createComponent("WindowServer/Window2.qml"); openWindows+=1;}}
    else if(number===3){ if(w3open){openw3()}else{creator.createComponent("WindowServer/Window3.qml"); openWindows+=1;}}
    if(number===4){if(w4open){openw4()}else{creator.createComponent("WindowServer/Window4.qml"); openWindows+=1;}}
    else if(number===5){ if(w5open){openw5()}else{creator.createComponent("WindowServer/Window5.qml"); openWindows+=1;}}
    else if(number===6){ if(w6open){openw6()}else{creator.createComponent("WindowServer/Window6.qml"); openWindows+=1;}}
        }}
}
