import 'package:flutter/material.dart';

import '../const/constants.dart';
import 'buttons.dart';

class Sort extends StatefulWidget {
  const Sort({Key? key}) : super(key: key);

  @override
  State<Sort> createState() => _SortState();
}

class _SortState extends State<Sort> {
  bool isCheckedMostPopular = false;
  bool isCheckedNewItem = false;
  bool isCheckedPriceHighToLow = false;
  bool isCheckedPriceLowToHigh = false;
  bool isCheckedRating = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MyGoogleText(
                  text: 'Sort By',
                  fontSize: 20,
                  fontColor: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MyGoogleText(
                  text: 'Most Popular',
                  fontSize: 16,
                  fontColor: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                Checkbox(
                  value: isCheckedMostPopular,
                  activeColor: secondaryColor1,
                  checkColor: secondaryColor1,
                  onChanged: (value) {
                    setState(() {
                      isCheckedMostPopular = value!;
                    });
                  },
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MyGoogleText(
                  text: 'New Item',
                  fontSize: 16,
                  fontColor: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                Checkbox(
                  value: isCheckedNewItem,
                  activeColor: secondaryColor1,
                  checkColor: secondaryColor1,
                  onChanged: (value) {
                    setState(() {
                      isCheckedNewItem = value!;
                    });
                  },
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MyGoogleText(
                  text: 'Price: High To Low',
                  fontSize: 16,
                  fontColor: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                Checkbox(
                  value: isCheckedPriceHighToLow,
                  activeColor: secondaryColor1,
                  checkColor: secondaryColor1,
                  onChanged: (value) {
                    setState(() {
                      isCheckedPriceHighToLow = value!;
                    });
                  },
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MyGoogleText(
                  text: 'Price: Low To High',
                  fontSize: 16,
                  fontColor: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                Checkbox(
                  value: isCheckedPriceLowToHigh,
                  activeColor: secondaryColor1,
                  checkColor: secondaryColor1,
                  onChanged: (value) {
                    setState(() {
                      isCheckedPriceLowToHigh = value!;
                    });
                  },
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MyGoogleText(
                  text: 'Rating',
                  fontSize: 16,
                  fontColor: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                Checkbox(
                  value: isCheckedRating,
                  activeColor: secondaryColor1,
                  checkColor: secondaryColor1,
                  onChanged: (value) {
                    setState(() {
                      isCheckedRating = value!;
                    });
                  },
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Button1(
              buttonText: 'Apply',
              buttonColor: primaryColor,
              onPressFunction: () {},
            ),
          ],
        ),
      ),
    );
  }
}
