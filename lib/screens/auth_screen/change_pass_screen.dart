import 'package:flutter/material.dart';
import 'package:mimolda/const/constants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../widgets/buttons.dart';
import '../../widgets/confirmation_popup.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({Key? key}) : super(key: key);

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, top: 30),
            child: SizedBox(
              height: 100,
              width: 248,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  MyGoogleText(
                    fontSize: 26,
                    fontColor: Colors.black,
                    text: 'Change Password',
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 15),
                  MyGoogleText(
                    fontSize: 16,
                    fontColor: textColors,
                    text: 'The Password should have at least 6 characters',
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
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10),
                AppTextField(
                  controller: TextEditingController(), // Optional
                  textFieldType: TextFieldType.PASSWORD,
                  decoration: const InputDecoration(
                      labelText: 'Password', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 15),
                AppTextField(
                  controller: TextEditingController(), // Optional
                  textFieldType: TextFieldType.PASSWORD,
                  decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder()),
                ),
                const SizedBox(height: 30),
                Button1(
                    buttonText: 'Submit',
                    buttonColor: primaryColor,
                    onPressFunction: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) =>
                              const RedeemConfirmationScreen(
                            image: 'images/password_change_image.png',
                            mainText: 'Password Changed',
                            subText:
                                'Your password has been success fully changed!',
                            buttonText: 'Done',
                          ),
                        ),
                      );
                    }),
                const SizedBox(height: 200),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
