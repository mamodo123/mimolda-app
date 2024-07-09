import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class Button1 extends StatelessWidget {
  Button1({
    super.key,
    required this.buttonText,
    required this.buttonColor,
    required this.onPressFunction,
    this.loading = false,
    this.textColor = Colors.white,
    this.border = false,
    this.fontSize,
  });

  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  bool border;
  double? fontSize;

  // ignore: prefer_typing_uninitialized_variables
  var onPressFunction;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressFunction,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: onPressFunction == null ? Colors.grey : buttonColor,
          border: border ? Border.all(color: Colors.black) : null,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Center(
          child: loading
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(
                  buttonText,
                  style: GoogleFonts.dmSans(
                    fontSize: fontSize,
                    textStyle: TextStyle(
                        color: textColor, fontWeight: FontWeight.bold),
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
    super.key,
    required this.buttonText,
    required this.buttonColor,
    required this.onPressFunction,
  });

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
