import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/home_screens/home.dart';
import '../screens/auth_screen/verify_email.dart';

Future<Widget> getRoute() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final user = auth.currentUser;
  if (user != null) {
    if (user.emailVerified) {
      return const Home();
    } else {
      return const VerifyEmail();
    }
  } else {
    return const Home();
  }
}
