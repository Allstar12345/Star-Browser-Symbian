/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../"

AppPage{
   colour:"#00aaff"
    Component.onCompleted: show();
    id: root
    BusyIndicator{
        height: 100
        Behavior on opacity{NumberAnimation{}}
        width:100
        id: ind
        running:  otherappsmodel.progress===1? false: true
        opacity:  otherappsmodel.progress? 0:1
        anchors.centerIn: parent
    }
    XmlListModel {
        id: otherappsmodel
        source: "http://www.legacy.allstarsoftware.co.uk/StarBrowserOtherAppsModel/model.xml"
        query: "/model/application/item"
        onProgressChanged: {
            console.debug( otherappsmodel.progress)
          }

        XmlRole { name: "name"; query: "name/string()" }
        XmlRole { name: "link"; query: "link/string()" }
        XmlRole { name: "image"; query: "image/string()"}
    }
    ListHeader{
        z: 5
        id: header
        anchors.top: toolbar.bottom
        headerText: "Allstar Software Apps"
    }

        ListView {
            id: list
            clip:true
            anchors{top:header.bottom; bottom:button.top; topMargin:10; right:parent.right; left:parent.left}
            model:  otherappsmodel
            delegate: OtherAppsModel{}
        }
        ButtonSenseFloat{
            id: button
            buttonText: "Back"
            opacity: 1
            anchors{horizontalCenter: parent.horizontalCenter;bottom:parent.bottom;bottomMargin:2}
            onClicked: {close();}
        }

}
