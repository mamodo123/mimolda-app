import 'package:flutter/material.dart';

class UserMimolda with ChangeNotifier {
  String _name, _phone, _email;

  UserMimolda(String name, String phone, String email)
      : _name = name,
        _phone = phone,
        _email = email;

  UserMimolda.fromJson(Map<String, dynamic> json)
      : _name = json['name'],
        _phone = json['phone'],
        _email = json['email'];

  String get name => _name;

  String get phone => _phone;

  String get email => _email;

  set name(String name) {
    _name = name;
    notifyListeners();
  }

  set phone(String phone) {
    _phone = phone;
    notifyListeners();
  }

  set email(String email) {
    _email = email;
    notifyListeners();
  }
}
