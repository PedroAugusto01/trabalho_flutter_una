import 'package:flutter_app/database/databasemanager.dart';
import 'package:flutter_app/entities/user.dart';
import 'package:sqflite/sqflite.dart';

class UserManager {
  static final table = 'users';

  static final columnId = '_id';
  static final columnName = 'name';
  static final columnGender = 'gender';
  static final columnEmail = 'email';
  static final columnPassword = 'password';
  static final columnAge = 'age';
  static final columnImageZero = 'image0';
  static final columnImageOne = 'image1';
  static final columnImageTwo = 'image2';
  static final columnImageThree = 'image3';
  static final columnImageIntroduction = 'intro';

  Future<int> insertNewUser(User user) async {
    final Database db = await DatabaseManager.instance.database;
    final userId = await db.insert(
      table,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return userId;
  }

  Future<void> updateConsultor(User user) async {
    final db = await DatabaseManager.instance.database;
    await db.update(
      table,
      user.toMap(),
      where: "id = ?",
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUser(int id) async {
    final db = await DatabaseManager.instance.database;
    await db.delete(
      table,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<User> getUser(String email, String password) async {
    final db = await DatabaseManager.instance.database;
    final map = await db.rawQuery(
        'SELECT * FROM $table where $columnEmail=\"$email"\ AND $columnPassword=\"$password\"');
    if (map.isNotEmpty) {
      return _generateUser(map.first);
    }
    return null;
  }

  Future<User> getUserById(int id) async {
    final db = await DatabaseManager.instance.database;
    final map = await db.rawQuery('SELECT * FROM $table where $columnId=$id');
    if (map.isNotEmpty) {
      return _generateUser(map.first);
    }
    return null;
  }

  Future<List<User>> getUsers() async {
    final Database db = await DatabaseManager.instance.database;

    final List<Map<String, dynamic>> maps = await db.query(table);

    return List.generate(maps.length, (i) {
      return _generateUser(maps[i]);
    });
  }

  User _generateUser(Map<String, dynamic> singleMap) {
    return User(
        singleMap[columnId],
        singleMap[columnName],
        singleMap[columnGender],
        singleMap[columnEmail],
        singleMap[columnPassword],
        singleMap[columnAge],
        singleMap[columnImageZero],
        singleMap[columnImageOne],
        singleMap[columnImageTwo],
        singleMap[columnImageThree],
        singleMap[columnImageIntroduction]);
  }
}
