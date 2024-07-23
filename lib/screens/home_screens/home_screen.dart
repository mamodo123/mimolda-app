import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mimolda/models/full_store.dart';
import 'package:mimolda/screens/home_screens/sections/categories.dart';
import 'package:mimolda/screens/search_product_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../const/constants.dart';
import '../../widgets/products_carroussel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final offerImages = [
    'images/offer_image.png',
    'images/offer_image.png',
    'images/offer_image.png',
  ];
  final categoryImages = [
    'images/c1.png',
    'images/woman.png',
    'images/c1.png',
    'images/c1.png',
    'images/c1.png',
    'images/c1.png',
    'images/c1.png',
    'images/c1.png',
  ];
  final categoryNameText = [
    'Men',
    'Women',
    'Kids',
    'Sports',
    'Demo',
    'Demo',
    'Demo',
    'Demo',
  ];

  @override
  Widget build(BuildContext context) {
    final fullStoreNotifier = context.watch<FullStoreNotifier>();
    final fullStore = fullStoreNotifier.fullStore;
    // final products = fullStore.products;
    final promotionalProducts = fullStore.promotionalProducts;
    final bestSelling = fullStore.bestSelling;
    final news = fullStore.news;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        titleSpacing: 0.0,
        title: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: MyGoogleText(
            text: fullStoreNotifier.store.storeName,
            fontSize: 20,
            fontColor: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        // leading: Padding(
        //   padding: const EdgeInsets.all(4),
        //   child: GestureDetector(
        //     onTap: () {
        //       const ProfileScreen().launch(context);
        //     },
        //     child: Padding(
        //       padding: const EdgeInsets.all(4.0),
        //       child: Container(
        //         decoration: const BoxDecoration(
        //           borderRadius: BorderRadius.all(
        //             Radius.circular(30),
        //           ),
        //         ),
        //         child: const Image(
        //           image: AssetImage(
        //             'images/profile_image.png',
        //           ),
        //           fit: BoxFit.fitHeight,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
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
                onPressed: () {
                  const SearchProductScreen().launch(context);
                },
                icon: const Icon(
                  FeatherIcons.search,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Container(
          //     height: 40,
          //     width: 40,
          //     decoration: const BoxDecoration(
          //       color: secondaryColor3,
          //       borderRadius: BorderRadius.all(Radius.circular(30)),
          //     ),
          //     child: IconButton(
          //       onPressed: () {
          //         const NotificationsScreen().launch(context);
          //       },
          //       icon: const Icon(
          //         FeatherIcons.bell,
          //         color: Colors.black,
          //       ),
          //     ),
          //   ),
          // ),
          const SizedBox(width: 8.0),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15, top: 15),
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
                  const CategoriesSection(),
                  if (promotionalProducts.isNotEmpty)
                    ProductsCarroussel(
                        products: promotionalProducts, title: 'Promoções'),
                  if (bestSelling.isNotEmpty)
                    ProductsCarroussel(
                        products: bestSelling, title: 'Mais vendidas'),
                  if (news.isNotEmpty)
                    ProductsCarroussel(products: news, title: 'Novidades')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
