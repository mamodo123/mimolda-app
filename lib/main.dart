import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mimolda/models/order.dart';
import 'package:mimolda/screens/auth_screen/log_in_screen.dart';
import 'package:mimolda/screens/auth_screen/sign_up.dart';
import 'package:mimolda/screens/auth_screen/verify_email.dart';
import 'package:mimolda/screens/cart_probation_screen.dart';
import 'package:mimolda/screens/check_out_screen.dart';
import 'package:mimolda/screens/confirm_probation_return.dart';
import 'package:mimolda/screens/home_screens/home.dart';
import 'package:mimolda/screens/probation_tutorial.dart';
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
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR'),
        ],
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
    case '/login':
      final origin = settings.arguments as String;
      return LogInScreen(origin: origin);
    case '/login/signup':
      final origin = settings.arguments as String;
      return SignUp(origin: origin);
    case '/login/signup/verify-email':
      final origin = settings.arguments as String?;
      return VerifyEmail(origin: origin);
    case '/checkout':
      return const CheckOutScreen();
    case '/cart_probation':
      final order = settings.arguments as MimoldaOrder;
      return CartProbationScreen(order: order);
    case '/confirm_probation_return':
      final probationPurchase = settings.arguments as ProbationPurchase;
      return ConfirmProbationReturn(probationPurchase: probationPurchase);
    case '/probation-tutorial':
      return const ProbationTutorial();
  }
  return null;
}
