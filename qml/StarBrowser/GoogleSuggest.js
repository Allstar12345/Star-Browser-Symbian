// gs.js
var componentGS;
var objectGS;

// dsParam = "yt" only for YouTube suggest else it is empty
function popupGoogleSuggest ( callerItem, textString, dsParam ) {

    deleteGoogleSuggest();
    componentGS = Qt.createComponent("SearchSuggestions/GoogleSearchSuggestion.qml");
    objectGS = componentGS.createObject(callerItem);
    if (objectGS === null) {
        console.log("Error creating ", componentGS.errorString());
    } else {
        objectGS.textToSugget = textString;
        objectGS.dsParam = dsParam;
    }
    return objectGS;
}

function deleteGoogleSuggest()
{
    if (componentGS!==null && objectGS!==undefined) {
        objectGS.timeToDie = true;
    }
}
