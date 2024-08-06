import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mimolda/const/constants.dart';
import 'package:mimolda/models/full_store.dart';
import 'package:mimolda/screens/auth_screen/forgot_pass_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../widgets/buttons.dart';

class LogInScreen extends StatefulWidget {
  final String origin;

  const LogInScreen({super.key, required this.origin});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool isChecked = false, loading = false;
  String? error;
  late final TextEditingController emailController, passController;

  @override
  void initState() {
    emailController = TextEditingController();
    passController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: loading,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: ModalRoute.of(context)?.settings.name == '/home'
                ? null
                : GestureDetector(
                    onTap: () {
                      finish(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
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
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Email',
                              hintText: 'Digite seu email',
                              errorText: error,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (text) {
                              return error;
                            },
                          ),
                          const SizedBox(height: 20),
                          AppTextField(
                            controller: passController, // Optional
                            textFieldType: TextFieldType.PASSWORD,
                            decoration: const InputDecoration(
                                labelText: 'Senha',
                                border: OutlineInputBorder()),
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
                            loading: loading,
                            buttonText: 'Entrar',
                            buttonColor: primaryColor,
                            onPressFunction: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              // const Home().launch(context, isNewTask: true);
                              setState(() {
                                loading = true;
                                error = null;
                              });
                              final email = emailController.text.trim();
                              final pass = passController.text.trim();
                              try {
                                final credential = await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: email, password: pass);
                                final user = credential.user;
                                if (user != null) {
                                  if (context.mounted) {
                                    final fullStore =
                                        context.read<FullStoreNotifier>();
                                    await fullStore.reloadUser(
                                        reloadOrders: true,
                                        reloadPurchases: true);
                                  }
                                  if (user.emailVerified) {
                                    switch (widget.origin) {
                                      case '/home':
                                        Navigator.of(context).popUntil(
                                            (route) =>
                                                route.settings.name == '/home');
                                        break;
                                      case '/cart':
                                        Navigator.of(context)
                                            .pushReplacementNamed('/checkout');
                                        break;
                                    }
                                  } else {
                                    if (context.mounted) {
                                      Navigator.of(context).pushNamed(
                                          '/login/signup/verify-email',
                                          arguments: widget.origin);
                                    }
                                  }
                                }
                              } catch (exception) {
                                if (exception is FirebaseAuthException) {
                                  setState(() {
                                    error = 'Email ou senha incorretos';
                                  });
                                  // switch (exception.code) {
                                  //   case 'invalid-credential':
                                  //     break;
                                  // }
                                }
                              }
                              setState(() {
                                loading = false;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/login/signup',
                                  arguments: widget.origin);
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
      ),
    );
  }
}
