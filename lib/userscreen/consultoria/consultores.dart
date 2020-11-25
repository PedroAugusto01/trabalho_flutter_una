import 'package:flutter/material.dart';
import 'package:flutter_app/entities/avaliacao.dart';
import 'package:flutter_app/database/avaliacaomanager.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/entities/consultant.dart';

class Consultores extends StatefulWidget {

  final Consultant consultant;
  Consultores(this.consultant);

  @override
  _ConsultoresState createState() => _ConsultoresState();
}

class _ConsultoresState extends State<Consultores> {
  final _avaliacaoManager = AvaliacaoManager();
  List<AvaliacaoDb> lista;


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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.consultant.name),
        backgroundColor: Colors.red,
      ),
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
                          width: 300,
                          height: 300,
                          decoration: new BoxDecoration(
                            border: new Border.all(
                                color: Colors.grey,
                                width: 3.0,
                                style: BorderStyle.solid
                            ),
                          ),
                          child: Image.network(
                            widget.consultant.url,
                            fit: BoxFit.cover,
                          ),
                        ),
                        new Container(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: new Text(
                            ("Nome: " + widget.consultant.name),
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ),
                        new Container(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: new Text(
                            ("Idade: " + widget.consultant.age.toString()),
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        new Container(
                          alignment: Alignment.topRight,
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Column(
                            children: [
                              new Text(
                                ("Descrição:"),
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              new Text(
                                (widget.consultant.description),
                                style: new TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        new Container(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: new Text(
                            ("AVALIAÇÕES:"),
                            style: new TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                        (lista == null || lista.length == 0)  ? SizedBox():
                        Column(
                            children: lista.map((item) {
                              return item.idConsultor == widget.consultant.id ? Container(
                                margin: const EdgeInsets.all(3.0),
                                padding: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[400]),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(25.0)
                                  ),
                                ),
                                child: ListTile(
                                  title: Text("Nome avaliador: ${item.name}"),
                                  subtitle: Text("Avaliação: ${item.avaliacao}"),
                                  autofocus: true,
                                  hoverColor: Colors.amber,
                                ),
                              ):SizedBox();
                            }
                            ).toList()
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

  Future<List<AvaliacaoDb>> _query() async {
    final allRows = await _avaliacaoManager.getAllAvaliacoes();
    return allRows;
  }
}