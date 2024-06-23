import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mimolda/screens/auth_screen/verify_email.dart';
import 'package:mimolda/screens/home_screens/home.dart';
import 'package:mimolda/screens/splash_screen/splash_screen_one.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'models/full_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          FullStoreNotifier(fullStore: const FullStore(products: [])),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) {
          final widget = getRoute(settings);
          if (widget == null) {
            return null;
          }
          return MaterialPageRoute(builder: (_) => widget, settings: settings);
        },
        initialRoute: '/',
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      ),
    );
  }
}

Widget? getRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return const SplashScreenOne();
    case '/home':
      return const Home();
    case '/login/signup/verify-email':
      return VerifyEmail(returnTo: settings.arguments as String?);
  }
  return null;
}
