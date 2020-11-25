import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class Sair extends StatefulWidget {
  State<StatefulWidget> createState() => _Sair();
}

class _Sair extends State<Sair> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              ("Obrigado por usar nosso app!"),
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              ("Se realmente quiser sair, \n "
                  "clique no botão a baixo"),
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Center (
            child: RaisedButton(
              onPressed: () {
                showDialog(context: context,
                  builder: (context) {
                    return AlertDialog(
                        title: Text("Confirmação"),
                        content: Text("Deseja realmente sair? Se sim basta precionar SAIR, caso contrário basta voltar!"),
                        actions: <Widget>[
                          FlatButton(
                              child: Text("SAIR"),
                              onPressed: () {
                                Navigator.pop(context);
                                _delete();
                              }
                          )
                        ]
                    );
                  },
                );

              },
              child: Text('Sair'),
            ),
          ),
        ],
      ),
    );
  }

  void _delete() async {
    // Assuming that the number of rows is the id for the last row.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
  }
}