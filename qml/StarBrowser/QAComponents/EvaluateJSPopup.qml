/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import "../"
import com.nokia.symbian 1.1


Rectangle {
 id: root
 anchors.fill:parent
 color:nightMode? "Black":popupbutton.colour
 property bool nightMode
 Behavior on color{ColorAnimation{}}
 Behavior on opacity {NumberAnimation{}}
 opacity: 0
 Component.onCompleted: { root.opacity=1;}

 TextAreaa{
 nightMode: root.nightMode;inputMethodHints: Qt.ImhNoAutoUppercase;
 width: parent.width; id:textField
 placeholderText: "Enter Javascript code here then press Apply\n\nThis function calls the WebView evaluateJavaScript() function\n\nExample: alert('Hi, I'm Star Browser!');"
 anchors{top:parent.top; bottom: closeBut.top; bottomMargin:largeQAButtons? 15:10} }
 ToolButtonSenseFloat{buttonBackground: nightMode?false:true;onClicked:{nightMode= !nightMode}id: night;imgsource:"../img/night_flat.svg";anchors{right: parent.right; rightMargin:5;bottom:parent.bottom; bottomMargin:5;}}
 ToolButtonSenseFloat{buttonBackground: nightMode?false:true;onClicked:{root.opacity=0;root.destroy(600)} id:closeBut;imgsource:"../img/close_stop_flat.svg"; anchors{left:parent.left;leftMargin:5; bottom:parent.bottom; bottomMargin:5}}
 ToolButtonSenseFloat{buttonBackground: nightMode?false:true;anchors{horizontalCenter:parent.horizontalCenter;horizontalCenterOffset: width; bottom:parent.bottom;bottomMargin:5;}imgsource:"../img/play.svg"; onClicked:{customJS=textField.text; webView.evaluateJavaScript(customJS);banner.showText("Applied, check console for any messages");}}
 ToolButtonSenseFloat{buttonBackground: nightMode?false:true;anchors{horizontalCenter:parent.horizontalCenter;horizontalCenterOffset: -width; bottom:parent.bottom;bottomMargin:5;}imgsource:"../img/paste.svg"; onClicked:{textField.paste();}}

}
