import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mimolda/models/full_store.dart';
import 'package:mimolda/screens/cart_screen.dart';
import 'package:mimolda/screens/product_detail_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../const/constants.dart';
import '../models/product.dart';
import 'cart_icon.dart';

class ProductGreedShow extends StatefulWidget {
  const ProductGreedShow({
    super.key,
    required this.isSingleView,
    required this.product,
  });

  final bool isSingleView;
  final Product product;

  @override
  State<ProductGreedShow> createState() => _ProductGreedShowState();
}

class _ProductGreedShowState extends State<ProductGreedShow> {
  bool isFavorite = false;
  double initialRating = 0;
  late double rating;

  @override
  Widget build(BuildContext context) {
    final cart = context.select<FullStoreNotifier, Iterable<Product>>(
        (value) => value.cart.keys);
    final currentVariant = widget.product.variants.firstWhere(
            (element) => element.promotionalPrice != null,
        orElse: () => widget.product.variants.first);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: secondaryColor3,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              widget.isSingleView
                  ? GestureDetector(
                      onTap: () {
                        ProductDetailScreen(product: widget.product)
                            .launch(context);
                      },
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(8),
                            topLeft: Radius.circular(8),
                          ),
                          color: secondaryColor3,
                          image: DecorationImage(
                            image: NetworkImage(
                                currentVariant.image ?? widget.product.images.first),
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        ProductDetailScreen(
                          product: widget.product,
                        ).launch(context);
                      },
                      child: Container(
                        height: 221,
                        width: 187,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(8),
                            topLeft: Radius.circular(8),
                          ),
                          color: secondaryColor3,
                          image: DecorationImage(
                            image: NetworkImage(
                                currentVariant.image ?? widget.product.images.first),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
              // Positioned(
              //   right: 8,
              //   top: 8,
              //   child: GestureDetector(
              //     onTap: () {
              //       setState(() {
              //         isFavorite = !isFavorite;
              //       });
              //     },
              //     child: Container(
              //       height: 35,
              //       width: 35,
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         border: Border.all(
              //           width: 1,
              //           color: primaryColor.withOpacity(0.05),
              //         ),
              //         borderRadius: const BorderRadius.all(
              //           Radius.circular(30),
              //         ),
              //       ),
              //       child: isFavorite
              //           ? const Center(
              //               child: Icon(
              //                 Icons.favorite,
              //                 color: secondaryColor1,
              //               ),
              //             )
              //           : const Center(child: Icon(Icons.favorite_border)),
              //     ),
              //   ),
              // ),
              if (currentVariant.promotionalPrice != null)
                Positioned(
                  left: 7,
                  top: 10,
                  child: Container(
                    height: 23,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: secondaryColor3),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Center(
                      child: MyGoogleText(
                        text:
                            '${((currentVariant.promotionalPrice! / currentVariant.price! - 1) * 100).round()}%',
                        fontSize: 12,
                        fontColor: secondaryColor1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              if (cart.contains(widget.product))
                CartIcon(
                  backgroundColor: Colors.white,
                  iconColor: primaryColor,
                  onTap: () {
                    const CartScreen().launch(context);
                  },
                ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 15, top: 5, right: 15, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyGoogleText(
                  text: widget.product.name,
                  fontSize: 13,
                  fontColor: textColors,
                  fontWeight: FontWeight.normal,
                ),
                if (currentVariant.price != null)
                  Row(
                    children: [
                      MyGoogleText(
                        text:
                            '\$${((currentVariant.promotionalPrice ?? widget.product.variants.first.price)! / 100).toStringAsFixed(2)}',
                        fontSize: 16,
                        fontColor: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      if (currentVariant.promotionalPrice !=
                          null)
                        Row(
                          children: [
                            const SizedBox(width: 10),
                            Text(
                              '\$${(currentVariant.price! / 100).toStringAsFixed(2)}',
                              style: GoogleFonts.dmSans(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  decoration: TextDecoration.lineThrough,
                                  color: textColors,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 5),
                //   child: Row(
                //     children: [
                //       RatingBarWidget(
                //         rating: initialRating,
                //         activeColor: ratingColor,
                //         inActiveColor: ratingColor,
                //         size: 18,
                //         onRatingChanged: (aRating) {
                //           setState(() {
                //             initialRating = aRating;
                //           });
                //         },
                //       ),
                //       const SizedBox(
                //         width: 7,
                //       ),
                //       Container(
                //         height: 35,
                //         width: 35,
                //         decoration: BoxDecoration(
                //           color: primaryColor.withOpacity(0.05),
                //           borderRadius:
                //               const BorderRadius.all(Radius.circular(30)),
                //         ),
                //         child: const Center(
                //             child: Icon(
                //           IconlyLight.bag,
                //           color: primaryColor,
                //         )),
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}
