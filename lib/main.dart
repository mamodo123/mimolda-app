import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreenOne(),
      ),
    );
  }
}
