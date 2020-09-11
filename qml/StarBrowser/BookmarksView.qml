/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "dbcore.js" as DBcore

AppPage{
    pageId: "bookmarks"
    colour: "black"
    id: root
    QtObject { id: creator; property Component com: null;function createComponent (qmlfile){com = Qt.createComponent(qmlfile);com.createObject(root)} }
    property int bookmarkId
    Component.onCompleted: {show();DBcore.openDB();toolbarappeardelay.start();webViewHidden=true; updateList();listappear.start();}
    Behavior on opacity{NumberAnimation{}}
    Timer{interval: 1150; id: listappear; onTriggered:{bmView.opacity=1}}
    Timer{id: toolbarappeardelay; interval: 200; onTriggered: {toolbar.appear();}}
    function updateList()
    {
        bmView.model = 0;
        DBcore.readBookmarkList(bmModel);
        bmView.model = bmModel;
        bmView.positionViewAtEnd()
        console.log(bmView.count)
        if(bmView.count===0){bmView.opacity=0; nocontent.opacity=1} else{nocontent.opacity=0}
    }
    function updateSearch(){
        bmView.model = 0;

        DBcore.search(bmModel);
        bmView.model = bmModel;
        console.log(bmView.count)

        if(bmView.count===0){bmView.opacity=0; nocontent.opacity=1} else{nocontent.opacity=0}
    }

    function closePage(){
        webViewHidden=false;
        close();
    }
    function exportBook(){QMLUtils.exportBookmark(bmView.currentItem.myData.url, bmView.currentItem.myData.title); banner.showText("Bookmark Exported to TXT")}

    function openedit(){creator.createComponent(Qt.resolvedUrl("BookMarkEditPage.qml"));}

    function openlongpressmenu(){creator.createComponent(Qt.resolvedUrl("BookmarksLongPressMenu.qml"));}
    function opendeletedialog(){creator.createComponent(Qt.resolvedUrl("BookmarkDelete.qml"));}
    function opendeletealldialog(){creator.createComponent(Qt.resolvedUrl("BookmarkDeleteAll.qml"));}
    function addbookmark(){if(web_view1.url===""){banner.showText("No URL loaded")}else{var itemnew = DBcore.defaultItem();
            itemnew.title = web_view1.title;
            itemnew.url = web_view1.url;
            itemnew.creationdate = Qt.formatDateTime(new Date(), "dd/MM/yy");;
            DBcore.createBookmark(itemnew);
            console.log(itemnew.creationdate)
            updateList();}}
    function deleteBookmark() {
           DBcore.deleteBookmark(bmView.currentItem.myData.id)
           updateList();
        }
    function sethomepage(){
        appsettings.saveSystemSetting("homepage", bmView.currentItem.myData.url)
        banner.showText ("Homepage Set: "+ bmView.currentItem.myData.title)
    }

    function deleteall(){
        DBcore.dropTable()
        DBcore.createTable()
        updateList()
    }
    function openindefault(){QMLUtils.openBrowser(bmView.currentItem.myData.url)}
    function copytoclip(){QMLUtils.copyToClipboard(bmView.currentItem.myData.url)}
    function sharebookmark(){QMLUtils.copyToClipboard(bmView.currentItem.myData.url); openshare(); appsettings.saveSystemSetting("bookmarkshareurl", bmView.currentItem.myData.url)}
    function openshare() {creator.createComponent(Qt.resolvedUrl("BookmarkShare.qml"));}

 TopToolBar{
     id: toolbar
            ToolButtonSense {
                id: btnBack
                anchors.left: parent.left
                imgsource: "img/back_flat.svg"
                onClicked: {
                    closePage()
             }   
          }
            ToolButtonSense{
                imgsource: "img/add_flat.svg"
                anchors{left:parent.left; leftMargin:screen.width===640? 160:100}
                onClicked: {addbookmark();
                }
            }
            ToolButtonSense{
                imgsource: "img/search_flat.svg"
                anchors{right:parent.right; rightMargin:screen.width===640? 160:100}
                onClicked: {
                    if(search.opacity==1) {search.opacity=0; bmView.anchors.top=sectionHeading.bottom; DBcore.searchcriteria=""; updateList();}
                    else{search.opacity=1 ;bmView.anchors.top=search.bottom}
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
     headerText: "Bookmarks"
 }
 TextField{
     id: search
     anchors{left:parent.left;right:parent.right;top:sectionHeading.bottom}
     opacity:0
     placeholderText:"Search Term"
     Behavior on opacity {NumberAnimation{}}
     z:1
     onTextChanged: {
         if(text==""){
             DBcore.searchcriteria=""; updateList();}else{DBcore.searchcriteria =text;updateSearch();}
        }}

 Text{Behavior on opacity{NumberAnimation{duration: 100}}id: nocontent; text:"No Bookmarks To Show"; anchors.centerIn:parent;  font.pointSize: 11; color: "grey"}
    ListView {
        id: bmView
        Behavior on opacity{NumberAnimation{}}
        opacity:0
        footer: Rectangle{visible: bmView.count===0? false: true; anchors{right:parent.right; left: parent.left}color: popupbutton.color; height: 0.6}
        anchors.top: sectionHeading.bottom
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
