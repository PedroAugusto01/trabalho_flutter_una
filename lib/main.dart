import 'package:flutter/material.dart';
import 'package:flutter_app/userscreen/userscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login/mainlogo.dart';
import 'login/signin.dart';
import 'login/signup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool _isLogin = false;
  int _userId = 0;

  _checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = (prefs.get('isLogin') ?? false);
    int userId = (prefs.get('userId') ?? 0);

    setState(() {
    _isLogin = isLogin;
    _userId = userId;
    });

    print('prefs isLogin: $isLogin');
    print('prefs userId: $userId');
  }

  @override
  void initState() {
    _checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !_isLogin ? _signInWidget() : UserScreen(_userId);
  }

  Widget _signInWidget() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(
                'https://v8floorcoatings.com/wp-content/uploads/2018/12/Oxford-Gray.jpg'),
                fit: BoxFit.fill)
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              mainLogo(),
              SignIn(),
              SignUp()
            ],
          ),
        ),
      ),
    );
  }
}
