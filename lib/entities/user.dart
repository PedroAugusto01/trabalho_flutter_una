import 'package:flutter_app/database/usermanager.dart';

class User {
  final int id;
  final String name;
  final String gender;
  final String email;
  final String password;
  final int age;

  User( this.id,
      this.name,
      this.gender,
      this.email,
      this.password,
      this.age );

  Map<String, dynamic> toMap() {
    return {
      UserManager.columnName: name,
      UserManager.columnAge: age,
      UserManager.columnGender: gender,
      UserManager.columnEmail: email,
      UserManager.columnPassword: password,
    };
  }
}
