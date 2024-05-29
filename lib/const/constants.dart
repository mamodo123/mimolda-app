import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mimolda/screens/profile_screen.dart';
import 'package:mimolda/screens/wishlist_screen.dart';

import '../screens/cart_screen.dart';
import '../screens/home_screens/home_screen.dart';
import '../screens/search_product_screen.dart';

var bottomNavigationBarActions = const [
  HomeScreen(),
  SearchProductScreen(),
  CartScreen(),
  WishlistScreen(),
  ProfileScreen(),
];

const primaryColor = Color(0xFF3E3E70);
const secondaryColor1 = Color(0xFFE2396C);
const secondaryColor2 = Color(0xFFFBFBFB);
const secondaryColor3 = Color(0xFFE5E5E5);
const titleColors = Color(0xFF1A1A1A);
const textColors = Color(0xFF828282);
const ratingColor = Color(0xFFFFB03A);

//Welcome Screen
const kTitleColor = Color(0xFF1A1A1A);
const kGreyTextColor = Color(0xFF828282);

//Grocery App
const groceryMainColor = Color(0xFF27AE60);
const groceryTextColor = Color(0xFFFFFFFF);
const groceryGreyTextColor = Color(0xFFB9BBC8);

//Watch
const watchMainColor = Color(0xFF524EB7);
const watchTitleColor = Color(0xFF060606);
const watchGreyTextColor = Color(0xFFA6A6A6);
const watchSecondaryColor = Color(0xFFF76631);
const watchSecondaryTextColor = Color(0xFF282344);

const categoryColor1 = Color(0xFFFCF3D7);
const categoryColor2 = Color(0xFFDCF7E3);

final TextStyle kTextStyle = GoogleFonts.dmSans(
  textStyle: const TextStyle(
    color: textColors,
    fontSize: 16,
  ),
);

class MyGoogleText extends StatelessWidget {
  const MyGoogleText(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.fontColor,
      required this.fontWeight,
      this.decoration});

  final String text;
  final double fontSize;
  final Color fontColor;
  final FontWeight fontWeight;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
        textStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: fontColor,
            decoration: decoration),
      ),
      maxLines: 2,
    );
  }
}

class MyGoogleTextWhitAli extends StatelessWidget {
  const MyGoogleTextWhitAli({
    super.key,
    required this.text,
    required this.fontSize,
    required this.fontColor,
    required this.fontWeight,
    required this.textAlign,
  });

  final String text;
  final double fontSize;
  final Color fontColor;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.dmSans(
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: fontColor,
        ),
      ),
    );
  }
}

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(color: secondaryColor1),
  );
}

final otpInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);
