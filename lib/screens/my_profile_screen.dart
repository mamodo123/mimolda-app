import 'package:flutter/material.dart';
import 'package:mimolda/widgets/buttons.dart';
import 'package:nb_utils/nb_utils.dart';

import '../const/constants.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
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
          text: 'Edit Profile',
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
              height: context.height() - (AppBar().preferredSize.height + 20),
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
                  AppTextField(
                    controller: TextEditingController(), // Optional
                    textFieldType: TextFieldType.NAME,
                    decoration: const InputDecoration(
                        labelText: 'Full Name', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    controller: TextEditingController(), // Optional
                    textFieldType: TextFieldType.EMAIL,
                    decoration: const InputDecoration(
                        labelText: 'Email', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    controller: TextEditingController(), // Optional
                    textFieldType: TextFieldType.PHONE,
                    decoration: const InputDecoration(
                        labelText: 'Phone Number (Optional)',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20),
                  const Spacer(),
                  Button1(
                      buttonText: 'Update Profile',
                      buttonColor: primaryColor,
                      onPressFunction: () {}),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
