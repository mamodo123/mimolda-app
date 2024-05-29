import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class Button1 extends StatelessWidget {
  Button1({
    Key? key,
    required this.buttonText,
    required this.buttonColor,
    required this.onPressFunction,
  }) : super(key: key);
  final String buttonText;
  final Color buttonColor;
  // ignore: prefer_typing_uninitialized_variables
  var onPressFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressFunction,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: GoogleFonts.dmSans(
              textStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ButtonType2 extends StatelessWidget {
  ButtonType2({
    Key? key,
    required this.buttonText,
    required this.buttonColor,
    required this.onPressFunction,
  }) : super(key: key);
  final String buttonText;
  final Color buttonColor;
  // ignore: prefer_typing_uninitialized_variables
  var onPressFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressFunction,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          border: Border.all(
            width: 2,
            color: buttonColor,
          ),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: GoogleFonts.dmSans(
              textStyle:
                  TextStyle(color: buttonColor, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
