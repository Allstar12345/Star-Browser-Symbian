var DatabaseName = "bookmarks";
var DatabaseDescription = "Star Browser Bookmarks";
var TableName = "book";

var db = openDatabaseSync("STARBROWSERBOOK", "1.0", "SBB", 1);
function createDb() {
    db.transaction(
        function(createDbTransaction) {
            createDbTransaction.executeSql('CREATE TABLE IF NOT EXISTS '
                                           + TableName + '(name TEXT, count INT)');
        }
    );
}
function newItem(name, count) {
    db.transaction(
        function(newItemTransaction) {
            newItemTransaction.executeSql('INSERT INTO ' + TableName
                                          + ' VALUES(?, ?)', [ name, count ]);
        }
    );
}

function update(model) {
    db.transaction(function(getRowsTransaction) {
        var rows = getRowsTransaction.executeSql('SELECT * FROM ' + TableName);
        model.clear();

        for (var i = 0; i < rows.rows.length; i++) {
            var item = rows.rows.item(i);
            model.append({"name": item.name,
                          "count": item.count});
        }
    });
}




