import 'package:flutter/material.dart';
import 'package:flutter_app/signup/signupform.dart';
import 'package:flutter_app/signup/signup.dart';
import 'package:flutter_app/signup/signupintroduce.dart';
import 'package:flutter_app/database/databasemanager.dart';
import 'package:flutter_app/database/usermanager.dart';
import 'package:flutter_app/entities/user.dart';
import 'package:flutter_app/userscreen/userscreen.dart';

class SignUpWithMail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpWithMail();
}

class _SignUpWithMail extends State<SignUpWithMail> {

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _nameTextController = TextEditingController();
  final _introduceTextController = TextEditingController();
  final userManager = UserManager();

  Map<String, dynamic> _userDataMap = Map<String, dynamic>();

  PageController _pageController = PageController();

  String _nextText = 'Next';
  Color _nextColor = Colors.green[800];

  _updateMyTitle(List<dynamic> data) {
    setState(() {
      _userDataMap[data[0]] = data[1];
    });
  }

  // reference to our single class that manages the database
  final dbHelper = DatabaseManager.instance;

  @override
  void initState() {
    _query();
    _userDataMap['gender'] = 'Man';
    _userDataMap['term'] = false;
    _userDataMap['age'] = 25;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(
                  'https://v8floorcoatings.com/wp-content/uploads/2018/12/Oxford-Gray.jpg'),
                  fit: BoxFit.fill)
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(4.0),
                    padding: const EdgeInsets.only(top: 10, bottom: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey[400]),
                      borderRadius: BorderRadius.all(
                          Radius.circular(25.0)
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0, top: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Create Account',
                              style: TextStyle(fontSize: 34,
                                  fontWeight: FontWeight.bold),),
                          ),
                        ),
                        Container(
                          width: 400,
                          height: 500,
                          child: PageView(
                            onPageChanged: (int page) {
                              print('the pageView page is $page');
                              if (page == 2) {
                                setState(() {
                                  _nextText = 'Submit';
                                  _nextColor = Colors.blue[900];
                                });
                              } else {
                                setState(() {
                                  _nextText = 'Next';
                                  _nextColor = Colors.green[800];
                                });
                              }
                            },
                            controller: _pageController,
                            children: <Widget>[
                              SignUpForm(
                                  _emailTextController, _passwordTextController,
                                  _nameTextController, _updateMyTitle),
                              SignUpImages(_updateMyTitle),
                              SignUpIntroduce(_introduceTextController)
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(12.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Cancel',
                                        style: TextStyle(fontSize: 28),
                                      ),
                                    ],
                                  ),
                                  textColor: Colors.black,
                                  color: Colors.white,
                                  padding: EdgeInsets.all(10),
                                  onPressed: () {
                                    print('email: ${_emailTextController.text}');
                                    print('password: ${_passwordTextController
                                        .text}');
                                    print('name: ${_nameTextController.text}');
                                    print('intro: ${_introduceTextController
                                        .text}');

                                    print('_userDataMap $_userDataMap');
                                    Navigator.pop(context);
//                              _query();
                                  },
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(12.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        _nextText,
                                        style: TextStyle(fontSize: 28),
                                      ),
                                    ],
                                  ),
                                  textColor: Colors.white,
                                  color: _nextColor,
                                  padding: EdgeInsets.all(10),
                                  onPressed: () {
                                    if (_pageController.page.toInt() == 2) {
                                      print('last page');
                                      _signUpNewUser();
                                    } else {
                                      _pageController.animateToPage(
                                          _pageController.page.toInt() + 1,
                                          duration: Duration(milliseconds: 200),
                                          curve: Curves.easeIn);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }

  // Button onPressed methods

  void _signUpNewUser() async {
    // row to insert
    final newUser = new User(
        0,
        _nameTextController.text,
        _userDataMap['gender'],
        _emailTextController.text,
        _passwordTextController.text,
        _userDataMap['age'],
        _userDataMap['image0'],
        _userDataMap['image1'],
        _userDataMap['image2'],
        _userDataMap['image3'],
        _introduceTextController.text
    );

    final id = await userManager.insertNewUser(newUser);
    print('inserted row id: $id');
    if (id != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserScreen(id),
          // Pass the arguments as part of the RouteSettings. The
          // DetailScreen reads the arguments from these settings.
          settings: RouteSettings(
              arguments: id
          ),
        ),
      );
    }
  }

  void _query() async {
    final allUsers = await userManager.getUsers();
    print('query all users:');
    allUsers.forEach((selectedUser) {
      print(selectedUser);
      print('selected user age is ${selectedUser.age}');
      return null;
    });
  }
}
