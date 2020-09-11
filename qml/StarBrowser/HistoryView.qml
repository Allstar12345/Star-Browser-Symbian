/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "History.js" as History

AppPage{
    pageId:"history"
    colour: "black"
    id: root
    QtObject { id: creator; property Component com: null;function createComponent (qmlfile){com = Qt.createComponent(qmlfile);com.createObject(root)} }

    Component.onCompleted:{ show();History.openDB();webViewHidden=true;  updateList()
        bmView.positionViewAtEnd();toolbarappeardelay.start(); listappear.start();}
    Behavior on opacity{NumberAnimation{}}
    Timer{interval: 1150; id: listappear; onTriggered:{bmView.opacity=1}}
    Timer{id: toolbarappeardelay; interval: 200; onTriggered: {toolbar.appear();}}

    function sethomepage(){
        appsettings.saveSystemSetting("homepage", bmView.currentItem.myData.url)
        banner.showText ("Homepage Set: "+ bmView.currentItem.myData.title)
    }
    function saveHToB(){creator.createComponent(Qt.resolvedUrl("HistoryToBookMarkAdder.qml")); }

    function updateList()
    {
        bmView.model = 0;
        History.readHistoryList(bmModel);
        bmView.model = bmModel;
        console.log(bmView.count)
        if(bmView.count===0){bmView.opacity=0; nocontent.opacity=1} else{nocontent.opacity=0}
    }
    function closePage(){
        webViewHidden=false;close();
    }
    function openlongpressmenu(){creator.createComponent(Qt.resolvedUrl("HistoryLongPressMenu.qml"));}
    function opendeletedialog(){creator.createComponent(Qt.resolvedUrl("HistoryDelete.qml"));}
    function opendeletealldialog(){creator.createComponent(Qt.resolvedUrl("HistoryDeleteAll.qml"));}
    function deleteHistoryItem() {
           History.deletehistory(bmView.currentItem.myData.id)
           updateList();
        }
    function deleteall(){
        History.dropTable()
        History.createTable()
        updateList()
    }
    function openindefault(){QMLUtils.openBrowser(bmView.currentItem.myData.url)}
    function copytoclip(){QMLUtils.copyToClipboard(bmView.currentItem.myData.url)}

 TopToolBar{
     id: toolbar

            ToolButtonSense {
                id: btnBack
                imgsource: "img/back_flat.svg"
                onClicked: {
                    closePage();
             }
          }
            ToolButtonSense{
                imgsource: "img/delete_flat.svg"
                anchors.right: parent.right
                onClicked:{
                    opendeletealldialog();
                }
            }
            }
 ListHeader {
     anchors.top: toolbar.bottom
     id: sectionHeading
     headerText:"Browsing History"
 }

 Text{Behavior on opacity{NumberAnimation{duration: 100}}id: nocontent; text:"No History To Show"; anchors.centerIn:parent;  font.pointSize: 11; color: "grey"}

    ListView {
        Keys.onPressed: {
                if (!event.isAutoRepeat) {
                    switch (event.key) {
                        case Qt.Key_Up: {
                            QMLUtils.showPopup("Up", "Pressed")
                            event.accepted = true
                            break
                        }
                        case Qt.Key_Down: {
                           QMLUtils.showPopup("Down", "Pressed")
                            event.accepted = true
                            break
                        }
                        default: {
                            event.accepted = false
                            break
                        }
                    }
                }
            }

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
        Decorator{flickableItem: bmView; lightColours: true}

    }
    ListModel {
        id: bmModel
    }
    Component {
      id: bmDelegate

      ListItemer {
          property variant myData: model
          id: bmItem
          onClicked: {
             web_view1.url=model.url
              closePage()
          }
          onPressAndHold: {openlongpressmenu()}
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
