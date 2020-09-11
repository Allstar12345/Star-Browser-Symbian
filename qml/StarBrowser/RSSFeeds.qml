/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "feeds.js" as Feeds

AppPage{
    id: root
    colour: "black"
    QtObject { id: create; property Component com: null;function createComponent (qmlfile){com = Qt.createComponent(qmlfile);com.createObject(root)} }

    property string currentFeed: ""
    property string currentFeedName: ""
    Component.onCompleted: {root.show();Feeds.openDB();webViewHidden=true;updateList()
        bmView.positionViewAtEnd();toolbarappeardelay.start(); listappear.start();}
    Behavior on opacity{NumberAnimation{}}
    Timer{interval: 1150; id: listappear; onTriggered:{bmView.opacity=1}}
    Timer{id: toolbarappeardelay; interval: 200; onTriggered: {toolbar.appear();}}
    function  openFeedList(){create.createComponent(Qt.resolvedUrl("RSSFeedList.qml"));}
    function updateList()
    {
        bmView.model = 0;
        Feeds.readFeedList(bmModel);
        bmView.model = bmModel;
        console.log(bmView.count)
        if(bmView.count===0){bmView.opacity=0; nocontent.opacity=1} else{nocontent.opacity=0}
    }

    function addfeed(){create.createComponent(Qt.resolvedUrl("FeedEditDialog.qml"));}
    function opendeletedialog(){create.createComponent(Qt.resolvedUrl("FeedDeleteDialog.qml"));}
    function opendeletealldialog(){create.createComponent(Qt.resolvedUrl("FeedsDeleteAll.qml"));}
    function deleteFeed() {
           Feeds.deleteFeed(bmView.currentItem.myData.id)
           updateList();
        }
    function deleteall(){
        Feeds.dropTable()
        Feeds.createTable()
        updateList()
    }
    function openLongPressMenu(){create.createComponent(Qt.resolvedUrl("FeedsLongPress.qml"));}
    function openeditfeed(){create.createComponent(Qt.resolvedUrl("RSSFeeds/FeedsEditPage.qml"));}
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
                    root.close();
             }
          }
            ToolButtonSense{imgsource: "img/add_flat.svg"
                anchors.centerIn: parent
                onClicked: {addfeed();
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
 ListHeader{
     anchors.top: toolbar.bottom
     id: sectionHeading
     headerText:"RSS Feeds"
 }

 Text{Behavior on opacity{NumberAnimation{duration: 100}}id: nocontent; text:"No Feeds To Show"; anchors.centerIn:parent;  font.pointSize: 11; color: "grey"}

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
              currentFeed=model.url
              currentFeedName= model.title
              openFeedList();
          }
          onPressAndHold: {openLongPressMenu()}
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
