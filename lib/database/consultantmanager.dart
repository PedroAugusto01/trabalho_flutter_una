import 'package:flutter_app/database/databasemanager.dart';
import 'package:flutter_app/entities/consultant.dart';
import 'package:sqflite/sqflite.dart';

class ConsultantManager {
  static final table = 'consultant';
  static final id = '_id';
  static final name= 'name';
  static final age = 'age';
  static final description = 'description';
  static final url = 'url';
  static final competencia = 'competencia';


  Future<void> insertConsultantDb(Consultant consultant) async {
    final Database db = await DatabaseManager.instance.database;

    await db.insert(
      table,
      consultant.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertConsultant(int id, String name, int age, String description, String url, String competencia) async {
    final Database db = await DatabaseManager.instance.database;
    await db.rawInsert('INSERT INTO consultant (_id, name, age, description, url, competencia) VALUES(?, ?, ?, ?, ?, ?)',[id, name, age, description, url, competencia]);
  }


  Future<List<Consultant>> getAllConsultantList() async {
    final Database db = await DatabaseManager.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);

    final map = await db.rawQuery('SELECT * FROM consultant');
    if (map.isNotEmpty) {
      var contagem = 0;
      List<Consultant> lista = List();
      for (contagem; contagem <= map.length - 1; contagem++) {
        lista.add(Consultant.fromMap(map[contagem]));
      }
      return lista;
    } else {
      return null;
    }
  }
}