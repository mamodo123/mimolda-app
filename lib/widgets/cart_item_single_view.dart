import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mimolda/const/values.dart';
import 'package:mimolda/models/full_store.dart';
import 'package:mimolda/models/order.dart';
import 'package:mimolda/models/product.dart';
import 'package:mimolda/widgets/quantity_counter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../const/constants.dart';
import 'delete_product_dialog.dart';

class CartItemsSingleView extends StatefulWidget {
  final Product product;
  final Variant variant;
  final int total;

  const CartItemsSingleView(this.product, this.variant, this.total,
      {super.key});

  @override
  State<CartItemsSingleView> createState() => _CartItemsSingleViewState();
}

class _CartItemsSingleViewState extends State<CartItemsSingleView> {
  @override
  Widget build(BuildContext context) {
    final variant = widget.variant;
    // final variantName = variant.attributes.values.join(' ');

    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        right: 8,
        bottom: 8,
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(
              width: 1,
              color: secondaryColor3,
            )),
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
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: secondaryColor3,
                  image: DecorationImage(
                      image: NetworkImage(variant.image ?? ''),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: MyGoogleText(
                      text: widget.product.name,
                      // '${widget.product.name}${variantName == '' ? '' : ' ($variantName)'}',
                      fontSize: 16,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    width: context.width() / 2,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: List.generate(
                            (variant.attributes.length / 2).round(), (index) {
                          final currentIndex = index * 2;
                          final item1 =
                              variant.attributes.entries.toList()[currentIndex];
                          final item2 =
                              currentIndex + 1 < variant.attributes.length
                                  ? variant.attributes.entries
                                      .toList()[currentIndex + 1]
                                  : null;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              getAttributeWidget(item1.key, item1.value,
                                  MainAxisAlignment.start),
                              item2 == null
                                  ? Container()
                                  : getAttributeWidget(item2.key, item2.value,
                                      MainAxisAlignment.end),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: context.width() / 2,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (variant.price != null)
                            Column(
                              children: [
                                if (variant.promotionalPrice != null)
                                  Text(
                                    '\$${(variant.price! / 100).toStringAsFixed(2)}',
                                    style: GoogleFonts.dmSans(
                                      textStyle: const TextStyle(
                                        fontSize: 10,
                                        decoration: TextDecoration.lineThrough,
                                        color: textColors,
                                      ),
                                    ),
                                  ),
                                MyGoogleText(
                                  text:
                                      '\$${((variant.promotionalPrice ?? variant.price)! / 100).toStringAsFixed(2)}',
                                  fontSize: 16,
                                  fontColor: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ],
                            ),
                          const Spacer(),
                          QuantityCounter(
                              value: widget.total,
                              sizeOfButtons: 22,
                              valueUpdate: (newValue) async {
                                final fullStore =
                                    context.read<FullStoreNotifier>();
                                if (newValue <= 0) {
                                  final variantName =
                                      variant.attributes.values.join(' ');
                                  final delete = await deleteProductDialog(
                                      context,
                                      '${widget.product.name}${variantName == '' ? '' : ' ($variantName)'}');
                                  if (delete == true) {
                                    fullStore.removeFromCart(
                                        widget.product, variant);
                                  }
                                } else {
                                  fullStore.addToCart(widget.product, variant,
                                      quantity: newValue);
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getAttributeWidget(
      String attribute, String value, MainAxisAlignment alignment) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: alignment,
      children: [
        MyGoogleText(
          text: '$attribute:',
          fontSize: 12,
          fontColor: Colors.black,
          fontWeight: FontWeight.normal,
        ),
        const SizedBox(width: 5),
        attribute == 'Cor' && colors.containsKey(value)
            ? Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    color: colors[value]!),
              )
            : MyGoogleText(
                text: value,
                fontSize: 14,
                fontColor: Colors.red,
                fontWeight: FontWeight.normal,
              ),
      ],
    );
  }
}

class CartOrderItemsSingleView extends StatefulWidget {
  final ProductOrder product;
  final int value;
  final void Function(int) onUpdate;
  final bool hideMinus, hidePlus;

  const CartOrderItemsSingleView(this.product, this.value, this.onUpdate,
      {super.key, this.hideMinus = false, this.hidePlus = false});

  @override
  State<CartOrderItemsSingleView> createState() =>
      _CartOrderItemsSingleViewState();
}

class _CartOrderItemsSingleViewState extends State<CartOrderItemsSingleView> {
  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        right: 8,
        bottom: 8,
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(
              width: 1,
              color: secondaryColor3,
            )),
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
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: secondaryColor3,
                  image: DecorationImage(
                      image: NetworkImage(product.image ?? ''),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: MyGoogleText(
                      text: product.product,
                      // '${widget.product.name}${variantName == '' ? '' : ' ($variantName)'}',
                      fontSize: 16,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    width: context.width() / 2,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: List.generate(
                            (product.attributes.length / 2).round(), (index) {
                          final currentIndex = index * 2;
                          final item1 =
                              product.attributes.entries.toList()[currentIndex];
                          final item2 =
                              currentIndex + 1 < product.attributes.length
                                  ? product.attributes.entries
                                      .toList()[currentIndex + 1]
                                  : null;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              getAttributeWidget(item1.key, item1.value,
                                  MainAxisAlignment.start),
                              item2 == null
                                  ? Container()
                                  : getAttributeWidget(item2.key, item2.value,
                                      MainAxisAlignment.end),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: context.width() / 2,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (product.price != null)
                            Column(
                              children: [
                                if (product.promotionalPrice != null)
                                  Text(
                                    '\$${(product.price! / 100).toStringAsFixed(2)}',
                                    style: GoogleFonts.dmSans(
                                      textStyle: const TextStyle(
                                        fontSize: 10,
                                        decoration: TextDecoration.lineThrough,
                                        color: textColors,
                                      ),
                                    ),
                                  ),
                                MyGoogleText(
                                  text:
                                      '\$${((product.promotionalPrice ?? product.price)! / 100).toStringAsFixed(2)}',
                                  fontSize: 16,
                                  fontColor: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ],
                            ),
                          const Spacer(),
                          QuantityCounter(
                              value: widget.value,
                              hideMinus: widget.hideMinus,
                              hidePlus: widget.hidePlus,
                              sizeOfButtons: 22,
                              valueUpdate: widget.onUpdate),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getAttributeWidget(
      String attribute, String value, MainAxisAlignment alignment) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: alignment,
      children: [
        MyGoogleText(
          text: '$attribute:',
          fontSize: 12,
          fontColor: Colors.black,
          fontWeight: FontWeight.normal,
        ),
        const SizedBox(width: 5),
        attribute == 'Cor' && colors.containsKey(value)
            ? Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    color: colors[value]!),
              )
            : MyGoogleText(
                text: value,
                fontSize: 14,
                fontColor: Colors.red,
                fontWeight: FontWeight.normal,
              ),
      ],
    );
  }
}

class ProductOrderItemSingleView extends StatelessWidget {
  final ProductOrder product;

  const ProductOrderItemSingleView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        right: 8,
        bottom: 8,
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(
              width: 1,
              color: secondaryColor3,
            )),
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
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: secondaryColor3,
                  image: DecorationImage(
                      image: NetworkImage(product.image ?? ''),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: MyGoogleText(
                      text: product.product,
                      // '${widget.product.name}${variantName == '' ? '' : ' ($variantName)'}',
                      fontSize: 16,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    width: context.width() / 2,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: List.generate(
                            (product.attributes.length / 2).round(), (index) {
                          final currentIndex = index * 2;
                          final item1 =
                              product.attributes.entries.toList()[currentIndex];
                          final item2 =
                              currentIndex + 1 < product.attributes.length
                                  ? product.attributes.entries
                                      .toList()[currentIndex + 1]
                                  : null;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              getAttributeWidget(item1.key, item1.value,
                                  MainAxisAlignment.start),
                              item2 == null
                                  ? Container()
                                  : getAttributeWidget(item2.key, item2.value,
                                      MainAxisAlignment.end),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: context.width() / 2,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (product.price != null)
                            Column(
                              children: [
                                if (product.promotionalPrice != null)
                                  Text(
                                    '\$${(product.price! / 100).toStringAsFixed(2)}',
                                    style: GoogleFonts.dmSans(
                                      textStyle: const TextStyle(
                                        fontSize: 10,
                                        decoration: TextDecoration.lineThrough,
                                        color: textColors,
                                      ),
                                    ),
                                  ),
                                MyGoogleText(
                                  text:
                                      '\$${((product.promotionalPrice ?? product.price)! / 100).toStringAsFixed(2)}',
                                  fontSize: 16,
                                  fontColor: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ],
                            ),
                          const Spacer(),
                          MyGoogleText(
                            text: 'Quantidade: ${product.quantity}',
                            fontSize: 14,
                            fontColor: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getAttributeWidget(
      String attribute, String value, MainAxisAlignment alignment) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: alignment,
      children: [
        MyGoogleText(
          text: '$attribute:',
          fontSize: 12,
          fontColor: Colors.black,
          fontWeight: FontWeight.normal,
        ),
        const SizedBox(width: 5),
        attribute == 'Cor' && colors.containsKey(value)
            ? Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    color: colors[value]!),
              )
            : MyGoogleText(
                text: value,
                fontSize: 14,
                fontColor: Colors.red,
                fontWeight: FontWeight.normal,
              ),
      ],
    );
  }
}
