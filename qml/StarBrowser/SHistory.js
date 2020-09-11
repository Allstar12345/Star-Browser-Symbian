.pragma library

var db;

// opens database at launch
function openDB()
{
    db = openDatabaseSync("shistoryDB","1.0","shistory Database",10000000);
    createTable();
}

// creates table if it doesn't exist, otherwise ignores
function createTable()
{
    db.transaction(
       function(tx) {
          tx.executeSql("CREATE TABLE IF NOT EXISTS history (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, url TEXT, engine TEXT)");
       }
    )
}

// deletes table
function dropTable()
{
    db.transaction(
       function(tx) {
          tx.executeSql("DROP TABLE IF EXISTS history");
       }
    )
}

// creates a single history record
function createhistory(historyItem)
{
    db.transaction(
       function(tx) {
          tx.executeSql("INSERT INTO history (title, url, engine) VALUES(?,?,?)",[historyItem.title, historyItem.url, historyItem.engine]);
          console.debug("History Item Created");
       }
    )
}

// updates a single history record
function updatehistory(historyItem)
{
    db.transaction(
       function(tx) {
          tx.executeSql("UPDATE history SET title = ?, url = ?,  engine = ? WHERE id = ?",
                        [historyItem.title, historyItem.url, historyItem.engine, historyItem.id]);
       }
    )
}

// deletes a single history record
function deletehistory(id)
{
    db.transaction(
       function(tx) {
          tx.executeSql("DELETE FROM history WHERE id = ?", [id]);
       }
    )
}

function readHistoryList(model)
{
    model.clear();
    var sqlstring = "SELECT id, title, url, engine FROM history";

    db.readTransaction(
       function(tx) {
          var rs;
          rs = tx.executeSql(sqlstring);
             for (var i = 0; i < rs.rows.length; i++) {
                model.append(rs.rows.item(i))
             }
       }
    )

}

// read a single history item
function readhistoryItem(id) {
    var data = {}
    db.readTransaction(
       function(tx) {
          var rs = tx.executeSql("SELECT * FROM history WHERE id=?", [id])
          if(rs.rows.length === 1) {
             data = rs.rows.item(0)
          }
       }
    )
    return data;
}

// create a default history item
function defaultItem()
{
    return {title: "", url: "", engine: ""}
}