import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mimolda/screens/auth_screen/log_in_screen.dart';
import 'package:mimolda/screens/auth_screen/sign_up.dart';
import 'package:mimolda/welcome_screen.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../const/constants.dart';
import '../../widgets/buttons.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              const WelComeScreen().launch(context, isNewTask: true);
            },
            child: Text(
              'Skip',
              style: kTextStyle,
            ),
          ),
        ],
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Image(image: AssetImage('images/maanstore_logo_1.png')),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(30),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Start Your Journey with',
                  style: GoogleFonts.dmSans(
                    textStyle: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Maanstore',
                  style: GoogleFonts.dmSans(
                    textStyle: const TextStyle(
                      color: secondaryColor1,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Pretium, ipsum pretium aliquet mollis cond imentum magna accumsan. Odio elit tellus id diam sit. Massa',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    textStyle: const TextStyle(
                      color: textColors,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Button1(
                  buttonColor: primaryColor,
                  buttonText: 'Register',
                  onPressFunction: () {
                    const SignUp().launch(
                      context,
                      //pageRouteAnimation: PageRouteAnimation.Fade,
                    );
                  },
                ),
                const SizedBox(height: 15),
                ButtonType2(
                  buttonColor: primaryColor,
                  buttonText: 'Sign In',
                  onPressFunction: () {
                    const LogInScreen().launch(
                      context,
                      //pageRouteAnimation: PageRouteAnimation.Fade,
                    );
                  },
                ),
                const SizedBox(height: 70),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
