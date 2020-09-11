/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import "../dbcore.js" as DBcore

Item{
    id: booker
    Component.onCompleted: {DBcore.openDB();createItemer();}
  // Component.onDestruction: {console.debug("History creator destroyed")}
   function createItemer(){saveBook();}
   function saveBook(){if(web_view1.url===""){banner.showText("No URL loaded")}else{var itemnew = DBcore.defaultItem();
           itemnew.title = web_view1.title;
           itemnew.url = web_view1.url;
           itemnew.creationdate = Qt.formatDateTime(new Date(), "dd/MM/yy");
           DBcore.createBookmark(itemnew);
            banner.showText("Bookmark Created")
   booker.destroy();}

}
}
