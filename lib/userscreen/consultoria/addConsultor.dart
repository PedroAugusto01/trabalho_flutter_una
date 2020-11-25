import 'package:flutter/material.dart';
import 'package:flutter_app/database/consultantmanager.dart';
import 'package:flutter_app/entities/cursePrincipal.dart';

class AddConsultor extends StatefulWidget {
  final int idConsultor;
  AddConsultor(this.idConsultor);

  @override
  _AddConsultorState createState() => _AddConsultorState();
}

class _AddConsultorState extends State<AddConsultor> {
  final TextEditingController urlController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController idadeController = TextEditingController();
  final TextEditingController competenciaController = TextEditingController();
  final _consultantManager = ConsultantManager();

  CursePrincipalDb cursePrincipalDb;
  List<CursePrincipalDb> lista = [];

  @override
  Widget build(BuildContext context) {
  var idConsultorNovo = widget.idConsultor + 1;
  print(idConsultorNovo);
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Consultor'),
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
                labelText: 'insira URL da foto do consultor',
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
                labelText: 'insira o nome do consultor',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: idadeController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () => idadeController.clear(),
                  icon: Icon(Icons.clear),
                ),
                border: OutlineInputBorder(),
                labelText: 'insira a idade do consultor',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: competenciaController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () => competenciaController.clear(),
                  icon: Icon(Icons.clear),
                ),
                border: OutlineInputBorder(),
                labelText: 'insira a compentencia do consultor',
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
                labelText: 'insira a descrição do consultor',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text("O numero do consultor será: ${idConsultorNovo.toString()}")
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(130, 30, 130, 100),
            child: ElevatedButton(
              child: Icon(Icons.add),
              onPressed: () {
                _consultantManager.insertConsultant(idConsultorNovo, nomeController.text, int.parse(idadeController.text), descricaoController.text, urlController.text, competenciaController.text);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}