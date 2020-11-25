import 'package:flutter/material.dart';
import 'package:flutter_app/database/curselistmanager.dart';
import 'package:flutter_app/entities/curseList.dart';


class AddCursoLista extends StatefulWidget {

  final String idCursoPrincipal, urlCursoPrincipal;
  AddCursoLista(this.idCursoPrincipal, this.urlCursoPrincipal);

  @override
  _AddCursoListaState createState() => _AddCursoListaState();
}

class _AddCursoListaState extends State<AddCursoLista> {
  final TextEditingController urlVideoController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();

  final _curseListManager = CurseListManager();
  CurseListDb curseListDb;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar aulas do curso'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: urlVideoController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () => urlVideoController.clear(),
                  icon: Icon(Icons.clear),
                ),
                border: OutlineInputBorder(),
                labelText: 'insira o URL do video do curso',
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
                labelText: 'insira o numero da aula. Ex: Aula - 01',
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
            child: Text("O numero do curso será: ${widget.idCursoPrincipal}")
          ),
          Padding(
              padding: const EdgeInsets.all(8),
              child: Text("A URL da imagem do curso será: ${widget.urlCursoPrincipal}")
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(130, 30, 130, 100),
            child: ElevatedButton(
              child: Icon(Icons.add),
              onPressed: () {
                _curseListManager.insertCurse(int.parse(widget.idCursoPrincipal), nomeController.text, widget.urlCursoPrincipal, urlVideoController.text, descricaoController.text);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}