import 'package:flutter_app/database/databasemanager.dart';
import 'package:flutter_app/entities/cursePrincipal.dart';
import 'package:sqflite/sqflite.dart';

class CursePrincipalManager {
  static final table = 'cursePrincipal';
  static final id = 'id';
  static final idCurso= 'idCurso';
  static final nome = 'nome';
  static final avaliacao = 'avaliacao';
  static final url = 'url';

  Future<void> insertConsultant(CursePrincipalDb cursePrincipalDb) async {
    final Database db = await DatabaseManager.instance.database;

    await db.insert(
      table,
      cursePrincipalDb.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertCurse(int id, String nome, String avaliacao, String url) async {
    final Database db = await DatabaseManager.instance.database;

    await db.rawInsert('INSERT INTO cursePrincipal (idCurso, nome, avaliacao, url) VALUES(?, ?, ?, ?)',[id, nome, avaliacao, url]);
  }

  Future<List<CursePrincipalDb>> getAllCursesPrincipal() async {
    final Database db = await DatabaseManager.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);

    final map = await db.rawQuery('SELECT * FROM cursePrincipal');
    if (map.isNotEmpty) {
      var contagem = 0;
      List<CursePrincipalDb> lista = List();
      for (contagem; contagem <= map.length - 1; contagem++ ) {
        lista.add(CursePrincipalDb.fromMap(map[contagem]));
      }
      return lista;
    } else {
      return null;
    }
  }
}
