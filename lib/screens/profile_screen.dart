import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:iconly/iconly.dart';
import 'package:mimolda/screens/auth_screen/change_pass_screen.dart';
import 'package:mimolda/screens/auth_screen/log_in_screen.dart';
import 'package:mimolda/screens/my_order.dart';
import 'package:mimolda/screens/notificition_screen.dart';
import 'package:mimolda/screens/payment_method_screen.dart';
import 'package:mimolda/screens/search_product_screen.dart';
import 'package:nb_utils/nb_utils.dart';

import '../const/constants.dart';
import 'my_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          text: 'Profile',
          fontColor: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 20,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: secondaryColor3,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: IconButton(
                onPressed: () {
                  const SearchProductScreen().launch(context);
                },
                icon: const Icon(
                  FeatherIcons.search,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: secondaryColor3,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: IconButton(
                onPressed: () {
                  const NotificationsScreen().launch(context);
                },
                icon: const Icon(
                  FeatherIcons.bell,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 30, top: 30, bottom: 20),
              width: context.width(),
              height: context.height(),
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
                  Row(
                    children: [
                      Container(
                        height: 90,
                        width: 90,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: AssetImage('images/profile_pic.jpg'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            MyGoogleText(
                                text: 'Shaidul Islam',
                                fontSize: 24,
                                fontColor: Colors.black,
                                fontWeight: FontWeight.normal),
                            SizedBox(height: 8),
                            MyGoogleText(
                                text: 'shaidulislamma@gmail.com',
                                fontSize: 14,
                                fontColor: textColors,
                                fontWeight: FontWeight.normal),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  ///_____My_profile_____________________________
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 1, color: secondaryColor3))),
                    child: ListTile(
                      onTap: () {
                        const MyProfileScreen().launch(context);
                      },
                      shape: const Border(
                          bottom: BorderSide(width: 1, color: textColors)),
                      leading: const Icon(IconlyLight.profile),
                      title: const MyGoogleText(
                          text: 'My Profile',
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
                            bottom:
                                BorderSide(width: 1, color: secondaryColor3))),
                    child: ListTile(
                      onTap: () {
                        const ChangePassScreen().launch(context);
                      },
                      shape: const Border(
                          bottom: BorderSide(width: 1, color: textColors)),
                      leading: const Icon(IconlyLight.password),
                      title: const MyGoogleText(
                          text: 'Change Password',
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
                            bottom:
                                BorderSide(width: 1, color: secondaryColor3))),
                    child: ListTile(
                      onTap: () {
                        const MyOrderScreen().launch(context);
                      },
                      shape: const Border(
                          bottom: BorderSide(width: 1, color: textColors)),
                      leading: const Icon(IconlyLight.document),
                      title: const MyGoogleText(
                          text: 'My Orders',
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
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 1, color: secondaryColor3))),
                    child: ListTile(
                      onTap: () {
                        const PaymentMethodScreen().launch(context);
                      },
                      shape: const Border(
                          bottom: BorderSide(width: 1, color: textColors)),
                      leading: const Icon(IconlyLight.wallet),
                      title: const MyGoogleText(
                          text: 'Payment Method',
                          fontSize: 16,
                          fontColor: Colors.black,
                          fontWeight: FontWeight.normal),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ),
                  ),

                  ///_________Notification___________________________
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 1, color: secondaryColor3))),
                    child: ListTile(
                      onTap: () {
                        const NotificationsScreen().launch(context);
                      },
                      shape: const Border(
                          bottom: BorderSide(width: 1, color: textColors)),
                      leading: const Icon(IconlyLight.notification),
                      title: const MyGoogleText(
                          text: 'Notification',
                          fontSize: 16,
                          fontColor: Colors.black,
                          fontWeight: FontWeight.normal),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ),
                  ),

                  ///_____________Language________________________
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 1, color: secondaryColor3))),
                    child: const ListTile(
                      onTap: null,
                      shape: Border(
                          bottom: BorderSide(width: 1, color: textColors)),
                      leading: Icon(IconlyLight.location),
                      title: MyGoogleText(
                          text: 'Language',
                          fontSize: 16,
                          fontColor: Colors.black,
                          fontWeight: FontWeight.normal),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ),
                  ),

                  ///___________________Help___________________________
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 1, color: secondaryColor3))),
                    child: const ListTile(
                      onTap: null,
                      shape: Border(
                          bottom: BorderSide(width: 1, color: textColors)),
                      leading: Icon(IconlyLight.danger),
                      title: MyGoogleText(
                          text: 'Help & Info',
                          fontSize: 16,
                          fontColor: Colors.black,
                          fontWeight: FontWeight.normal),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ),
                  ),

                  ///______________SignOut_________________________
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 1, color: secondaryColor3))),
                    child: ListTile(
                      onTap: () {
                        const LogInScreen()
                            .launch(context, isNewTask: true);
                      },
                      shape: const Border(
                          bottom: BorderSide(width: 1, color: textColors)),
                      leading: const Icon(IconlyLight.logout),
                      title: const MyGoogleText(
                          text: 'Sign Out',
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
          ],
        ),
      ),
    );
  }
}
