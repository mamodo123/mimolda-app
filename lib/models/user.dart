import 'package:flutter/material.dart';

import 'address.dart';

class UserMimolda with ChangeNotifier {
  String _name, _phone, _email;
  List<Address> _addresses;
  List<String> _wishlist;

  UserMimolda(String name, String phone, String email, List<Address> addresses,
      List<String> wishlist)
      : _name = name,
        _phone = phone,
        _email = email,
        _addresses = addresses,
        _wishlist = wishlist;

  UserMimolda.fromJson(
      Map<String, dynamic> json, List<Address> addresses, List<String> wishlist)
      : _name = json['name'],
        _phone = json['phone'],
        _email = json['email'],
        _addresses = addresses,
        _wishlist = wishlist;

  String get name => _name;

  String get phone => _phone;

  String get email => _email;

  List<Address> get addresses => _addresses;

  List<String> get wishlist => _wishlist;

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

  set addresses(List<Address> addresses) {
    _addresses = addresses;
    notifyListeners();
  }

  set wishlist(List<String> wishlist) {
    _wishlist = wishlist;
    notifyListeners();
  }
}
