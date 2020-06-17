import '../resources/repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';
import '../Models/Item_Model.dart';
import 'repository.dart';

class NewsDbProvider implements Source, Caches {
  Database db;

  NewsDbProvider() {
    init();
  }
  Future<List<int>> fetchTopIds() {
    return null;
  }

  init() async {
    Directory documentsDirecory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirecory.path, 'items5.db');
    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
      newDb.execute("""
      CREATE TABLE Items6
      (
          id INTEGER PRIMARY KEY,
          type TEXT, 
          by TEXT,
          time INTEGER,
          text TEXT,
          parent INTEGER,
          kids BLOB,
          dead INTEGER,
          deleted INTEGER,
          url TEXt,
          score INTEGER,
          title TEXT,
          descendants INTEGER
      )
      """);
    });
  }

  Future<ItemModel> fetchItem(int id) async {
    final mp = await db.query(
      'Items6',
      columns: null,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (mp.length == 0) return null;
    return ItemModel.fromDb(mp.first);
  }

  Future<int> clear() {
    return db.delete('Items6');
  }

  Future<int> addItem(ItemModel item) {
    return db.insert(
      "Items6",
      item.toMapForDb(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}

final newsdbprovider = NewsDbProvider();
