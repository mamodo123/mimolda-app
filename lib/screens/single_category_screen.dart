import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mimolda/widgets/product_greed_view_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../const/constants.dart';
import '../models/full_store.dart';
import '../models/product.dart';
import '../widgets/cart_icon.dart';
import '../widgets/filter_tool_bar.dart';
import 'cart_screen.dart';

class SingleCategoryScreen<T> extends StatefulWidget {
  final String title;
  final List<Product> products;
  final bool Function(Product, T) where;
  final List<T> filters;
  final String Function(T) filterToText;

  const SingleCategoryScreen(
      {super.key,
      required this.title,
      required this.products,
      required this.where,
      required this.filters,
      required this.filterToText});

  @override
  State<SingleCategoryScreen<T>> createState() =>
      _SingleCategoryScreenState<T>();
}

class _SingleCategoryScreenState<T> extends State<SingleCategoryScreen<T>> {
  var currentItem = 0;

  @override
  Widget build(BuildContext context) {
    final fullStore = context.watch<FullStoreNotifier>();
    final totalItemsInCart = fullStore.cartSize;
    return Scaffold(
      //backgroundColor: primaryColor.withOpacity(0.05),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: secondaryColor3,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  FeatherIcons.search,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          CartIcon(
            backgroundColor: secondaryColor3,
            iconColor: Colors.black,
            size: 40,
            onTap: () {
              const CartScreen().launch(context);
            },
            quantity: totalItemsInCart > 0 ? totalItemsInCart : null,
          ),
        ],
        leading: GestureDetector(
          onTap: () {
            finish(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: MyGoogleText(
          text: widget.title,
          fontColor: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 18,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const FilterToolBar(),
            // const SizedBox(height: 20),
            Container(
                padding: const EdgeInsets.only(
                    left: 20, top: 20, bottom: 20, right: 10),
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
                    if (widget.filters.isNotEmpty)
                      HorizontalList(
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                currentItem = index;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 12, bottom: 12),
                              decoration: BoxDecoration(
                                color: currentItem == index
                                    ? primaryColor
                                    : Colors.white,
                                border: Border.all(
                                  width: 1,
                                  color: secondaryColor3,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                              ),
                              child: MyGoogleText(
                                text: index == 0
                                    ? 'Tudo'
                                    : widget.filterToText(
                                        widget.filters[index - 1]),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontColor: currentItem == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          );
                        },
                        itemCount: widget.filters.length + 1,
                      ),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 0.65,
                      ),
                      itemCount: widget.products.length,
                      itemBuilder: (BuildContext ctx, index) {
                        final product = widget.products[index];
                        return ProductGreedShow(
                          isSingleView: false,
                          product: product,
                        );
                      },
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
