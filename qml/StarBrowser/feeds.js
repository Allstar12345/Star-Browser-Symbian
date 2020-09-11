.pragma library

var db;
var compareString = "";

// opens database at launch
function openDB()
{
    db = openDatabaseSync("feedsDB","1.0","feeds Database",1000000);
    createTable();
}

// creates table if it doesn't exist, otherwise ignores
function createTable()
{
    db.transaction(
       function(tx) {
          tx.executeSql("CREATE TABLE IF NOT EXISTS feeds (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, url TEXT, creationdate TEXT, modified DATETIME)");
       }
    )
}

// deletes table
function dropTable()
{
    db.transaction(
       function(tx) {
          tx.executeSql("DROP TABLE IF EXISTS feeds");
       }
    )
}

// creates a single bookmark record
function createFeed(feedItem)
{
    db.transaction(
       function(tx) {
          tx.executeSql("INSERT INTO feeds (title, url, creationdate, modified) VALUES(?,?,?,?)",[feedItem.title, feedItem.url, feedItem.creationdate, feedItem.modified]);
       }
    )
}

// updates a single bookmark record
function updateFeed(feedItem)
{
    db.transaction(
       function(tx) {
          tx.executeSql("UPDATE feeds SET title = ?, url = ?, creationdate = ?, modified = ? WHERE id = ?",
                        [feedItem.title, feedItem.url, feedItem.creationdate, feedItem.modified, feedItem.id]);
       }
    )
}

// deletes a single bookmark record
function deleteFeed(id)
{
    db.transaction(
       function(tx) {
          tx.executeSql("DELETE FROM feeds WHERE id = ?", [id]);
       }
    )
}
// read list of bookmarks
function readFeedList(model)
{
    model.clear();
    var sqlstring = "SELECT id, title, url, creationdate FROM feeds";
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



// read a single bookmark item
function readFeedItem(id) {
    var data = {}
    db.readTransaction(
       function(tx) {
          var rs = tx.executeSql("SELECT * FROM feeds WHERE id=?", [id])
          if(rs.rows.length === 1) {
             data = rs.rows.item(0)
          }
       }
    )
    return data;
}

// create a default bookmark item
function defaultItem()
{
    return {title: "", url: "", creationdate: new Date(), modified: new Date()}
}
