import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mimolda/widgets/buttons.dart';

import '../const/constants.dart';

class AddNewAddress extends StatefulWidget {
  const AddNewAddress({Key? key}) : super(key: key);

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  bool addressSwitch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MyGoogleText(
                  text: 'Add New Address',
                  fontSize: 20,
                  fontColor: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Full Name*',
                hintText: 'Enter Your Full Name',
              ),
            ),
            const SizedBox(height: 15),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Country*',
                hintText: 'Enter Your Country',
              ),
            ),
            const SizedBox(height: 15),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Street address*',
                hintText: 'Enter Your Street address',
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: const [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Town / City*',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Postcode*',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email*',
                hintText: 'Enter Your email address',
              ),
            ),
            const SizedBox(height: 15),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Phone Number*',
                hintText: 'Enter Your phone number',
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MyGoogleText(
                  text: 'Use as Billing address',
                  fontSize: 18,
                  fontColor: textColors,
                  fontWeight: FontWeight.normal,
                ),
                Platform.isAndroid
                    ? Switch(
                        value: addressSwitch,
                        onChanged: (value) {
                          setState(() {
                            addressSwitch = value;
                          });
                        },
                        activeColor: secondaryColor1,
                      )
                    : CupertinoSwitch(
                        activeColor: secondaryColor1,
                        value: addressSwitch,
                        onChanged: (value) {
                          setState(() {
                            addressSwitch = value;
                          });
                        },
                      )
              ],
            ),
            const SizedBox(height: 15),
            Button1(
                buttonText: 'Save',
                buttonColor: primaryColor,
                onPressFunction: () {}),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
