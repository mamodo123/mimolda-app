import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mimolda/screens/product_detail_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../const/constants.dart';
import '../models/full_store.dart';
import '../models/product.dart';
import '../widgets/cart_icon.dart';
import 'cart_screen.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({super.key});

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  late final TextEditingController fieldText;
  String? searchValue;
  static final List<String> searchHistory = [];
  late final FocusNode focusNode;
  Timer? _debounce;

  void _onTextChanged(String text) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (text.length >= 3) {
        setState(() {
          searchValue = text;
        });
        _debounce?.cancel();
      }
    });
  }

  @override
  void initState() {
    focusNode = FocusNode();
    fieldText = TextEditingController();
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        if (fieldText.text.length >= 3 &&
            (searchHistory.isEmpty || fieldText.text != searchHistory.last)) {
          setState(() {
            searchHistory.remove(fieldText.text);
            searchHistory.insert(0, fieldText.text);
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final fullStore = context.watch<FullStoreNotifier>();
    final cart = context.select<FullStoreNotifier, Iterable<Product>>(
        (value) => value.cart.keys);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
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
            text: 'Busca',
            fontColor: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 18,
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 60,
                width: context.width(),
                decoration: const BoxDecoration(
                  color: secondaryColor3,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(width: 15),
                    const Icon(
                      FeatherIcons.search,
                      color: textColors,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        onChanged: (text) {
                          _onTextChanged(text);
                        },
                        focusNode: focusNode,
                        controller: fieldText,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Buscar produto'),
                        cursorColor: textColors,
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          fieldText.clear();
                          searchValue = null;
                        });
                      },
                      icon: const Icon(
                        Icons.close,
                        color: textColors,
                      ),
                    ),
                    const SizedBox(width: 15),
                  ],
                ),
              ),
              Expanded(
                child: searchValue == null
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const MyGoogleText(
                                  text: 'Buscas recentes',
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  fontColor: Colors.black,
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      searchHistory.clear();
                                    });
                                  },
                                  child: const MyGoogleText(
                                    text: 'Limpar todas',
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                    fontColor: textColors,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ListView.builder(
                                  itemCount: searchHistory.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: GestureDetector(
                                            onTap: () {
                                              fieldText.text =
                                                  searchHistory[index];
                                              setState(() {
                                                searchValue =
                                                    searchHistory[index];
                                                searchHistory
                                                    .remove(fieldText.text);
                                                searchHistory.insert(
                                                    0, fieldText.text);
                                              });
                                            },
                                            child: MyGoogleText(
                                              text: searchHistory[index],
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                              fontColor: textColors,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                searchHistory.removeAt(index);
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.cancel,
                                              color: textColors,
                                            ))
                                      ],
                                    );
                                  }),
                            ),
                          ),
                        ],
                      )
                    : Builder(builder: (context) {
                        final searchlist = fullStore.fullStore.products
                            .where((element) => element.name
                                .toLowerCase()
                                .contains(searchValue!))
                            .toList();
                        return searchlist.isEmpty
                            ? const Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.search,
                                      size: 80,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    MyGoogleText(
                                      text: 'Nenhum item encontrado',
                                      fontSize: 18,
                                      fontColor: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                itemCount: searchlist.length,
                                itemBuilder: (context, index) {
                                  final product = searchlist[index];
                                  final currentVariant = product.variants
                                      .firstWhere(
                                          (element) =>
                                              element.promotionalPrice != null,
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
                                              padding:
                                                  const EdgeInsets.all(4.0),
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
                                                            product
                                                                .images.first),
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
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    if (currentVariant.price !=
                                                        null)
                                                      Row(children: [
                                                        MyGoogleText(
                                                          text:
                                                              '\$${((currentVariant.promotionalPrice ?? product.variants.first.price)! / 100).toStringAsFixed(2)}',
                                                          fontSize: 16,
                                                          fontColor:
                                                              Colors.black,
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
                                                                style:
                                                                    GoogleFonts
                                                                        .dmSans(
                                                                  textStyle:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .lineThrough,
                                                                    color:
                                                                        textColors,
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
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              width: 1,
                                                              color:
                                                                  secondaryColor3),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
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
                                                padding:
                                                    const EdgeInsets.all(20),
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
                              );
                      }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
