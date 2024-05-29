import 'package:flutter/material.dart';
import 'package:mimolda/const/constants.dart';
import 'package:mimolda/screens/auth_screen/forgot_pass_screen.dart';
import 'package:mimolda/screens/auth_screen/sign_up.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../widgets/buttons.dart';
import '../home_screens/home.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
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
            // const Spacer(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(30),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      // color: Colors.white,
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
                            hintText: 'Digite seu email',
                          ),
                        ),
                        const SizedBox(height: 20),
                        AppTextField(
                          controller: TextEditingController(), // Optional
                          textFieldType: TextFieldType.PASSWORD,
                          decoration: const InputDecoration(
                              labelText: 'Senha', border: OutlineInputBorder()),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Row(
                            //   children: [
                            //     Checkbox(
                            //       activeColor: secondaryColor1,
                            //       checkColor: black,
                            //       //fillColor: MaterialStateProperty.resolveWith(Colors.red),
                            //       value: isChecked,
                            //       onChanged: (bool? value) {
                            //         setState(() {
                            //           isChecked = value!;
                            //         });
                            //       },
                            //     ),
                            //     const MyGoogleText(
                            //       text: 'Remember me',
                            //       fontColor: textColors,
                            //       fontSize: 14,
                            //       fontWeight: FontWeight.normal,
                            //     ),
                            //   ],
                            // ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                const ForgotPassScreen().launch(context);
                              },
                              child: const MyGoogleText(
                                text: 'Esqueci minha senha',
                                fontColor: textColors,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Button1(
                          buttonText: 'Entrar',
                          buttonColor: primaryColor,
                          onPressFunction: () {
                            const Home().launch(context, isNewTask: true);
                          },
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            const SignUp().launch(context);
                          },
                          child: const MyGoogleText(
                            text: 'Criar conta',
                            fontSize: 16,
                            fontColor: secondaryColor1,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // const SizedBox(height: 25),
                        // const SocialMediaButtons(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
