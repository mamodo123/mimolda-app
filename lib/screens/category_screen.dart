import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mimolda/screens/single_category_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../const/constants.dart';
import '../models/category.dart';
import '../models/full_store.dart';
import '../widgets/category_view.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Color> colors = const [
    Color(0xFFFCF3D7), // Amarelo pálido
    Color(0xFFDCF7E3), // Verde pálido
    Color(0xFFFEE4E2), // Rosa pálido
    Color(0xFFE5EFFF), // Azul pálido
    Color(0xFFDAF5F2), // Azul esverdeado pálido
    Color(0xFFF8E7D1), // Laranja pálido
    Color(0xFFE0F1DB), // Verde claro
    Color(0xFFFADCD9), // Rosa claro
    Color(0xFFD6DFFF), // Azul claro
    Color(0xFFC6EED8), // Verde azulado claro
    Color(0xFFF5F7DC), // Branco amarelado
    Color(0xFFE8F6EE), // Branco esverdeado
    Color(0xFFFCEDEA), // Branco rosado
    Color(0xFFE7EDFF), // Branco azulado
    Color(0xFFF0F8FF), // Branco azul claro
    Color(0xFFF9EBD2), // Bege claro
    Color(0xFFE1F3E0), // Verde pálido
    Color(0xFFF8D7D4), // Rosa pálido
    Color(0xFFD2D9FF), // Azul pálido
    Color(0xFFBBE6D8), // Verde azulado pálido
  ];

  @override
  Widget build(BuildContext context) {
    final storeNotifier = context.watch<FullStoreNotifier>();
    final store = storeNotifier.fullStore;
    final categories = store.categories;
    final products = store.products;
    return Scaffold(
      //backgroundColor: primaryColor.withOpacity(0.05),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Container(
        //       height: 40,
        //       width: 40,
        //       decoration: const BoxDecoration(
        //         color: secondaryColor3,
        //         borderRadius: BorderRadius.all(Radius.circular(30)),
        //       ),
        //       child: IconButton(
        //         onPressed: () {},
        //         icon: const Icon(
        //           FeatherIcons.search,
        //           color: Colors.black,
        //         ),
        //       ),
        //     ),
        //   ),
        // ],
        leading: GestureDetector(
          onTap: () {
            finish(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const MyGoogleText(
          text: 'Categorias',
          fontColor: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 18,
        ),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (_, index) {
                      final category = categories[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: CategoryView(
                          name: category.name,
                          items: totalItemsText(products
                              .where((element) =>
                                  element.categories.contains(category))
                              .length),
                          color: colors[index % colors.length],
                          image: products
                              .firstWhere((element) =>
                                  element.categories.contains(category))
                              .images
                              .first,
                          onTabFunction: () {
                            SingleCategoryScreen<Category>(
                              title: category.name,
                              products: products
                                  .where((element) =>
                                      element.categories.contains(category))
                                  .toList(),
                              where: (product, category) {
                                return product.categories.contains(category);
                              },
                              filters: const [],
                              //categories,
                              filterToText: (category) => category.name,
                            ).launch(context);
                          },
                        ),
                      );
                    })),
          ),
        ],
      ),
    );
  }

  String totalItemsText(int total) {
    return '$total ${total == 1 ? 'item' : 'itens'}';
  }
}
