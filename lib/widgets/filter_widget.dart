import 'package:flutter/material.dart';
import 'package:mimolda/widgets/rating_filter_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../const/constants.dart';
import 'buttons.dart';
import 'color_button_widget.dart';

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  bool isCheckedMostPopular = false;
  bool isCheckedNewItem = false;
  bool isCheckedPriceHighToLow = false;
  bool isCheckedPriceLowToHigh = false;
  bool isCheckedRating = false;
  final productType = ['All', 'Dresses', 'Shoes', 'T-shirts', 'Tops', 'Pants'];
  int currentItem = 0;
  SfRangeValues _values = const SfRangeValues(20.0, 50.0);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MyGoogleText(
                  text: 'Apply Filter',
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
            const MyGoogleTextWhitAli(
              text: 'Categories',
              fontSize: 16,
              fontColor: Colors.black,
              fontWeight: FontWeight.normal,
              textAlign: TextAlign.start,
            ),
            HorizontalList(
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      currentItem = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 12, bottom: 12),
                    decoration: BoxDecoration(
                      color:
                          currentItem == index ? secondaryColor1 : Colors.white,
                      border: Border.all(
                        width: 1,
                        color: secondaryColor3,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: MyGoogleText(
                      text: productType[index],
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      fontColor:
                          currentItem == index ? Colors.white : Colors.black,
                    ),
                  ),
                );
              },
              itemCount: productType.length,
            ),
            const SizedBox(height: 20),
            const MyGoogleTextWhitAli(
              text: 'Price Range',
              fontSize: 16,
              fontColor: Colors.black,
              fontWeight: FontWeight.normal,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 20),
            SfRangeSlider(
              activeColor: secondaryColor1,
              min: 0.0.toInt(),
              max: 100.0.toInt(),
              values: _values,
              interval: 20,
              showTicks: true,
              showLabels: true,
              enableTooltip: true,
              minorTicksPerInterval: 1,
              onChanged: (SfRangeValues values) {
                setState(() {
                  _values = values;
                });
              },
            ),
            const SizedBox(height: 20),
            const MyGoogleTextWhitAli(
              text: 'Color',
              fontSize: 16,
              fontColor: Colors.black,
              fontWeight: FontWeight.normal,
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 41,
              child: ColorButton(),
            ),
            const SizedBox(height: 20),
            const MyGoogleTextWhitAli(
              text: 'Star Rating',
              fontSize: 16,
              fontColor: Colors.black,
              fontWeight: FontWeight.normal,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 10),
            const SizedBox(
              height: 50,
              child: StarRating(),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: ButtonType2(
                    buttonText: 'Reset',
                    buttonColor: primaryColor,
                    onPressFunction: () {},
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Button1(
                    buttonText: 'Apply',
                    buttonColor: primaryColor,
                    onPressFunction: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

