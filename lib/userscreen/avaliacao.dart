import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/database/consultantmanager.dart';
import 'package:flutter_app/database/avaliacaomanager.dart';
import 'package:flutter_app/entities/avaliacao.dart';
import 'package:flutter_app/entities/consultant.dart';

class Avaliacao extends StatefulWidget {
  State<StatefulWidget> createState() => _Avaliacao();
}

class _Avaliacao extends State<Avaliacao> with WidgetsBindingObserver {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController avaliacaoController = TextEditingController();

  final _consultantManager = ConsultantManager();
  Consultant consultor;

  final _avaliacaoManager = AvaliacaoManager();
  AvaliacaoDb avaliacaoDb;


  @override
  void initState() {
    super.initState();
  }

  int selectedValue = 1;

  showPicker() async {
    final data = await _consultantManager.getAllConsultantList();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext cont) {
          return CupertinoPicker(
            backgroundColor: Colors.white,
            onSelectedItemChanged: (value) {
              setState(() {
                selectedValue = value + 1;
              });
            },
            itemExtent: 32.0,
            children: data.map((e) => Text('${e.name}'))
                .toList(),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(32.0),
              child: new Row(
                children: [
                  new Expanded(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new Container(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 10.0),
                              Center(
                                child: RaisedButton(
                                  onPressed: () async {
                                    showPicker();
                                  },
                                  child: Text("Escolha o consultor"),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Container(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: new Text(
                                  ("Consultor selecionado é o: ${selectedValue.toString()}°"),
                                  style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: TextField(
                            controller: nomeController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () => nomeController.clear(),
                                icon: Icon(Icons.clear),
                              ),
                              border: OutlineInputBorder(),
                              labelText: 'insira seu nome',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: TextField(
                            controller: avaliacaoController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () => avaliacaoController.clear(),
                                icon: Icon(Icons.clear),
                              ),
                              border: OutlineInputBorder(),
                              labelText: 'insira sua avaliação',
                            ),
                          ),
                        ),
                        new Container(
                          alignment: Alignment.topRight,
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: new Center(
                            child: RaisedButton(
                              onPressed: () async {
                                if (avaliacaoController.text != "" && nomeController.text != "") {
                                  await _avaliacaoManager.insertAvaliacao(
                                      avaliacaoController.text, selectedValue, nomeController.text);
                                  showDialog(context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                          title: Text("Sucesso!"),
                                          content: Text(
                                              "Os valores foram inseridos no banco com sucesso!"),
                                          actions: <Widget>[
                                            FlatButton(
                                                child: Text("OK"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                }
                                            )
                                          ]
                                      );
                                    },
                                  );
                                } else {
                                  showDialog(context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                          title: Text("Error"),
                                          content: Text(
                                              "Deverá preencher os campos de nome e avaliação, após o preenchimento tente novamente!"),
                                          actions: <Widget>[
                                            FlatButton(
                                                child: Text("OK"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                }
                                            )
                                          ]
                                      );
                                    },
                                  );
                                }
                              },
                              child: const Text('Enviar avaliação', style: TextStyle(fontSize: 20)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}