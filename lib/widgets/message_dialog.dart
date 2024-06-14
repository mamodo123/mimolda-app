import 'package:flutter/material.dart';

import '../const/constants.dart';

Future<bool?> messageDialog(
    BuildContext context, String title, String content) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: MyGoogleText(
          text: content,
          fontSize: 16,
          fontColor: Colors.black,
          fontWeight: FontWeight.normal,
        ),
        actions: <Widget>[
          TextButton(
            child: const MyGoogleText(
              text: 'Ok',
              fontSize: 16,
              fontColor: Colors.black,
              fontWeight: FontWeight.normal,
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}
