import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mimolda/const/constants.dart';
import 'package:mimolda/models/full_store.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:validadores/Validador.dart';

import '../../widgets/buttons.dart';

class SignUp extends StatefulWidget {
  final String origin;

  const SignUp({super.key, required this.origin});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isChecked = false, loading = false;

  late final MaskTextInputFormatter phoneMaskFormatter, cpfMaskFormatter;
  late final GlobalKey<FormState> formKey;
  late final TextEditingController nameController,
      cpfController,
      phoneController,
      emailController,
      passController;

  String? emailError;

  @override
  void initState() {
    phoneMaskFormatter = MaskTextInputFormatter(
        mask: '(##) #####-####',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
    cpfMaskFormatter = MaskTextInputFormatter(
        mask: '###.###.###-##',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    cpfController = TextEditingController();
    phoneController = TextEditingController();
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        key: formKey,
                        child: Container(
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
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Nome completo',
                                    hintText: 'Digite seu nome completo',
                                  ),
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value == null ||
                                        value.trim().split(' ').length <= 1) {
                                      return 'Nome inválido';
                                    }
                                    return null;
                                  }),
                              const SizedBox(height: 20),
                              TextFormField(
                                  controller: cpfController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'CPF',
                                    hintText: 'Digite seu cpf',
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [cpfMaskFormatter],
                                  validator: (value) {
                                    if (Validador()
                                            .add(Validar.CPF,
                                                msg: 'CPF Inválido')
                                            .minLength(11)
                                            .maxLength(11)
                                            .valido(value,
                                                clearNoNumber: true) !=
                                        null) {
                                      return 'CPF Inválido';
                                    }
                                    return null;
                                  }),
                              const SizedBox(height: 20),
                              TextFormField(
                                  controller: phoneController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Telefone',
                                    hintText: 'Digite seu telefone',
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [phoneMaskFormatter],
                                  validator: (value) {
                                    if (value == null ||
                                        !RegExp(r"^[0-9]{11}$").hasMatch(
                                            phoneMaskFormatter
                                                .getUnmaskedText())) {
                                      return 'Telefone inválido';
                                    }
                                    return null;
                                  }),
                              const SizedBox(height: 20),
                              TextFormField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Email',
                                    hintText: 'Digite seu email',
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null ||
                                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(value.trim())) {
                                      return 'Email inválido';
                                    } else if (emailError != null) {
                                      return emailError;
                                    }
                                    return null;
                                  }),
                              const SizedBox(height: 20),
                              AppTextField(
                                  controller: passController,
                                  textFieldType: TextFieldType.PASSWORD,
                                  decoration: const InputDecoration(
                                      errorMaxLines: 3,
                                      labelText: 'Senha',
                                      border: OutlineInputBorder()),
                                  validator: (value) {
                                    if (value == null ||
                                        !RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$")
                                            .hasMatch(value.trim())) {
                                      return 'A senha deve ter: letra maiúscula, letra minúscula, número, caractere especial e 8+ dígitos.';
                                    }
                                    return null;
                                  }),
                              const SizedBox(height: 20),
                              Button1(
                                  loading: loading,
                                  buttonText: 'Registrar',
                                  buttonColor: primaryColor,
                                  onPressFunction: () async {
                                    setState(() {
                                      loading = true;
                                      emailError = null;
                                    });
                                    // return const Home().launch(context);
                                    if (formKey.currentState?.validate() ??
                                        false) {
                                      final name = nameController.text.trim();
                                      final cpf =
                                          cpfMaskFormatter.getUnmaskedText();
                                      final phone =
                                          phoneMaskFormatter.getUnmaskedText();
                                      final email = emailController.text.trim();
                                      final pass = passController.text.trim();
                                      UserCredential? userCredential;
                                      try {
                                        userCredential = await FirebaseAuth
                                            .instance
                                            .createUserWithEmailAndPassword(
                                                email: email, password: pass);
                                      } catch (signUpError) {
                                        if (signUpError
                                            is FirebaseAuthException) {
                                          switch (signUpError.code) {
                                            case 'email-already-in-use':
                                              setState(() {
                                                emailError =
                                                    'Email já cadastrado';
                                              });
                                              break;
                                            case 'invalid-email':
                                              setState(() {
                                                emailError = 'Email inválido';
                                              });
                                              break;
                                            case 'weak-password':
                                              setState(() {
                                                emailError =
                                                    'Senha muito fraca';
                                              });
                                              break;
                                          }
                                          formKey.currentState?.validate();
                                          setState(() {
                                            loading = false;
                                          });
                                          return;
                                        }
                                      }
                                      if (userCredential != null) {
                                        final user = userCredential.user;
                                        if (user != null) {
                                          await user.sendEmailVerification();
                                          final uid = user.uid;
                                          final firestore =
                                              FirebaseFirestore.instance;
                                          await firestore
                                              .collection('users')
                                              .doc(uid)
                                              .set({
                                            'phone': phone,
                                            'email': email,
                                            'name': name,
                                            'cpf': cpf,
                                          });
                                          if (context.mounted) {
                                            final fullStore = context
                                                .read<FullStoreNotifier>();
                                            await fullStore.reloadUser(
                                                reloadOrders: true);
                                          }
                                          if (context.mounted) {
                                            Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                                    '/login/signup/verify-email',
                                                    (route) =>
                                                        route.settings.name ==
                                                        (widget.origin ==
                                                                '/home'
                                                            ? '/home'
                                                            : '/login'),
                                                    arguments: widget.origin);
                                          }
                                        }
                                      }
                                      if (context.mounted) {
                                        setState(() {
                                          loading = false;
                                        });
                                      }
                                    } else {
                                      setState(() {
                                        loading = false;
                                      });
                                    }
                                  }),
                              // const SizedBox(height: 10),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     const MyGoogleText(
                              //       fontSize: 16,
                              //       fontColor: textColors,
                              //       text: 'Already have an account?',
                              //       fontWeight: FontWeight.w500,
                              //     ),
                              //     TextButton(
                              //       onPressed: () {
                              //         const LogInScreen().launch(
                              //           context,
                              //           //pageRouteAnimation: PageRouteAnimation.Fade,
                              //         );
                              //       },
                              //       child: const MyGoogleText(
                              //         text: 'Sign In',
                              //         fontSize: 16,
                              //         fontColor: secondaryColor1,
                              //         fontWeight: FontWeight.w500,
                              //       ),
                              //     )
                              //   ],
                              // ),
                              // const SizedBox(height: 20),
                              // const SocialMediaButtons(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
