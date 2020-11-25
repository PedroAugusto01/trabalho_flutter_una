import 'package:flutter_app/database/databasemanager.dart';
import 'package:flutter_app/entities/curseList.dart';
import 'package:sqflite/sqflite.dart';

class CurseListManager {
  static final table = 'curseList';
  static final id = 'id';
  static final idCurso= 'idCurso';
  static final nome = 'nome';
  static final urlImage = 'urlImage';
  static final urlYoutube = 'urlYoutube';
  static final descricao = 'descricao';

  Future<void> insertConsultant(CurseListDb curseListDb) async {
    final Database db = await DatabaseManager.instance.database;

    await db.insert(
      table,
      curseListDb.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertCurse(int idCurso, String nome, String urlImage, String urlYoutube, String Descricao) async {
    final Database db = await DatabaseManager.instance.database;
    await db.rawInsert('INSERT INTO curseList (idCurso, nome, urlImage, urlYoutube, descricao) VALUES(?, ?, ?, ?, ?)',[idCurso, nome, urlImage, urlYoutube, Descricao]);
  }

  Future<List<CurseListDb>> getAllCursesList() async {
    final Database db = await DatabaseManager.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);

    final map = await db.rawQuery('SELECT * FROM curseList');
    if (map.isNotEmpty) {
      var contagem = 0;
      List<CurseListDb> lista = List();
      for (contagem; contagem <= map.length - 1; contagem++) {
        lista.add(CurseListDb.fromMap(map[contagem]));
      }
      return lista;
    } else {
      return null;
    }
  }
}
