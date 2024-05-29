import 'package:flutter/material.dart';
import 'package:mimolda/const/constants.dart';
import 'package:mimolda/screens/auth_screen/forgot_pass_screen.dart';
import 'package:mimolda/screens/auth_screen/sign_up.dart';
import 'package:mimolda/welcome_screen.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../widgets/buttons.dart';
import '../../widgets/social_media_button.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
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
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
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
              children: <Widget>[
                const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter Your Email',
                  ),
                ),
                const SizedBox(height: 20),
                AppTextField(
                  controller: TextEditingController(), // Optional
                  textFieldType: TextFieldType.PASSWORD,
                  decoration: const InputDecoration(
                      labelText: 'Password', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          activeColor: secondaryColor1,
                          checkColor: black,
                          //fillColor: MaterialStateProperty.resolveWith(Colors.red),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        const MyGoogleText(
                          text: 'Remember me',
                          fontColor: textColors,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        const ForgotPassScreen().launch(context);
                      },
                      child: const MyGoogleText(
                        text: 'Forgot Password',
                        fontColor: textColors,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Button1(
                  buttonText: 'Sign In',
                  buttonColor: primaryColor,
                  onPressFunction: () {
                    const WelComeScreen().launch(context);
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const MyGoogleText(
                      fontSize: 16,
                      fontColor: textColors,
                      text: 'Not a member?',
                      fontWeight: FontWeight.w500,
                    ),
                    TextButton(
                      onPressed: () {
                        const SignUp().launch(context);
                      },
                      child: const MyGoogleText(
                        text: 'Join now',
                        fontSize: 16,
                        fontColor: secondaryColor1,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 25),
                const SocialMediaButtons(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
