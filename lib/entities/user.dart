import 'package:flutter_app/database/usermanager.dart';

class User {
  final int id;
  final String name;
  final String gender;
  final String email;
  final String password;
  final int age;
  String imageZero = "";
  String imageOne = "";
  String imageTwo = "";
  String imageThree = "";
  String imageIntroduction = "";

  User( this.id,
      this.name,
      this.gender,
      this.email,
      this.password,
      this.age,
      this.imageZero,
      this.imageOne,
      this.imageTwo,
      this.imageThree,
      this.imageIntroduction );

  Map<String, dynamic> toMap() {
    return {
      UserManager.columnName: name,
      UserManager.columnAge: age,
      UserManager.columnGender: gender,
      UserManager.columnEmail: email,
      UserManager.columnPassword: password,
      UserManager.columnImageOne: imageOne,
      UserManager.columnImageTwo: imageTwo,
      UserManager.columnImageThree: imageThree,
      UserManager.columnImageIntroduction: imageIntroduction
    };
  }
}
