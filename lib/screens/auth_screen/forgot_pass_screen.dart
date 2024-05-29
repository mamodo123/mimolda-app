import 'package:flutter/material.dart';
import 'package:mimolda/const/constants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../widgets/buttons.dart';
import 'otp_auth_screen.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            finish(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                border: Border.all(
                  width: 1,
                  color: textColors,
                ),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding:  EdgeInsets.only(left: 40, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                MyGoogleText(
                  fontSize: 26,
                  fontColor: Colors.black,
                  text: 'Esqueci minha senha',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 15),
                MyGoogleText(
                  fontSize: 16,
                  fontColor: textColors,
                  text: 'Digite seu email abaixo para recuperar sua senha',
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ),
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
              children: <Widget>[
                const SizedBox(height: 10),
                const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Digite seu email',
                  ),
                ),
                const SizedBox(height: 30),
                Button1(
                    buttonText: 'Recuperar minha senha',
                    buttonColor: primaryColor,
                    onPressFunction: () {
                      const OtpAuthScreen().launch(context);
                    }),
                const SizedBox(height: 300),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
