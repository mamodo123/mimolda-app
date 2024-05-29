import 'package:flutter/material.dart';
import 'package:mimolda/models/full_store.dart';
import 'package:provider/provider.dart';

import '../const/constants.dart';

class CartCostSection extends StatelessWidget {
  final int? freight;

  const CartCostSection({
    super.key,
    this.freight,
  });

  @override
  Widget build(BuildContext context) {
    final fullStore = context.watch<FullStoreNotifier>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MyGoogleText(
          text: 'Seu pedido',
          fontSize: 18,
          fontColor: Colors.black,
          fontWeight: FontWeight.normal,
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.all(8.00),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const MyGoogleText(
                text: 'Valor original',
                fontSize: 16,
                fontColor: textColors,
                fontWeight: FontWeight.normal,
              ),
              MyGoogleText(
                text:
                    'R\$${(fullStore.cartWithoutDiscount / 100).toStringAsFixed(2)}',
                fontSize: 18,
                fontColor: Colors.black,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.lineThrough,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.00),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const MyGoogleText(
                text: 'Descontos',
                fontSize: 16,
                fontColor: textColors,
                fontWeight: FontWeight.normal,
              ),
              MyGoogleText(
                text: 'R\$${(fullStore.cartDiscount / 100).toStringAsFixed(2)}',
                fontSize: 18,
                fontColor: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ],
          ),
        ),
        if (freight != null)
          Padding(
            padding: const EdgeInsets.all(8.00),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MyGoogleText(
                  text: 'Frete',
                  fontSize: 16,
                  fontColor: textColors,
                  fontWeight: FontWeight.normal,
                ),
                MyGoogleText(
                  text: 'R\$${(freight! / 100).toStringAsFixed(2)}',
                  fontSize: 18,
                  fontColor: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ),
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            width: 1,
            color: textColors,
          ))),
        ),
        Padding(
          padding: const EdgeInsets.all(8.00),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const MyGoogleText(
                text: 'Total',
                fontSize: 18,
                fontColor: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              MyGoogleText(
                text:
                    'R\$${((fullStore.cartWithDiscount + (freight ?? 0)) / 100).toStringAsFixed(2)}',
                fontSize: 20,
                fontColor: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
