// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import "../"



CommonDialoger {
        id: root
        Component.onCompleted: {open();}
    property bool __isClosing: false
        onStatusChanged: {
            if (status === DialogStatus.Closing) __isClosing = true
            else if (status === DialogStatus.Closed && __isClosing) root.destroy()
        }
        titleText: "Clear Cookies"
        privateCloseIcon: false
        buttonTexts: ["Yes", qsTr("Cancel")]
        content: Label {  anchors.centerIn: parent; text: "Are you sure ?";}
        onButtonClicked: {
            if (index === 0)  {
                QMLUtils.purgecookies();
                nami.clearCookies()
                banner.showText(qsTr("Cookies Cleared"))
            }

            else if (index === 1) cookiedio.close();

    }

}



