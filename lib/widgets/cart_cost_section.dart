import 'package:flutter/material.dart';
import 'package:mimolda/models/full_store.dart';
import 'package:provider/provider.dart';

import '../const/constants.dart';
import '../models/order.dart';

class CartCostSection extends StatelessWidget {
  final int? freight;
  final bool purchase;

  const CartCostSection({
    super.key,
    this.freight,
    this.purchase = true,
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
        if (freight != null && purchase)
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
                freight == -1
                    ? GestureDetector(
                        onTap: () {
                          showFreightDialog(context, purchase);
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MyGoogleText(
                              text: 'A combinar',
                              fontSize: 20,
                              fontColor: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.info_outline)
                          ],
                        ),
                      )
                    : MyGoogleText(
                        text: freight == 0
                            ? 'Grátis'
                            : 'R\$${(freight! / 100).toStringAsFixed(2)}',
                        fontSize: 20,
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
                text: purchase ? 'Total' : 'Total dos produtos',
                fontSize: 18,
                fontColor: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              MyGoogleText(
                text:
                    'R\$${((fullStore.cartWithDiscount + (purchase ? (freight ?? 0) : 0)) / 100).toStringAsFixed(2)}',
                fontSize: 20,
                fontColor: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ],
          ),
        ),
        if (freight != null && !purchase)
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
                freight == -1
                    ? GestureDetector(
                        onTap: () {
                          showFreightDialog(context, purchase);
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MyGoogleText(
                              text: 'A combinar',
                              fontSize: 20,
                              fontColor: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.info_outline)
                          ],
                        ),
                      )
                    : MyGoogleText(
                        text: freight == 0
                            ? 'Grátis'
                            : 'R\$${(freight! / 100).toStringAsFixed(2)}',
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
        if (!onlyFreight && showFreight && order.freight != null)
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
                order.freight == -1
                    ? GestureDetector(
                        onTap: () {
                          showFreightDialog(context, true);
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MyGoogleText(
                              text: 'A combinar',
                              fontSize: 20,
                              fontColor: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.info_outline)
                          ],
                        ),
                      )
                    : MyGoogleText(
                        text: order.freight == 0
                            ? 'Grátis'
                            : 'R\$${(order.freight! / 100).toStringAsFixed(2)}',
                        fontSize: 20,
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
        if (onlyFreight && showFreight && order.freight != null)
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
                order.freight == -1
                    ? GestureDetector(
                        onTap: () {
                          showFreightDialog(context, true);
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MyGoogleText(
                              text: 'A combinar',
                              fontSize: 20,
                              fontColor: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.info_outline)
                          ],
                        ),
                      )
                    : MyGoogleText(
                        text: order.freight == 0
                            ? 'Grátis'
                            : 'R\$${(order.freight! / 100).toStringAsFixed(2)}',
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

Future<void> showFreightDialog(BuildContext context, bool purchase) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Frete a combinar'),
        content: Text(
          'Após a realização do pedido, nós conversaremos com você pelo WhatsApp para confirmar '
          'o valor da entrega${purchase ? '' : ' e da devolução'} dos produtos.',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fecha o diálogo
            },
            child: const Text('Ok'),
          ),
        ],
      );
    },
  );
}
