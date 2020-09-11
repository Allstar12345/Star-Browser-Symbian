/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import "SHistory.js" as SHistory
Item{
    id: history
    Component.onCompleted: {SHistory.openDB();checkPrivate()}
    property string engine: appsettings.getSystemSetting("enginetitle", "")
   Component.onDestruction: {console.debug("Search History creator destroyed")}
   function savehistory(){
       console.log("Creating Search History item")
       var itemnew = SHistory.defaultItem();
       itemnew.title = searchinput.text
       itemnew.url = web_view1.url;
       itemnew.engine= engine;
      SHistory.createhistory(itemnew);
       console.log("Search History Item created")
    history.destroy();}
   function checkPrivate(){if(privateBrowsing===true){console.debug("Private enabled, no saving")}
       else{if(appsettings.getSystemSetting("enginetitle", "")===""){
               engine= "Google"
           }
           savehistory()


       }
       }
   }

