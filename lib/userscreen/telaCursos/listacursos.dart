import 'package:flutter/material.dart';
import 'package:flutter_app/database/curselistmanager.dart';
import 'package:flutter_app/entities/curseList.dart';
import 'package:flutter_app/entities/cursePrincipal.dart';
import 'package:url_launcher/url_launcher.dart';
import 'addCursoLista.dart';

class ListaCursos extends StatefulWidget {

  final CursePrincipalDb cursePrincipalDb;
  ListaCursos(this.cursePrincipalDb);

  @override
  _ListaCursosState createState() => _ListaCursosState();
}

class _ListaCursosState extends State<ListaCursos> {
  final _curseListManager = CurseListManager();
  List<CurseListDb> lista2 = [];


  @override
  void initState() {
    super.initState();
    _query().then((value) {
      setState(() {
        lista2 = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cursePrincipalDb.nome),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: lista2.map((item2) {
                if (item2.idCurso == widget.cursePrincipalDb.id.toInt()) {
                  return Container(
                    margin: const EdgeInsets.all(3.0),
                    padding: const EdgeInsets.all(4.0),
                    child: ListTile(
                        leading: Image.network(item2.urlImage),
                        title: Text(item2.nome),
                        subtitle: Text(item2.descricao),
                        trailing: Icon(Icons.arrow_forward_ios),
                        hoverColor: Colors.amber,
                        onTap: () {
                          launch(item2.urlYoutube);
                        }
                    ),
                  );
                } else {
                  return SizedBox();
                }
              }
              ).toList() ?? [],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddCursoLista(widget.cursePrincipalDb.idCurso.toString(), widget.cursePrincipalDb.url)),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple[900],
      ),
    );
  }

  Future<List<CurseListDb>> _query() async {
    final allRows = await _curseListManager.getAllCursesList();
    return allRows;
  }
}