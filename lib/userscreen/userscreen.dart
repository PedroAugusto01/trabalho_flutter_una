import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/database/usermanager.dart';
import 'package:flutter_app/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './avaliacao.dart';
import 'consultoria/consultoria.dart';
import 'homeCursos/cursos.dart';
import './sair.dart';

class UserScreen extends StatefulWidget {
  final int id;

  UserScreen(this.id);

  @override
  State<StatefulWidget> createState() => _UserScreen(id);
}

class _UserScreen extends State<UserScreen> with WidgetsBindingObserver {
  final int id;
  final _userManager = UserManager();
  User _userData;
  bool _fetchingData = true;
  _UserScreen(this.id);

  String nomeTela;
  int indicie = 0;



  @override
  void initState() {
    _query();
    super.initState();
  }

  int indice = 0;
  static List<Widget> telas = <Widget>[
    Curso(),
    Consultoria(),
    Avaliacao(),
    Sair()
  ];

  void selecionar(int indice) {
    setState(
      () {
        this.indice = indice;
        if (this.indice == 0) {
          nomeTela = "Cursos";
        } else if (this.indice == 1) {
          nomeTela = "Consultoria";
        } else if(this.indice == 2) {
          nomeTela = "Avaliação";
        } else {
          nomeTela = "Sair";
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(nomeTela);
    return WillPopScope(
      onWillPop: () async {
        exit(0);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(nomeTela ?? 'Cursos'),
          backgroundColor: Colors.red,
          automaticallyImplyLeading: true,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Colors.red,
              icon: Icon(Icons.home),
              label: 'Cursos',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.red,
              icon: Icon(Icons.business),
              label: 'Consultoria',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.red,
              icon: Icon(Icons.warning_rounded),
              label: 'Avaliação',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.red,
              icon: Icon(Icons.exit_to_app),
              label: 'Sair',
            ),
          ],
          currentIndex: this.indice,
          selectedItemColor: Colors.red[0],
          onTap: selecionar,
        ),
        body: _fetchingData
            ? CircularProgressIndicator()
            : telas.elementAt(this.indice),
      ),
    );
  }

  void _query() async {
    final user = await _userManager.getUserById(id);

    setState(() {
      _userData = user;
      _fetchingData = false;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', user != null);
    if (user != null) await prefs.setInt('userId', user.id);
  }
}
