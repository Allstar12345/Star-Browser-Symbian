/**
Copyright (C) 2020 Allstar Software (Paul Wallace)
*/
import QtQuick 1.1
import "History.js" as History
Item{
    id:root
    Component.onCompleted: {History.openDB();History.dropTable(); root.destroy();}
}
