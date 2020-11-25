import 'package:flutter/material.dart';
import 'package:flutter_app/entities/cursePrincipal.dart';
import 'package:flutter_app/database/curseprincipalmanager.dart';

class AddCurso extends StatefulWidget {
  @override
  _AddCursoState createState() => _AddCursoState();
}

class _AddCursoState extends State<AddCurso> {
  final TextEditingController urlController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();

  final _cursePrincipalManager = CursePrincipalManager();
  CursePrincipalDb cursePrincipalDb;
  List<CursePrincipalDb> lista = [];

  @override
  void initState() {
    super.initState();
    _query().then((value) {
      setState(() {
        lista = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
  var idCursoNovo = lista.length + 1;
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar curso'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: urlController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () => urlController.clear(),
                  icon: Icon(Icons.clear),
                ),
                border: OutlineInputBorder(),
                labelText: 'insira o URL da foto',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: nomeController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () => nomeController.clear(),
                  icon: Icon(Icons.clear),
                ),
                border: OutlineInputBorder(),
                labelText: 'insira o nome do curso',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: descricaoController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () => descricaoController.clear(),
                  icon: Icon(Icons.clear),
                ),
                border: OutlineInputBorder(),
                labelText: 'insira a descrição do curso',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text("O numero do curso será: ${idCursoNovo.toString()}")
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(130, 30, 130, 100),
            child: ElevatedButton(
              child: Icon(Icons.add),
              onPressed: () {
                _cursePrincipalManager.insertCurse(idCursoNovo, nomeController.text, descricaoController.text, urlController.text);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<CursePrincipalDb>> _query() async {
    final allRows = await _cursePrincipalManager.getAllCursesPrincipal();
    return allRows;
  }
}