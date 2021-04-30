import 'package:flutter/cupertino.dart';

class UserData {
  String email;
  String lastName;
  String firstName;

  UserData({
    @required this.email,
    @required this.lastName,
    @required this.firstName,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'lastName': lastName,
      'firstName': firstName,
    };
  }
}
