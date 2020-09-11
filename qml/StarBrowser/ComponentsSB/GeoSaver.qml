/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import "../LocationHistory.js" as GeoHistory

Item{
    id: g
    Component.onCompleted: {GeoHistory.openDB();createItemer();}
   function createItemer(){save();}
   function save(){var itemnew = GeoHistory.defaultItem();
           itemnew.title = web_view1.title;
           itemnew.url = web_view1.url;
            itemnew.state=geoLocationState;
           itemnew.creationdate = Qt.formatDateTime(new Date(), "dd/MM/yy");
          GeoHistory.createhistory(itemnew);
   g.destroy();

}
}
