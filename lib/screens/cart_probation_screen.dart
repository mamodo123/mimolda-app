import 'package:flutter/material.dart';
import 'package:mimolda/models/order.dart';
import 'package:mimolda/widgets/cart_item_single_view.dart';

import '../const/constants.dart';
import '../widgets/buttons.dart';
import '../widgets/cart_cost_section.dart';

class CartProbationScreen extends StatefulWidget {
  final MimoldaOrder order;

  const CartProbationScreen({super.key, required this.order});

  @override
  State<CartProbationScreen> createState() => _CartProbationScreenState();
}

class _CartProbationScreenState extends State<CartProbationScreen> {
  late final Map<ProductOrder, int> products;

  @override
  void initState() {
    products = Map.fromEntries(
        widget.order.products.map((e) => MapEntry(e, e.quantity)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final totalItemsToPurchase =
        products.values.fold<int>(0, (total, e) => total += e);
    final totalItems =
        products.keys.fold<int>(0, (total, e) => total += e.quantity);
    final notPurchased = totalItems - totalItemsToPurchase;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
              child: MyGoogleText(
                text:
                    '$totalItemsToPurchase ${totalItemsToPurchase == 1 ? 'item' : 'itens'}',
                fontSize: 16,
                fontColor: textColors,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
        title: const MyGoogleText(
          text: 'Carrinho - Provação',
          fontColor: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 18,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const Text('Selecione quais itens deseja comprar'),
                  Column(
                    children: products.entries.map<Widget>((productEntry) {
                      final product = productEntry.key;
                      final total = productEntry.value;
                      return CartOrderItemsSingleView(
                        product,
                        total,
                        (value) {
                          if (value >= 0 && value <= product.quantity) {
                            setState(() {
                              products[product] = value;
                            });
                          }
                        },
                        hideMinus: total == 0,
                        hidePlus: total == product.quantity,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  CartProbationSection(
                    products: products,
                    freight: null,
                    showFreight: false,
                  ),
                  const SizedBox(height: 20),
                  Button1(
                      fontSize: 18,
                      buttonText: totalItemsToPurchase == 0
                          ? 'DEVOLVER $totalItems ${totalItems == 1 ? 'ITEM' : 'ITENS'} À LOJA'
                          : 'COMPRAR',
                      buttonColor: totalItemsToPurchase == 0
                          ? Colors.white
                          : primaryColor,
                      border: totalItemsToPurchase == 0,
                      textColor: totalItemsToPurchase == 0
                          ? Colors.black
                          : Colors.white,
                      onPressFunction: () async {
                        final probationReturn = ProbationPurchase(
                            widget.order,
                            totalItemsToPurchase == 0 ? null : products,
                            notPurchased != 0);
                        await Navigator.of(context).pushNamed(
                            '/confirm_probation_return',
                            arguments: probationReturn);
                      }),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                      '$notPurchased ${notPurchased == 1 ? 'item a ser devolvido' : 'itens a serem devolvidos'}'),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                      'Os itens não comprados devem ser devolvidos à loja'),
                  const SizedBox(
                    height: 5,
                  ),
                  TextButton(
                    onPressed: () async {
                      final probationReturn =
                          ProbationPurchase(widget.order, null, true);
                      await Navigator.of(context).pushNamed(
                          '/confirm_probation_return',
                          arguments: probationReturn);
                    },
                    child: const Text('Devolver todos os itens'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProbationPurchase {
  final MimoldaOrder oldOrder;
  final Map<ProductOrder, int>? products;
  final bool hasReturn;

  List<ProductOrder>? get purchaseProducts {
    if (products == null) {
      return null;
    } else {
      return products!.entries
          .where((e) => e.value != 0)
          .map((entry) => ProductOrder(
              product: entry.key.product,
              productId: entry.key.productId,
              image: entry.key.image,
              attributes: entry.key.attributes,
              price: entry.key.price,
              promotionalPrice: entry.key.promotionalPrice,
              quantity: entry.value))
          .toList();
    }
  }

  List<ProductOrder>? get returnProducts {
    if (hasReturn) {
      final purchasedProducts = products;
      if (purchasedProducts != null) {
        final List<ProductOrder> productsToReturn = [];
        for (final product in oldOrder.products) {
          final purchasedQuantity = purchasedProducts[product];
          if (purchasedQuantity != null) {
            if (purchasedQuantity != product.quantity) {
              productsToReturn.add(ProductOrder(
                  product: product.product,
                  productId: product.productId,
                  image: product.image,
                  attributes: product.attributes,
                  price: product.price,
                  promotionalPrice: product.promotionalPrice,
                  quantity: product.quantity - purchasedQuantity));
            }
          } else {
            productsToReturn.add(product);
          }
        }
        return productsToReturn;
      } else {
        return oldOrder.products;
      }
    } else {
      return null;
    }
  }

  const ProbationPurchase(this.oldOrder, this.products, this.hasReturn);
}
