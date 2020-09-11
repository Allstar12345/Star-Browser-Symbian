/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "SHistory.js" as SHistory

Rectangle{
    id: root
    anchors.fill: parent
    color: "black"
    z: 12
    QtObject { id: create; property Component com: null;function createComponent (qmlfile){com = Qt.createComponent(qmlfile);com.createObject(root)} }

    Component.onCompleted: {root.opacity=1;SHistory.openDB(); updateList()
        bmView.positionViewAtEnd();toolbarappeardelay.start(); listappear.start();}
    Behavior on opacity{NumberAnimation{}}
    Timer{interval: 1150; id: listappear; onTriggered:{bmView.opacity=1}}
    Timer{id: toolbarappeardelay; interval: 200; onTriggered: {toolbar.appear();}}
    function updateList()
    {
        bmView.model = 0;
        SHistory.readHistoryList(bmModel);
        bmView.model = bmModel;
        console.log(bmView.count)
        if(bmView.count===0){bmView.opacity=0; nocontent.opacity=1} else{nocontent.opacity=0}
    }
    function close(){ root.opacity= 0;killtimer.start();
    }
    function opendeletealldialog(){create.createComponent(Qt.resolvedUrl("SearchHistoryDeleteAll.qml"));}
    function deleteHistoryItem() {
           SHistory.deletehistory(bmView.currentItem.myData.id)
           updateList();
        }
    function deleteall(){
        SHistory.dropTable()
        SHistory.createTable()
        updateList()
        appsettings.saveSystemSetting("lastsearch", "");
    }
    Timer{
        id: killtimer
        interval: 950
        onTriggered: {
            root.destroy()
        }
    }
 TopToolBar{
     id: toolbar

            ToolButtonSense {
                id: btnBack
                imgsource: "img/back_flat.svg"
                onClicked: {
                    close();
             }
          }
            ToolButtonSense{
                imgsource: "toolbar-delete"
                anchors.right: parent.right
                onClicked:{
                    opendeletealldialog();
                }
            }
            }
 ListHeader {
     anchors.top: toolbar.bottom
     id: sectionHeading
     headerText:"Search History"
 }

 Text{Behavior on opacity{NumberAnimation{duration: 100}}id: nocontent; text:"No History To Show"; anchors.centerIn:parent;  font.pointSize: 11; color: "grey"}

    ListView {

        Behavior on opacity{NumberAnimation{}}
        id: bmView
        opacity:0
        footer: Rectangle{anchors{right:parent.right; left: parent.left}color: popupbutton.color; height: 0.6}
        anchors.top: sectionHeading.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        clip: true
        model: bmModel
        delegate: bmDelegate
        currentIndex: -1
        highlightFollowsCurrentItem: true
        Decorator{flickableItem: bmView}

    }
    ListModel {
        id: bmModel
    }
    Component {
      id: bmDelegate

      ListItemer {
          Behavior on opacity{NumberAnimation{}}
          property variant myData: model
          id: bmItem
          onClicked: {
             web_view1.url=model.url
              close()
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
                  text: model.engine
              }
          }
      }
    }
}
