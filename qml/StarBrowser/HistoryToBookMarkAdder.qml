/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import "History.js" as History
import "dbcore.js" as DBcore
Item{
    id: htb
    Component.onCompleted: {DBcore.openDB();savehb()}
   Component.onDestruction: {console.debug("History To Bookmark destroyed")}
   function savehb(){var itemnew = DBcore.defaultItem();
       itemnew.title = bmView.currentItem.myData.title;
       itemnew.url = bmView.currentItem.myData.url;
      DBcore.createBookmark(itemnew)
       banner.showText("Bookmark Saved");
    htb.destroy();}
}
