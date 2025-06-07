import 'dart:math';

import 'package:cat_tinder_pro/data/models/cat_model.dart';
import 'package:cat_tinder_pro/domain/entities/cat.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CatTable {
  Database? _db = null;

  late final String _path;

  late final int _version;

  late final String _dbName;

  final Random _rand = Random();

  Future<CatTable> initDb() async {
    _db = await openDatabase(_path, version: _version, onCreate: _createDb);

    return this;
  }

  Future _createDb(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const boolType = 'INTEGER NOT NULL';

    await db.execute('''
        CREATE TABLE IF NOT EXISTS $_dbName (
        id $idType,
        name $textType,
        description $textType,
        url $textType,
        isLiked $boolType
      )
    ''');
  }

  CatTable(
    String dbPath,
    String dbFilename, {
    required int version,
    required String dbName,
  }) {
    _path = join(dbPath, dbFilename);
    print('Path: $_path');
    _version = version;
    _dbName = '$dbName\_$version';
  }

  Future insertCat(Cat cat) async {
    if (_db == null) {
      throw Exception(
        'Database is not initialized. Call initDb() method to initialize.',
      );
    }

    final jsonValues = cat.toJson();

    await _db?.insert(
      _dbName,
      jsonValues,
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future updateCat(Cat cat) async {
    if (_db == null) {
      throw Exception(
        'Database is not initialized. Call initDb() method to initialize.',
      );
    }

    final jsonValues = cat.toJson();

    await _db?.update(
      _dbName,
      jsonValues,
      where: 'id = ?',
      whereArgs: [cat.id],
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  Future<List<Cat>> getAllCats() async {
    if (_db == null) {
      throw Exception(
        'Database is not initialized. Call initDb() method to initialize.',
      );
    }

    final dictList = await _db?.query(_dbName);

    if (dictList == null) {
      return List.empty();
    }

    final cats = dictList.map((el) => CatModel.fromJson(el)).toList();

    return cats;
  }

  Future<Cat?> getRandomCat() async {
    if (_db == null) {
      throw Exception(
        'Database is not initialized. Call initDb() method to initialize.',
      );
    }

    final allCats = await getAllCats();

    if (allCats.isEmpty) {
      return null;
    }

    final index = _rand.nextInt(allCats.length);

    final randomCat = allCats[index];

    return randomCat;
  }

  Future<List<Cat>> getLikedCats({String? breed = null}) async {
    if (_db == null) {
      throw Exception(
        'Database is not initialized. Call initDb() method to initialize.',
      );
    }

    final allCats = await getAllCats();

    final likedCats = allCats
        .where((cat) => cat.isLiked)
        .toList(growable: true);

    final finalCats =
        (breed == null)
            ? likedCats
            : likedCats.where((cat) => cat.name == breed).toList();

    return finalCats;
  }

  Future<List<String>> getUniqueNames() async {
    if (_db == null) {
      throw Exception(
        'Database is not initialized. Call initDb() method to initialize.',
      );
    }

    final query = "SELECT DISTINCT name FROM your_table_name;";

    final maps = await _db!.rawQuery(query);

    return maps.map((map) => map['name'] as String).toList();
  }
}
