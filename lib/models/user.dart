import 'package:flutter/material.dart';

import 'address.dart';
import 'order.dart';

class UserMimolda with ChangeNotifier {
  String _name, _cpf, _phone, _email;
  List<Address> _addresses;
  List<String> _wishlist;
  List<MimoldaOrder> _orders, _purchases;

  UserMimolda(
      String name,
      String cpf,
      String phone,
      String email,
      List<Address> addresses,
      List<String> wishlist,
      List<MimoldaOrder> orders,
      List<MimoldaOrder> purchases)
      : _name = name,
        _cpf = cpf,
        _phone = phone,
        _email = email,
        _addresses = addresses,
        _wishlist = wishlist,
        _orders = orders,
        _purchases = purchases;

  UserMimolda.fromJson(
      Map<String, dynamic> json,
      List<Address> addresses,
      List<String> wishlist,
      List<MimoldaOrder> orders,
      List<MimoldaOrder> purchases)
      : _name = json['name'],
        _cpf = json['cpf'],
        _phone = json['phone'],
        _email = json['email'],
        _addresses = addresses,
        _wishlist = wishlist,
        _orders = orders,
        _purchases = purchases;

  String get name => _name;

  String get cpf => _cpf;

  String get phone => _phone;

  String get email => _email;

  List<Address> get addresses => _addresses;

  List<String> get wishlist => _wishlist;

  List<MimoldaOrder> get orders => _orders;

  List<MimoldaOrder> get purchases => _purchases;

  set name(String name) {
    _name = name;
    notifyListeners();
  }

  set cpf(String cpf) {
    _cpf = cpf;
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

  set orders(List<MimoldaOrder> orders) {
    _orders = orders;
    notifyListeners();
  }

  set purchases(List<MimoldaOrder> purchases) {
    _purchases = purchases;
    notifyListeners();
  }
}
