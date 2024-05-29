import 'package:flutter/material.dart';
import 'package:mimolda/models/full_store.dart';
import 'package:mimolda/screens/category_screen.dart';
import 'package:mimolda/screens/single_category_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../../const/constants.dart';
import '../../../models/category.dart';

class CategoriesSection extends StatefulWidget {
  const CategoriesSection({super.key});

  @override
  State<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  @override
  Widget build(BuildContext context) {
    final store = context.watch<FullStoreNotifier>();
    final products = store.fullStore.products;
    final categories = store.fullStore.categories;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const MyGoogleText(
              text: 'Categorias',
              fontSize: 16,
              fontColor: Colors.black,
              fontWeight: FontWeight.normal,
            ),
            TextButton(
              onPressed: () {
                const CategoryScreen().launch(context);
              },
              child: const MyGoogleText(
                text: 'Mostrar todas',
                fontSize: 13,
                fontColor: textColors,
                fontWeight: FontWeight.normal,
              ),
            )
          ],
        ),
        HorizontalList(
          spacing: 20,
          itemBuilder: (BuildContext context, int index) {
            final category = categories[index];
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    SingleCategoryScreen<Category>(
                      title: category.name,
                      products: products
                          .where((element) => element.categories.contains(category))
                          .toList(),
                      where: (product, category) {
                        return product.categories.contains(category);
                      },
                      filters: const [],
                      //categories,
                      filterToText: (category) => category.name,
                    ).launch(context);
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(products
                              .firstWhere((element) =>
                                  element.categories.contains(category))
                              .images
                              .first),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter),
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      border: Border.all(
                        width: 1,
                        color: secondaryColor3,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyGoogleText(
                  text: category.name,
                  fontSize: 13,
                  fontColor: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ],
            );
          },
          itemCount: categories.length,
        ),
      ],
    );
  }
}
