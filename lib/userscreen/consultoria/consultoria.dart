import 'package:flutter/material.dart';
import 'package:flutter_app/database/consultantmanager.dart';
import 'package:flutter_app/entities/consultant.dart';
import 'consultores.dart';
import 'addConsultor.dart';

class Consultoria extends StatefulWidget {
  State<StatefulWidget> createState() => _Consultoria();
}

class _Consultoria extends State<Consultoria> with WidgetsBindingObserver {
  final _consultantManager = ConsultantManager();
  List<Consultant> lista = [];
  Consultant consultant;

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
                    title: Text(item.name),
                    subtitle: Text(item.competencia),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Consultores(item)),
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
            MaterialPageRoute(builder: (context) => AddConsultor(lista.length)),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple[900],
      ),
    );
  }

  Future<List<Consultant>> _query() async {
    final allRows = await _consultantManager.getAllConsultantList();
    return allRows;
  }
}
