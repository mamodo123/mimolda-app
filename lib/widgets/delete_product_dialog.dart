import 'package:flutter/material.dart';

import '../const/constants.dart';

Future<bool?> deleteProductDialog(BuildContext context, String product) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Excluir produto?'),
        content: MyGoogleText(
          text: 'Deseja excluir $product?',
          fontSize: 16,
          fontColor: Colors.black,
          fontWeight: FontWeight.normal,
        ),
        actions: <Widget>[
          TextButton(
            child: const MyGoogleText(
              text: 'Sim',
              fontSize: 16,
              fontColor: Colors.red,
              fontWeight: FontWeight.normal,
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
          TextButton(
            child: const MyGoogleText(
              text: 'Não',
              fontSize: 16,
              fontColor: Colors.black,
              fontWeight: FontWeight.normal,
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        ],
      );
    },
  );
}
