import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mimolda/models/full_store.dart';
import 'package:mimolda/widgets/buttons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../const/constants.dart';
import '../widgets/message_dialog.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  late final MaskTextInputFormatter maskFormatter;
  late final GlobalKey<FormState> formKey;
  late final TextEditingController nameController, phoneController;
  var loading = false;

  @override
  void initState() {
    final fullStore = context.read<FullStoreNotifier>();
    maskFormatter = MaskTextInputFormatter(
        initialText: fullStore.user?.phone,
        mask: '(##) #####-####',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController(text: fullStore.user?.name);
    phoneController = TextEditingController(
        text: maskFormatter.maskText(fullStore.user?.phone ?? ''));
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
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            title: const MyGoogleText(
              text: 'Alterar dados',
              fontColor: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 20,
            ),
          ),
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(30),
                  width: context.width(),
                  height:
                      context.height() - (AppBar().preferredSize.height + 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Form(
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
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                    controller: phoneController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Telefone',
                                      hintText: 'Digite seu telefone',
                                    ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [maskFormatter],
                                    validator: (value) {
                                      if (value == null ||
                                          !RegExp(r"^[0-9]{11}$").hasMatch(
                                              maskFormatter
                                                  .getUnmaskedText())) {
                                        return 'Telefone inválido';
                                      }
                                      return null;
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Button1(
                        loading: loading,
                          buttonText: 'Alterar dados',
                          buttonColor: primaryColor,
                          onPressFunction: () async {
                            setState(() {
                              loading = true;
                            });
                            if (formKey.currentState?.validate() ?? false) {
                              final data = {
                                'name': nameController.text.trim(),
                                'phone': maskFormatter.getUnmaskedText(),
                              };
                              final user = FirebaseAuth.instance.currentUser;
                              if (user != null) {
                                final uid = user.uid;
                                final firestore = FirebaseFirestore.instance;
                                await firestore
                                    .collection('users')
                                    .doc(uid)
                                    .update(data);
                                if (context.mounted) {
                                  final fullStore =
                                      context.read<FullStoreNotifier>();
                                  await fullStore.reloadUser();
                                }

                                if (context.mounted) {
                                  await messageDialog(context, 'Alterar dados',
                                      'Dados alterados com sucesso');
                                }
                                if (context.mounted) {
                                  finish(context);
                                }
                              }
                            }
                            setState(() {
                              loading = false;
                            });
                          }),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
