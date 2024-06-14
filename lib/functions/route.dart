import 'package:firebase_auth/firebase_auth.dart';

Future<String> getRoute() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final user = auth.currentUser;
  if (user != null) {
    if (user.emailVerified) {
      return '/home';
    } else {
      return '/login/signup/verify-email';
    }
  } else {
    return '/home';
  }
}
