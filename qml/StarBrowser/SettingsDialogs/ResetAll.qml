/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../dbcore.js" as DBcore
import "../History.js" as History
import "../SHistory.js" as SHistory
import "../feeds.js" as Feeds
import "../LocationHistory.js" as GeoHistory
import "../"

CommonDialoger {
        id: root
        Component.onCompleted: {open();}
    property bool __isClosing: false
        onStatusChanged: {
            if (status === DialogStatus.Closing) __isClosing = true
            else if (status === DialogStatus.Closed && __isClosing) root.destroy()
        }
        titleText: "Reset All"
        privateCloseIcon: false
        buttonTexts: ["Ok", "Cancel"]
        content:Label{
         width: parent.width-10;wrapMode: Text.Wrap;  anchors.centerIn: parent; color:"white"; text: "This will reset all Star Browser Settings and remove all History, Favourites, Search and Geolocation History."
        }
        onButtonClicked: {
            if (index === 0) {
                appsettings.dropSettings();
                GeoHistory.openDB();
                GeoHistory.dropTable();
                DBcore.openDB();
                DBcore.dropTable();
                History.openDB();
                History.dropTable();
                SHistory.openDB();
                SHistory.dropTable();
                Feeds.openDB();
                Feeds.dropTable();
                nami.clearCookies();
                QMLUtils.purgecookies();
                QMLUtils.purgeTemp();
                QMLUtils.purgeWindowImages();
                QMLUtils.restart();
            }

            else if (index === 1) root.close()
    }
}
