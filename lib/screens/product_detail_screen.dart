import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mimolda/const/constants.dart';
import 'package:mimolda/models/full_store.dart';
import 'package:mimolda/models/product.dart';
import 'package:mimolda/screens/cart_screen.dart';
import 'package:mimolda/widgets/buttons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../const/values.dart';
import '../data_manager/user.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({required this.product, super.key});

  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  PageController pageController = PageController(initialPage: 1);

  Variant? variant;
  Map<String, String>? errorMap;

  @override
  void initState() {
    variant = widget.product.variants.firstWhere(
        (element) => element.promotionalPrice != null,
        orElse: () => widget.product.variants.first);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final attributesMap = getAttributesMap(product);
    final fullStore = context.watch<FullStoreNotifier>();
    return Scaffold(
      backgroundColor: secondaryColor3,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            ///_____________Photo & Buttons_________________________
            Stack(
              children: [
                ///_______Photos____________
                Center(
                  child: CarouselSlider.builder(
                    itemCount: product.images.length,
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 5),
                      height: 400,
                      aspectRatio: 1,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      onPageChanged: null,
                      scrollDirection: Axis.horizontal,
                    ),
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                        Container(
                            color: secondaryColor3,
                            width: double.infinity,
                            child: Image(
                                image:
                                    NetworkImage(product.images[itemIndex]))),
                  ),
                ),

                ///__________BackButton__________________________________________________
                Positioned(
                  left: 10,
                  top: 20,
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                ),
                if (fullStore.user != null)
                  Positioned(
                    right: 10,
                    top: 20,
                    child: Center(
                      child: IconButton(
                        onPressed: () async {
                          final favorite = await itemWishlist(product);
                          if (favorite != null) {
                            await fullStore.reloadWishlist();
                          }
                        },
                        icon: fullStore.user!.wishlist.contains(product.id)
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 40,
                              )
                            : const Icon(
                                Icons.favorite_border_outlined,
                                size: 40,
                              ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 20, top: 20, bottom: 20, right: 20),
              width: double.infinity,
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
                  MyGoogleText(
                    text: product.name,
                    fontSize: 20,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                  variant == null
                      ? const MyGoogleText(
                          text: 'Esgotado',
                          fontSize: 16,
                          fontColor: Colors.black,
                          fontWeight: FontWeight.normal,
                        )
                      : variant!.price == null
                          ? Container()
                          : Row(
                              children: [
                                MyGoogleText(
                                  text:
                                      '\$${((variant!.promotionalPrice ?? variant!.price)! / 100).toStringAsFixed(2)}',
                                  fontSize: 16,
                                  fontColor: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                                if (variant!.promotionalPrice != null)
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 10),
                                        Text(
                                          '\$${(variant!.price! / 100).toStringAsFixed(2)}',
                                          style: GoogleFonts.dmSans(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: textColors,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          height: 30,
                                          width: 60,
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
                                                  '${((variant!.promotionalPrice! / variant!.price! - 1) * 100).round()}%',
                                              fontSize: 14,
                                              fontColor: secondaryColor1,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 15),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                  const SizedBox(height: 30),
                  if (attributesMap.isNotEmpty)
                    Column(
                      children: [
                        Column(
                          children: attributesMap.entries.map<Widget>((entry) {
                            final items = entry.value.toList();
                            if (entry.key == 'Tamanho') {
                              items.sort((value1, value2) {
                                final indexValue1 = sizes.contains(value1)
                                    ? sizes.indexOf(value1)
                                    : sizes.length;
                                final indexValue2 = sizes.contains(value2)
                                    ? sizes.indexOf(value2)
                                    : sizes.length;
                                return indexValue1 - indexValue2;
                              });
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyGoogleText(
                                  text: entry.key,
                                  fontSize: 16,
                                  fontColor: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 55,
                                  child: ListView.builder(
                                    itemCount: items.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, i) {
                                      final item = items[i];
                                      final isCurrentItem =
                                          (variant?.attributes ??
                                                  errorMap)?[entry.key] ==
                                              item;
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            final newVariantMap =
                                                Map.fromEntries(
                                                    (variant?.attributes ??
                                                            errorMap)!
                                                        .entries)
                                                  ..[entry.key] = item;
                                            setState(() {
                                              final newVariant = product
                                                  .variants
                                                  .firstWhereOrNull((element) =>
                                                      mapEquals(
                                                          element.attributes,
                                                          newVariantMap));
                                              setState(() {
                                                if (newVariant == null) {
                                                  errorMap = newVariantMap;
                                                }
                                                variant = newVariant;
                                              });
                                              // if (newVariant == null) {
                                              //   final snackBar = SnackBar(
                                              //     duration: const Duration(
                                              //         seconds: 1),
                                              //     content: Text(
                                              //         'Produto esgotado (${newVariantMap.values.join(' ')})'),
                                              //     behavior: SnackBarBehavior
                                              //         .floating,
                                              //   );
                                              //   ScaffoldMessenger.of(context)
                                              //       .showSnackBar(snackBar);
                                              // } else {
                                              //   setState(() {
                                              //     variant = newVariant;
                                              //   });
                                              // }
                                            });
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            padding: ['Cor', 'Tamanho']
                                                    .contains(entry.key)
                                                ? null
                                                : const EdgeInsets.all(5),
                                            width: ['Cor', 'Tamanho']
                                                    .contains(entry.key)
                                                ? 40
                                                : null,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular([
                                                  'Cor',
                                                  'Tamanho'
                                                ].contains(entry.key)
                                                    ? 20
                                                    : 10),
                                              ),
                                              color: entry.key == 'Cor' &&
                                                      colors.containsKey(item)
                                                  ? colors[item]
                                                  : isCurrentItem
                                                      ? secondaryColor1
                                                      : secondaryColor3,
                                            ),
                                            child: entry.key == 'Cor'
                                                ? isCurrentItem
                                                    ? const Center(
                                                        child: Icon(
                                                        Icons.check,
                                                        color: Colors.white,
                                                      ))
                                                    : Container()
                                                : Center(
                                                    child: MyGoogleText(
                                                      text: items[i],
                                                      fontSize: 18,
                                                      fontColor: isCurrentItem
                                                          ? Colors.white
                                                          : textColors,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        )
                      ],
                    ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     const MyGoogleText(
                  //       text: 'Quantidade',
                  //       fontSize: 16,
                  //       fontColor: Colors.black,
                  //       fontWeight: FontWeight.normal,
                  //     ),
                  //     const SizedBox(height: 10),
                  //     SizedBox(
                  //       height: 55,
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Row(
                  //           mainAxisSize: MainAxisSize.min,
                  //           children: [
                  //             GestureDetector(
                  //               onTap: () {
                  //                 setState(() {
                  //                   initialValueFromText > 1
                  //                       ? initialValueFromText--
                  //                       : null;
                  //                 });
                  //               },
                  //               child: Material(
                  //                 elevation: 4,
                  //                 color: secondaryColor3,
                  //                 borderRadius: BorderRadius.circular(30),
                  //                 child: const SizedBox(
                  //                   width: 33,
                  //                   height: 33,
                  //                   child: Center(
                  //                     child: Icon(FeatherIcons.minus,
                  //                         size: 25, color: textColors),
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //             const SizedBox(
                  //               width: 10,
                  //             ),
                  //             Text(
                  //               initialValueFromText.toString(),
                  //               style: GoogleFonts.dmSans(fontSize: 18),
                  //             ),
                  //             const SizedBox(
                  //               width: 10,
                  //             ),
                  //             GestureDetector(
                  //               onTap: () {
                  //                 setState(() {
                  //                   initialValueFromText++;
                  //                 });
                  //               },
                  //               child: Material(
                  //                 elevation: 4,
                  //                 color: secondaryColor3,
                  //                 borderRadius: BorderRadius.circular(30),
                  //                 child: const SizedBox(
                  //                   width: 33,
                  //                   height: 33,
                  //                   child: Center(
                  //                     child: Icon(Icons.add,
                  //                         size: 25, color: textColors),
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 8,
                  ),

                  ///_____________Description________________________________
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: textColors),
                      ),
                    ),
                    child: ExpansionTile(
                      title: const Text('Descrição'),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8, bottom: 8),
                          child: Html(
                            data: product.description,
                            style: {'p': Style(color: textColors)},
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),

                  ///_____________Delivery & Services__________________________
                  const MyGoogleText(
                    text: 'Entrega e Serviços',
                    fontSize: 16,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                color: secondaryColor1.withOpacity(.20),
                              ),
                              child: const Center(
                                  child: Icon(
                                FeatherIcons.truck,
                                size: 18,
                              )),
                            ),
                            const SizedBox(width: 8),
                            const MyGoogleText(
                              text: 'Receba em casa ou busque na loja',
                              fontSize: 16,
                              fontColor: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ],
                        ),
                      ),
                      if (fullStore.store.tryItAtHome)
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30)),
                                  color: secondaryColor1.withOpacity(.20),
                                ),
                                child: const Center(
                                    child: Icon(
                                  FeatherIcons.home,
                                  size: 18,
                                )),
                              ),
                              const SizedBox(width: 8),
                              const MyGoogleText(
                                text: 'Prove em casa antes de comprar',
                                fontSize: 16,
                                fontColor: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ],
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                color: secondaryColor1.withOpacity(.20),
                              ),
                              child: const Center(
                                  child: Icon(
                                FeatherIcons.heart,
                                size: 18,
                              )),
                            ),
                            const SizedBox(width: 8),
                            const Flexible(
                              child: MyGoogleText(
                                text:
                                    'Adicione produtos na sua lista de desejos',
                                fontSize: 16,
                                fontColor: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 10),
                  //
                  // ///__________________Related Products____________________________
                  // const MyGoogleText(
                  //   text: 'Related Products',
                  //   fontSize: 16,
                  //   fontColor: Colors.black,
                  //   fontWeight: FontWeight.normal,
                  // ),
                  // const SizedBox(height: 15),
                  // HorizontalList(
                  //     itemCount: 20,
                  //     itemBuilder: (_, index) {
                  //       return const Padding(
                  //         padding: EdgeInsets.only(right: 15),
                  //         child: ProductGreedShow(
                  //           image: 'images/woman.png',
                  //           productTitle: 'Blazer Trousers Suit',
                  //           productPrice: '33.30',
                  //           discountPercentage: '-30%',
                  //           isSingleView: false,
                  //         ),
                  //       );
                  //     }),
                ],
              ),
            ),
          ],
        )),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: secondaryColor3,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Colors.white),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 25, bottom: 30, left: 15, right: 15),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Expanded(
                //   child: Button1(
                //       buttonText: 'Comprar agora',
                //       buttonColor: primaryColor,
                //       onPressFunction: () =>
                //           const CartScreen().launch(context)),
                // ),
                // const SizedBox(width: 10),
                Expanded(
                  child: ButtonType2(
                      buttonText: variant == null
                          ? 'Esgotado (${errorMap?.values.join(' ')})'
                          : 'Adicionar ao carrinho',
                      buttonColor: primaryColor,
                      onPressFunction: variant == null
                          ? null
                          : () {
                              final fullStore =
                                  context.read<FullStoreNotifier>();
                              fullStore.addToCart(product, variant!);
                              const CartScreen().launch(context);
                            }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Map<String, Set<String>> getAttributesMap(Product product) {
    final attributesMap = Map.fromIterables(product.attributes,
        List.generate(product.attributes.length, (_) => <String>{}));
    for (final variant in product.variants) {
      for (final entry in variant.attributes.entries) {
        final attributeArray = attributesMap[entry.key];
        attributeArray?.add(entry.value);
      }
    }
    return attributesMap;
  }
}
