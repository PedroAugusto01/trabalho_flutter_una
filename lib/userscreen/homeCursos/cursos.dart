import 'package:flutter/material.dart';
import 'package:flutter_app/entities/cursePrincipal.dart';
import 'addCursoPrincipal.dart';
import '../telaCursos/listacursos.dart';
import 'package:flutter_app/database/curseprincipalmanager.dart';

class Curso extends StatefulWidget {
  State<StatefulWidget> createState() => _Curso();
}

class _Curso extends State<Curso> with WidgetsBindingObserver {
  final _cursePrincipalManager = CursePrincipalManager();
  List<CursePrincipalDb> lista = [];

  CursePrincipalDb cursePrincipalDb;

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: lista.map((item) {
                return Container(
                  margin: const EdgeInsets.all(3.0),
                  padding: const EdgeInsets.all(4.0),
                  child: ListTile(
                    leading: Image.network(item.url),
                    title: Text(item.nome),
                    subtitle: Text(item.avaliacao),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ListaCursos(item)),
                      );
                    },
                  ),
                );
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
            MaterialPageRoute(builder: (context) => AddCurso()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple[900],
      ),
    );
  }

  Future<List<CursePrincipalDb>> _query() async {
    final allRows = await _cursePrincipalManager.getAllCursesPrincipal();
    return allRows;
  }
}
