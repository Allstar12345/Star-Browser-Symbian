/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import "History.js" as History
Item{
    id: history
    Component.onCompleted: {History.openDB();createHistoryItem();}
   function savehistory(){var itemnew = History.defaultItem();
       itemnew.title = web_view1.title+ " - "+ Qt.formatDateTime(new Date(), "dd/MM/yy");
       itemnew.url = web_view1.url;
      History.createhistory(itemnew);
    history.destroy();}
    function createHistoryItem(){if (appsettings.getSystemSetting("webhistorytoggle", "")=== ""){savehistory()}else{console.debug("History Item Not Saved")};}
}
