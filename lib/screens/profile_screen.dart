import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:mimolda/models/full_store.dart';
import 'package:mimolda/screens/auth_screen/change_pass_screen.dart';
import 'package:mimolda/screens/auth_screen/log_in_screen.dart';
import 'package:mimolda/screens/shipping_address.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../const/constants.dart';
import 'my_profile_screen.dart';
import 'orders_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final fullStore = context.watch<FullStoreNotifier>();
    final user = fullStore.user;
    if (user == null) {
      return const LogInScreen(origin: '/home');
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: const MyGoogleText(
            text: 'Perfil',
            fontColor: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 20,
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 30, top: 30, bottom: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyGoogleText(
                              text: user.name,
                              fontSize: 24,
                              fontColor: Colors.black,
                              fontWeight: FontWeight.normal),
                          const SizedBox(height: 8),
                          MyGoogleText(
                              text: user.email,
                              fontSize: 14,
                              fontColor: textColors,
                              fontWeight: FontWeight.normal),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    ///_____My_profile_____________________________
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1, color: secondaryColor3))),
                      child: ListTile(
                        onTap: () {
                          const MyProfileScreen().launch(context);
                        },
                        shape: const Border(
                            bottom: BorderSide(width: 1, color: textColors)),
                        leading: const Icon(IconlyLight.profile),
                        title: const MyGoogleText(
                            text: 'Alterar dados',
                            fontSize: 16,
                            fontColor: Colors.black,
                            fontWeight: FontWeight.normal),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        ),
                      ),
                    ),

                    ///_____Change_password_____________________________
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1, color: secondaryColor3))),
                      child: ListTile(
                        onTap: () {
                          const ChangePassScreen().launch(context);
                        },
                        shape: const Border(
                            bottom: BorderSide(width: 1, color: textColors)),
                        leading: const Icon(IconlyLight.password),
                        title: const MyGoogleText(
                            text: 'Alterar senha',
                            fontSize: 16,
                            fontColor: Colors.black,
                            fontWeight: FontWeight.normal),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        ),
                      ),
                    ),

                    ///_____My_Order____________________________
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1, color: secondaryColor3))),
                      child: ListTile(
                        onTap: () {
                          const OrdersScreen().launch(context);
                        },
                        shape: const Border(
                            bottom: BorderSide(width: 1, color: textColors)),
                        leading: const Icon(IconlyLight.document),
                        title: const MyGoogleText(
                            text: 'Meus pedidos',
                            fontSize: 16,
                            fontColor: Colors.black,
                            fontWeight: FontWeight.normal),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        ),
                      ),
                    ),

                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1, color: secondaryColor3))),
                      child: ListTile(
                        onTap: () {
                          const ShippingAddress(selectable: false)
                              .launch(context);
                        },
                        shape: const Border(
                            bottom: BorderSide(width: 1, color: textColors)),
                        leading: const Icon(IconlyLight.home),
                        title: const MyGoogleText(
                            text: 'Meus endereços',
                            fontSize: 16,
                            fontColor: Colors.black,
                            fontWeight: FontWeight.normal),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        ),
                      ),
                    ),

                    ///__________payment_method______________________-
                    // Container(
                    //   decoration: const BoxDecoration(
                    //       border: Border(
                    //           bottom: BorderSide(
                    //               width: 1, color: secondaryColor3))),
                    //   child: ListTile(
                    //     onTap: () {
                    //       const PaymentMethodScreen().launch(context);
                    //     },
                    //     shape: const Border(
                    //         bottom: BorderSide(width: 1, color: textColors)),
                    //     leading: const Icon(IconlyLight.wallet),
                    //     title: const MyGoogleText(
                    //         text: 'Métodos de pagamento',
                    //         fontSize: 16,
                    //         fontColor: Colors.black,
                    //         fontWeight: FontWeight.normal),
                    //     trailing: const Icon(
                    //       Icons.arrow_forward_ios,
                    //       size: 16,
                    //     ),
                    //   ),
                    // ),

                    ///_________Notification___________________________
                    // Container(
                    //   decoration: const BoxDecoration(
                    //       border: Border(
                    //           bottom: BorderSide(
                    //               width: 1, color: secondaryColor3))),
                    //   child: ListTile(
                    //     onTap: () {
                    //       const NotificationsScreen().launch(context);
                    //     },
                    //     shape: const Border(
                    //         bottom: BorderSide(width: 1, color: textColors)),
                    //     leading: const Icon(IconlyLight.notification),
                    //     title: const MyGoogleText(
                    //         text: 'Notificações',
                    //         fontSize: 16,
                    //         fontColor: Colors.black,
                    //         fontWeight: FontWeight.normal),
                    //     trailing: const Icon(
                    //       Icons.arrow_forward_ios,
                    //       size: 16,
                    //     ),
                    //   ),
                    // ),

                    ///_____________Language________________________
                    // Container(
                    //   decoration: const BoxDecoration(
                    //       border: Border(
                    //           bottom: BorderSide(
                    //               width: 1, color: secondaryColor3))),
                    //   child: const ListTile(
                    //     onTap: null,
                    //     shape: Border(
                    //         bottom: BorderSide(width: 1, color: textColors)),
                    //     leading: Icon(IconlyLight.location),
                    //     title: MyGoogleText(
                    //         text: 'Idioma',
                    //         fontSize: 16,
                    //         fontColor: Colors.black,
                    //         fontWeight: FontWeight.normal),
                    //     trailing: Icon(
                    //       Icons.arrow_forward_ios,
                    //       size: 16,
                    //     ),
                    //   ),
                    // ),

                    ///___________________Help___________________________
                    // Container(
                    //   decoration: const BoxDecoration(
                    //       border: Border(
                    //           bottom: BorderSide(
                    //               width: 1, color: secondaryColor3))),
                    //   child: const ListTile(
                    //     onTap: null,
                    //     shape: Border(
                    //         bottom: BorderSide(width: 1, color: textColors)),
                    //     leading: Icon(IconlyLight.danger),
                    //     title: MyGoogleText(
                    //         text: 'Ajuda e informações',
                    //         fontSize: 16,
                    //         fontColor: Colors.black,
                    //         fontWeight: FontWeight.normal),
                    //     trailing: Icon(
                    //       Icons.arrow_forward_ios,
                    //       size: 16,
                    //     ),
                    //   ),
                    // ),

                    ///______________SignOut_________________________
                    Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1, color: secondaryColor3))),
                      child: ListTile(
                        onTap: () async {
                          final logout = await logoutDialog(context);
                          if (logout == true) {
                            await FirebaseAuth.instance.signOut();
                            fullStore.user = null;
                          }
                          // const LogInScreen().launch(context, isNewTask: true);
                        },
                        shape: const Border(
                            bottom: BorderSide(width: 1, color: textColors)),
                        leading: const Icon(IconlyLight.logout),
                        title: const MyGoogleText(
                            text: 'Sair',
                            fontSize: 16,
                            fontColor: Colors.black,
                            fontWeight: FontWeight.normal),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                final uri = Uri.parse(
                  'https://mimolda.com.br/',
                );

                launchUrl(uri);
              },
              child: const MyGoogleText(
                  text: 'Desenvolvido por Mimolda',
                  fontSize: 12,
                  fontColor: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      );
    }
  }
}

Future<bool?> logoutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Sair'),
        content: const MyGoogleText(
          text: 'Deseja sair da sua conta?',
          fontSize: 16,
          fontColor: Colors.black,
          fontWeight: FontWeight.normal,
        ),
        actions: <Widget>[
          TextButton(
            child: const MyGoogleText(
              text: 'Sim',
              fontSize: 16,
              fontColor: Colors.red,
              fontWeight: FontWeight.normal,
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
          TextButton(
            child: const MyGoogleText(
              text: 'Não',
              fontSize: 16,
              fontColor: Colors.black,
              fontWeight: FontWeight.normal,
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        ],
      );
    },
  );
}
