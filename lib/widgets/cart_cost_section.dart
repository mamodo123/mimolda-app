import 'package:flutter/material.dart';
import 'package:mimolda/models/full_store.dart';
import 'package:provider/provider.dart';

import '../const/constants.dart';
import '../models/order.dart';

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

class CartCostOrderSection extends StatelessWidget {
  final MimoldaOrder order;
  final bool onlyFreight, showFreight;

  const CartCostOrderSection(
      {super.key,
      required this.order,
      this.onlyFreight = false,
      this.showFreight = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MyGoogleText(
          text: 'Pedido',
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
                text: 'R\$${((order.originalValue) / 100).toStringAsFixed(2)}',
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
                text: 'R\$${(order.discounts / 100).toStringAsFixed(2)}',
                fontSize: 18,
                fontColor: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ],
          ),
        ),
        if (!onlyFreight && showFreight)
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
                  text: 'R\$${((order.freight ?? 0) / 100).toStringAsFixed(2)}',
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
              MyGoogleText(
                text:
                    onlyFreight && showFreight ? 'Valor dos produtos' : 'Total',
                fontSize: 18,
                fontColor: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              MyGoogleText(
                text:
                    'R\$${((order.originalValue + order.discounts) / 100).toStringAsFixed(2)}',
                fontSize: 20,
                fontColor: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ],
          ),
        ),
        if (onlyFreight && showFreight)
          Padding(
            padding: const EdgeInsets.all(8.00),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MyGoogleText(
                  text: 'Frete',
                  fontSize: 18,
                  fontColor: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                MyGoogleText(
                  text: 'R\$${((order.freight ?? 0) / 100).toStringAsFixed(2)}',
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

class CartProbationSection extends StatelessWidget {
  final Map<ProductOrder, int> products;
  final int? freight;
  final bool showFreight;

  const CartProbationSection(
      {super.key,
      required this.products,
      required this.freight,
      this.showFreight = true});

  @override
  Widget build(BuildContext context) {
    final originalValue = products.entries.fold<int>(
        0, (total, entry) => total += entry.value * (entry.key.price ?? 0));
    final totalValue = products.entries.fold<int>(
        0,
        (total, entry) => total +=
            entry.value * (entry.key.promotionalPrice ?? entry.key.price ?? 0));
    final discounts = totalValue - originalValue;
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
                text: 'R\$${(originalValue / 100).toStringAsFixed(2)}',
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
                text: 'R\$${(discounts / 100).toStringAsFixed(2)}',
                fontSize: 18,
                fontColor: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ],
          ),
        ),
        if (showFreight)
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
                  text: freight == null
                      ? 'A definir'
                      : 'R\$${(freight! / 100).toStringAsFixed(2)}',
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
                    'R\$${((totalValue + (freight ?? 0)) / 100).toStringAsFixed(2)}',
                fontSize: 20,
                fontColor: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
