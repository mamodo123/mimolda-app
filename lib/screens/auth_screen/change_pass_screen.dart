import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mimolda/const/constants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../widgets/buttons.dart';
import '../../widgets/message_dialog.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({super.key});

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController oldPassController,
      passController,
      confirmPassController;

  var loading = false;
  String? error;
  String? errorNewPass;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    oldPassController = TextEditingController();
    passController = TextEditingController();
    confirmPassController = TextEditingController();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 40, top: 30),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyGoogleText(
                        fontSize: 26,
                        fontColor: Colors.black,
                        text: 'Alterar Senha',
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 15),
                      MyGoogleText(
                        fontSize: 16,
                        fontColor: textColors,
                        text:
                            'A senha deve ter: letra maiúscula, letra minúscula, número, caractere especial e 8+ dígitos.',
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  ),
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
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      AppTextField(
                          controller: oldPassController,
                          textFieldType: TextFieldType.PASSWORD,
                          decoration: InputDecoration(
                              errorText: error,
                              errorMaxLines: 3,
                              labelText: 'Senha atual',
                              border: const OutlineInputBorder()),
                          validator: (value) => null),
                      const SizedBox(height: 15),
                      AppTextField(
                          controller: passController,
                          textFieldType: TextFieldType.PASSWORD,
                          decoration: InputDecoration(
                              errorText: errorNewPass,
                              errorMaxLines: 3,
                              labelText: 'Nova senha',
                              border: const OutlineInputBorder()),
                          validator: (value) {
                            if (value == null ||
                                !RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$")
                                    .hasMatch(value.trim())) {
                              return 'A senha deve ter: letra maiúscula, letra minúscula, número, caractere especial e 8+ dígitos.';
                            }
                            return null;
                          }),
                      const SizedBox(height: 15),
                      AppTextField(
                          controller: confirmPassController,
                          textFieldType: TextFieldType.PASSWORD,
                          decoration: const InputDecoration(
                              errorMaxLines: 3,
                              labelText: 'Confirme a senha',
                              border: OutlineInputBorder()),
                          validator: (value) {
                            if (value?.trim() != passController.text.trim()) {
                              return 'As senhas não coincidem';
                            }
                            return null;
                          }),
                      const SizedBox(height: 30),
                      Button1(
                          loading: loading,
                          buttonText: 'Alterar',
                          buttonColor: primaryColor,
                          onPressFunction: () async {
                            setState(() {
                              loading = true;
                              error = null;
                              errorNewPass = null;
                            });
                            if (formKey.currentState?.validate() ?? false) {
                              final user = FirebaseAuth.instance.currentUser;
                              if (user != null && user.email != null) {
                                final cred = EmailAuthProvider.credential(
                                    email: user.email!,
                                    password: oldPassController.text.trim());

                                try {
                                  await user.reauthenticateWithCredential(cred);
                                  try {
                                    await user.updatePassword(
                                        passController.text.trim());
                                    if (context.mounted) {
                                      await messageDialog(
                                          context,
                                          'Alterar senha',
                                          'Senha alterada com sucesso');
                                    }
                                    if (context.mounted) {
                                      finish(context);
                                    }
                                  } catch (e) {
                                    if (e is FirebaseAuthException) {
                                      setState(() {
                                        errorNewPass = 'Tente uma nova senha';
                                      });
                                    }
                                  }
                                } catch (e) {
                                  if (e is FirebaseAuthException) {
                                    setState(() {
                                      error = 'Senha incorreta';
                                    });
                                  }
                                }
                              }
                            }
                            setState(() {
                              loading = false;
                            });
                          }),
                      const SizedBox(height: 200),
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
