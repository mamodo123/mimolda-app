import 'package:flutter/material.dart';
import 'package:mimolda/welcome_screen.dart';
import 'package:nb_utils/nb_utils.dart';

import '../const/constants.dart';
import 'buttons.dart';

class RedeemConfirmationScreen extends StatelessWidget {
  const RedeemConfirmationScreen(
      {Key? key,
      required this.image,
      required this.mainText,
      required this.subText,
      required this.buttonText})
      : super(key: key);

  final String image;
  final String mainText;
  final String subText;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.4),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Image(
                    image: AssetImage(image),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: MyGoogleText(
                          fontSize: 26,
                          fontColor: Colors.black,
                          text: mainText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      MyGoogleTextWhitAli(
                        fontSize: 16,
                        fontColor: textColors,
                        text: subText,
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
                  child: Button1(
                      buttonText: buttonText,
                      buttonColor: primaryColor,
                      onPressFunction: () {
                        const WelComeScreen().launch(context);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
