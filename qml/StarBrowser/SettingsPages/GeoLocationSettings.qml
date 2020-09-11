/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../"
import "../LocationHistory.js" as GeoHistory
import "../ComponentsSB"

AppPage{
color: "black"
Component.onCompleted: {show();listappear.start(); toolbar.appear();GeoHistory.openDB();updateList();}
id: geoset
Timer{interval: 430; id: listappear; onTriggered:{ columnsett.opacity=1; bmView.opacity=1;headerhist.opacity=1 }}
TopToolBar{
    setDuration: "400"
    id: toolbar
    ToolButtonSense {
        id: btnBac
        imgsource: "../img/back_flat.svg"
        onClicked: {close()
     }
  }
    ToolButtonSense{
        imgsource: "../img/delete_flat.svg"
        anchors.right: parent.right
        onClicked: {
               GeoHistory.dropTable()
                GeoHistory.createTable()
                updateList()

        }
    }
}


function updateList(){bmView.model = 0;GeoHistory.readHistoryList(bmModel);bmView.model = bmModel;bmView.positionViewAtEnd();console.log(bmView.count)}


Column {
    anchors.top:toolbar.bottom
    opacity:0
    id: columnsett
   spacing: 1

   ListHeader {
       id: header
       z: 1
       headerText:"GeoLocation Settings"
   }
   ListItemer {
       z: 5
              clip:true
              id: geoee
              enabled: false

              Column { anchors.fill: geoee.paddingItem
                  ListItemText {
                       role: "Title"
                       text: "Allow GeoLocation"
                      anchors.fill: geoee.paddingItem
                   }
             }
              Switcher{
                  enabled: privateBrowsing?false: true
                  id: geoeebox
                  anchors.right: parent.right
                 anchors.rightMargin: 1
                  anchors.verticalCenter: parent.verticalCenter
                  checked:appsettings.getSystemSetting("geoLocation", "")?false:true
                  onClicked: {
                      if(appsettings.getSystemSetting("geoLocation", "") ===""){appsettings.saveSystemSetting("geoLocation", "false")}
                      else if(appsettings.getSystemSetting("geoLocation", "")==="false"){appsettings.saveSystemSetting("geoLocation", "")}
                  }
              }
         }

}
ListHeader {
    id: headerhist
    opacity:0
    anchors.top:columnsett.bottom
    z: 1
    headerText:"GeoLocation History"
}

   ListView {
       id: bmView
        z:1
        opacity:0
       anchors.top: headerhist.bottom
       anchors.bottom: parent.bottom
       anchors.left: parent.left
       anchors.right: parent.right
       clip: true
       model: bmModel
       delegate: bmDelegate
       highlightFollowsCurrentItem: true
       currentIndex: count
       Decorator{flickableItem: bmView; lightColours: true}
   }
   ListModel {
       id: bmModel
   }
   Component {
     id: bmDelegate
     ListItemer {
         property bool selected: false
         property variant myData: model
         id: bmItem
         Image{
             sourceSize.width:43
             sourceSize.height: 47
             height:sourceSize.height
             width: sourceSize.width
             source: model.state==="Allowed"? "../img/location_mark_small.svg": "../img/location_mark_small_off.svg"
             anchors{verticalCenter: parent.verticalCenter; right:parent.right; rightMargin:2}
         }

         Column { anchors.fill: bmItem.paddingItem
             ListItemText {
                 id: titleTxt
                 role: "Title"
                  mode: bmItem.mode
                 text: model.title
             }
             ListItemText {
                 id: weburlTxt
                 role: "SubTitle"
                 mode: bmItem.mode
                 text: model.url
             }
         }
     }
   }

}

