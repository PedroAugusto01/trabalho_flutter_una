import 'package:flutter_app/database/databasemanager.dart';
import 'package:flutter_app/entities/avaliacao.dart';
import 'package:sqflite/sqflite.dart';

class AvaliacaoManager {
  static final table = 'evaluation';
  static final id = '_id';
  static final idConsultor = 'idConsultor';
  static final name = 'name';
  static final avaliacao = 'avaliacao';

  Future<void> insertConsultant(AvaliacaoDb avaliacaoDb2) async {
    final Database db = await DatabaseManager.instance.database;

    await db.insert(
      table,
      avaliacaoDb2.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertAvaliacao(String consult, int name, String nameAvaliador) async {
    final Database db = await DatabaseManager.instance.database;
    var idConsultor = name.toString();

    await db.rawInsert('INSERT INTO evaluation (idConsultor, name, avaliacao) VALUES(?, ?, ?)',[idConsultor, nameAvaliador, consult]);
  }

  Future<List<AvaliacaoDb>> getAllAvaliacoes() async {
    final Database db = await DatabaseManager.instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);

    final map = await db.rawQuery('SELECT * FROM evaluation');
    if (map.isNotEmpty) {
      var contagem = 0;
      List<AvaliacaoDb> lista = List();
      for (contagem; contagem <= map.length - 1; contagem++ ) {
        lista.add(AvaliacaoDb.fromMap(map[contagem]));
      }
      return lista;
    }
    return null;
  }
}
