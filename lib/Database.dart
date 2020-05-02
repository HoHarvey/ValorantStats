import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'MapStats.dart';

class SQLiteDbProvider {
  SQLiteDbProvider._();
  static final SQLiteDbProvider db = SQLiteDbProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "MapStatsDB.db");
    return await openDatabase(path,
        version: 1,
        onOpen: (db){},
        onCreate: (Database db, int version) async {
          await db.execute(
              "CREATE TABLE MapStats("
                  "id INTEGER PRIMARY KEY,"
                  "name TEXT,"
                  "pictureUri TEXT,"
                  "backgroundDetailsUri TEXT,"
                  "attackersRoundWins INTEGER,"
                  "defendersRoundWins INTEGER,"
                  "spikesPlanted INTEGER,"
                  "spikesDefused INTEGER,"
                  "spikesDetonated INTEGER,"
                  "firstBloods INTEGER,"
                  "firstBloodWins INTEGER,"
                  "eliminationWins INTEGER"
                  ")"
          );
          await db.execute("INSERT INTO MapStats("
              "'id',"
              "'name',"
              "'pictureUri',"
              "'backgroundDetailsUri',"
              "'attackersRoundWins',"
              "'defendersRoundWins',"
              "'spikesPlanted',"
              "'spikesDefused',"
              "'spikesDetonated',"
              "'firstBloods',"
              "'firstBloodWins',"
              "'eliminationWins'"
              ") "
              "values (?,?,?,?,?,?,?,?,?,?,?,?)",
              [1,
                "Haven",
                "images/ButtonHavenMapIconTwo.png",
                "images/800px-Haven_Map.png",
                0,
                0,
                0,
                0,
                0,
                0,
                0,
                0
              ]
          );
          await db.execute("INSERT INTO MapStats("
              "'id',"
              "'name',"
              "'pictureUri',"
              "'backgroundDetailsUri',"
              "'attackersRoundWins',"
              "'defendersRoundWins',"
              "'spikesPlanted',"
              "'spikesDefused',"
              "'spikesDetonated',"
              "'firstBloods',"
              "'firstBloodWins',"
              "'eliminationWins'"
              ") "
              "values (?,?,?,?,?,?,?,?,?,?,?,?)",
              [2,
                "Bind",
                "images/ButtonBindMapIcon.png",
                "images/800px-Bind_Map.png",
                0,
                0,
                0,
                0,
                0,
                0,
                0,
                0
              ]
          );
          await db.execute("INSERT INTO MapStats("
              "'id',"
              "'name',"
              "'pictureUri',"
              "'backgroundDetailsUri',"
              "'attackersRoundWins',"
              "'defendersRoundWins',"
              "'spikesPlanted',"
              "'spikesDefused',"
              "'spikesDetonated',"
              "'firstBloods',"
              "'firstBloodWins',"
              "'eliminationWins'"
              ") "
              "values (?,?,?,?,?,?,?,?,?,?,?,?)",
              [3,
                "Split",
                "images/ButtonSplitMapIcon.png",
                "images/800px-Split_Map.png",
                0,
                0,
                0,
                0,
                0,
                0,
                0,
                0
              ]
          );
        }
    );
  }

  Future<List<MapStats>> getAllMapsStats() async {
    final db = await database;
    List<Map> results = await db.query(
        "MapStats", columns: MapStats.columns, orderBy: "id ASC"
    );
    List<MapStats> mapsStats = new List();
    results.forEach((result) {
      MapStats mapStats = MapStats.fromMap(result);
      mapsStats.add(mapStats);
    });
    return mapsStats;
  }

  Future<MapStats> getMapStatsById(int id) async {
    final db = await database;
    var result = await db.rawQuery('SELECT * FROM MapStats WHERE id = $id');
    return result.length > 0 ? MapStats.fromMap(result.first) : Null;
  }

  update(MapStats mapStats) async {
    final db = await database;
    var result = await db.update("MapStats", mapStats.toMap(),
        where: "id = ?", whereArgs: [mapStats.id]);
    return result;
  }

}



