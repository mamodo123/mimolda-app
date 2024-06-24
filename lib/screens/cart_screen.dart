import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconly/iconly.dart';
import 'package:mimolda/models/full_store.dart';
import 'package:mimolda/widgets/cart_item_single_view.dart';
import 'package:provider/provider.dart';

import '../const/constants.dart';
import '../widgets/buttons.dart';
import '../widgets/cart_cost_section.dart';
import '../widgets/delete_product_dialog.dart';

enum BuyOrTry { buy, tryOn }

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var buyOrTry = BuyOrTry.buy;

  @override
  Widget build(BuildContext context) {
    final fullStore = context.watch<FullStoreNotifier>();
    final cart = fullStore.cart;
    final totalItems = fullStore.cartSize;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Center(
              child: MyGoogleText(
                text: '$totalItems ${totalItems == 1 ? 'item' : 'itens'}',
                fontSize: 16,
                fontColor: textColors,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
        title: const MyGoogleText(
          text: 'Carrinho',
          fontColor: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 18,
        ),
      ),
      body: cart.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    IconlyLight.bag,
                    size: 80,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MyGoogleText(
                    text: 'Não há produtos no carrinho',
                    fontSize: 18,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
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
                        Column(
                          children: cart.entries
                              .map<Widget>(
                                (productEntry) => Column(
                                  children: cart[productEntry.key]!
                                      .entries
                                      .map<Widget>((variantEntry) {
                                    final product = productEntry.key;
                                    final variant = variantEntry.key;
                                    final total = variantEntry.value;
                                    return Slidable(
                                      // Specify a key if the Slidable is dismissible.

                                      // The end action pane is the one at the right or the bottom side.
                                      endActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: GestureDetector(
                                              child: Container(
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  color: secondaryColor1
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(30)),
                                                ),
                                                child: const Center(
                                                    child: Icon(
                                                  Icons.delete,
                                                  size: 35,
                                                  color: secondaryColor1,
                                                )),
                                              ),
                                              onTap: () async {
                                                final variantName = variant
                                                    .attributes.values
                                                    .join(' ');
                                                final delete =
                                                    await deleteProductDialog(
                                                        context,
                                                        '${product.name}${variantName == '' ? '' : ' ($variantName)'}');
                                                if (delete == true) {
                                                  fullStore.removeFromCart(
                                                      product, variant);
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      child: CartItemsSingleView(
                                          product, variant, total),
                                      //
                                    );
                                  }).toList(),
                                ),
                              )
                              .toList(),
                        ),
                        // const SizedBox(height: 40),
                        // Container(
                        //   height: 60,
                        //   width: double.infinity,
                        //   decoration: BoxDecoration(
                        //     borderRadius: const BorderRadius.all(
                        //       Radius.circular(15),
                        //     ),
                        //     border: Border.all(width: 1, color: textColors),
                        //   ),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Container(
                        //         height: 40,
                        //         width: 60,
                        //         decoration: const BoxDecoration(
                        //           border: Border(
                        //               right: BorderSide(width: 1, color: textColors)),
                        //         ),
                        //         child: const Center(
                        //             child: Icon(
                        //           Icons.percent,
                        //           color: textColors,
                        //         )),
                        //       ),
                        //       SizedBox(
                        //           width: 200,
                        //           child: Padding(
                        //             padding: const EdgeInsets.all(8.0),
                        //             child: TextFormField(
                        //               cursorColor: textColors,
                        //               decoration: const InputDecoration(
                        //                   floatingLabelBehavior:
                        //                       FloatingLabelBehavior.never,
                        //                   border: InputBorder.none,
                        //                   label: MyGoogleText(
                        //                     text: 'Coupon code',
                        //                     fontColor: textColors,
                        //                     fontSize: 16,
                        //                     fontWeight: FontWeight.normal,
                        //                   )),
                        //             ),
                        //           )),
                        //       GestureDetector(
                        //         onTap: () {},
                        //         child: Container(
                        //           height: 60,
                        //           width: 80,
                        //           decoration: const BoxDecoration(
                        //               borderRadius: BorderRadius.only(
                        //                   topRight: Radius.circular(15),
                        //                   bottomRight: Radius.circular(15)),
                        //               color: secondaryColor1),
                        //           child: const Center(
                        //               child: MyGoogleText(
                        //                   text: 'Apply',
                        //                   fontSize: 14,
                        //                   fontColor: Colors.white,
                        //                   fontWeight: FontWeight.normal)),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // if (tryItAtHome)
                        //   Column(
                        //     children: [
                        //       const SizedBox(height: 20),
                        //       SizedBox(
                        //         height: 40,
                        //         child: Row(
                        //           children: [
                        //             Expanded(
                        //               child: GestureDetector(
                        //                 onTap: () {
                        //                   setState(() {
                        //                     buyOrTry = BuyOrTry.tryOn;
                        //                   });
                        //                 },
                        //                 child: Container(
                        //                   decoration: BoxDecoration(
                        //                       border: Border.all(color: Colors.black),
                        //                       color: buyOrTry == BuyOrTry.tryOn
                        //                           ? primaryColor
                        //                           : null),
                        //                   child: Center(
                        //                       child: Text(
                        //                     'Provar',
                        //                     style: TextStyle(
                        //                         color: buyOrTry == BuyOrTry.tryOn
                        //                             ? Colors.white
                        //                             : null),
                        //                   )),
                        //                 ),
                        //               ),
                        //             ),
                        //             Expanded(
                        //               child: GestureDetector(
                        //                 onTap: () {
                        //                   setState(() {
                        //                     buyOrTry = BuyOrTry.buy;
                        //                   });
                        //                 },
                        //                 child: Container(
                        //                   decoration: BoxDecoration(
                        //                       border: Border.all(color: Colors.black),
                        //                       color: buyOrTry == BuyOrTry.buy
                        //                           ? primaryColor
                        //                           : null),
                        //                   child: Center(
                        //                       child: Text(
                        //                     'Comprar',
                        //                     style: TextStyle(
                        //                         color: buyOrTry == BuyOrTry.buy
                        //                             ? Colors.white
                        //                             : null),
                        //                   )),
                        //                 ),
                        //               ),
                        //             )
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        const SizedBox(height: 20),

                        const CartCostSection(),
                        Button1(
                            fontSize: 18,
                            buttonText: 'COMPRAR',
                            buttonColor: primaryColor,
                            onPressFunction: () async {
                              await checkout();
                              // const GetLatitudeLongitudeScreen().launch(context);
                            }),
                        const SizedBox(
                          height: 15,
                        ),
                        Button1(
                            fontSize: 18,
                            buttonText: 'PROVAR',
                            border: true,
                            textColor: Colors.black,
                            buttonColor: Colors.white,
                            onPressFunction: () async {
                              await checkout(buy: false);
                              // const GetLatitudeLongitudeScreen().launch(context);
                            }),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('Para provar em casa antes de comprar')
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> checkout({bool buy = true}) async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user == null) {
      Navigator.of(context).pushNamed('/login', arguments: '/cart');
    } else {
      Navigator.of(context).pushNamed('/checkout');
    }
  }
}
