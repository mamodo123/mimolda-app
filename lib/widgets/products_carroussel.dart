import 'package:flutter/material.dart';
import 'package:mimolda/widgets/product_greed_view_widget.dart';
import 'package:nb_utils/nb_utils.dart';

import '../const/constants.dart';
import '../models/category.dart';
import '../models/product.dart';
import '../screens/single_category_screen.dart';

class ProductsCarroussel extends StatefulWidget {
  final List<Product> products;
  final String title;

  const ProductsCarroussel(
      {required this.products, required this.title, super.key});

  @override
  State<ProductsCarroussel> createState() => _ProductsCarrousselState();
}

class _ProductsCarrousselState extends State<ProductsCarroussel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyGoogleText(
              text: widget.title,
              fontSize: 16,
              fontColor: Colors.black,
              fontWeight: FontWeight.normal,
            ),
            TextButton(
              onPressed: () {
                SingleCategoryScreen<Category>(
                  title: widget.title,
                  products: widget.products,
                  where: (product, category) {
                    return product.categories.contains(category);
                  },
                  filters: const [],
                  //categories,
                  filterToText: (category) => category.name,
                ).launch(context);
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
            final product = widget.products[index];
            return ProductGreedShow(
              isSingleView: false,
              product: product,
            );
          },
          itemCount: widget.products.length,
        ),
      ],
    );
  }
}
