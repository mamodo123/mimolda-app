import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:mimolda/models/full_store.dart';
import 'package:mimolda/screens/product_detail_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../const/constants.dart';
import '../models/product.dart';
import '../widgets/cart_icon.dart';
import 'cart_screen.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  double initialRating = 0;

  List<bool> isChecked = [false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    final fullStore = context.watch<FullStoreNotifier>();
    final wishlistString = fullStore.user?.wishlist ?? [];
    final wishlist = fullStore.fullStore.products
        .where((element) => wishlistString.contains(element.id))
        .toList();
    final cart = context.select<FullStoreNotifier, Iterable<Product>>(
        (value) => value.cart.keys);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        // leading: GestureDetector(
        //   onTap: () {
        //     Navigator.pop(context);
        //   },
        //   child: const Icon(
        //     Icons.arrow_back,
        //     color: Colors.black,
        //   ),
        // ),
        title: const MyGoogleText(
          text: 'Lista de desejos',
          fontColor: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 18,
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 20),
        //     child: TextButton(
        //       onPressed: () {},
        //       child: const MyGoogleText(
        //         text: 'Delete',
        //         fontColor: secondaryColor1,
        //         fontWeight: FontWeight.normal,
        //         fontSize: 16,
        //       ),
        //     ),
        //   )
        // ],
      ),
      body: wishlist.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    IconlyLight.heart,
                    size: 80,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MyGoogleText(
                    text: 'Não há itens na sua lista de desejos',
                    fontSize: 18,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 20, bottom: 20),
                    width: context.width(),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: wishlist.length,
                          itemBuilder: (context, index) {
                            final product = wishlist[index];
                            final currentVariant = product.variants.firstWhere(
                                (element) => element.promotionalPrice != null,
                                orElse: () => product.variants.first);
                            return GestureDetector(
                              onTap: () {
                                ProductDetailScreen(product: product)
                                    .launch(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  right: 8,
                                  bottom: 8,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    border: Border.all(
                                      width: 1,
                                      color: secondaryColor3,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Container(
                                          height: 110,
                                          width: 110,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color: secondaryColor3,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(15)),
                                            color: secondaryColor3,
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  currentVariant.image ??
                                                      product.images.first),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              MyGoogleText(
                                                text: product.name,
                                                fontSize: 18,
                                                fontColor: textColors,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              if (currentVariant.price != null)
                                                Row(children: [
                                                  MyGoogleText(
                                                    text:
                                                        '\$${((currentVariant.promotionalPrice ?? product.variants.first.price)! / 100).toStringAsFixed(2)}',
                                                    fontSize: 16,
                                                    fontColor: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                  if (currentVariant
                                                          .promotionalPrice !=
                                                      null)
                                                    Row(
                                                      children: [
                                                        const SizedBox(
                                                            width: 10),
                                                        Text(
                                                          '\$${(currentVariant.price! / 100).toStringAsFixed(2)}',
                                                          style: GoogleFonts
                                                              .dmSans(
                                                            textStyle:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              color: textColors,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                ]),
                                              if (currentVariant
                                                      .promotionalPrice !=
                                                  null)
                                                Container(
                                                  height: 23,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        width: 1,
                                                        color: secondaryColor3),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(15),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: MyGoogleText(
                                                      text:
                                                          '${((currentVariant.promotionalPrice! / currentVariant.price! - 1) * 100).round()}%',
                                                      fontSize: 12,
                                                      fontColor:
                                                          secondaryColor1,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                            ]),
                                      ),
                                      if (cart.contains(product))
                                        Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: CartIcon(
                                            backgroundColor: Colors.white,
                                            iconColor: primaryColor,
                                            size: 30,
                                            iconSize: 30,
                                            onTap: () {
                                              const CartScreen()
                                                  .launch(context);
                                            },
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
