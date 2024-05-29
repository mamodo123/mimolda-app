import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:mimolda/screens/category_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../const/constants.dart';
import '../best_seller_screen.dart';


class GroceryHomeScreen extends StatefulWidget {
  const GroceryHomeScreen({Key? key}) : super(key: key);

  @override
  State<GroceryHomeScreen> createState() => _GroceryHomeScreenState();
}

class _GroceryHomeScreenState extends State<GroceryHomeScreen> {
  int productCount = 1;

  String selectedProduct = '';

  List<String> bannerList = [
    'images/grocery/banner3.png',
    'images/grocery/banner4.png',
    'images/grocery/banner3.png',
    'images/grocery/banner4.png',
  ];

  List<String> categoryImage = [
    'images/grocery/fruits.png',
    'images/grocery/meat.png',
    'images/grocery/vegetable.png',
    'images/grocery/fish.png',
    'images/grocery/fruits.png',
    'images/grocery/meat.png',
    'images/grocery/vegetable.png',
    'images/grocery/fish.png',
  ];
  List<String> categoryList = [
    'Fruits',
    'Meat',
    'Vegetable',
    'Fish',
    'Fruits',
    'Meat',
    'Vegetable',
    'Fish',
  ];
  List<String> saleFruitsList = [
    'images/grocery/fruits2.png',
    'images/grocery/fruits3.png',
    'images/grocery/fruits2.png',
    'images/grocery/fruits3.png',
  ];
  List<String> saleFruitstitle = [
    'Salad with herbs\nspices 50g',
    'Fruits pineapple,\nkiwi, mango',
    'Salad with herbs\nspicess 50g',
    'Fruits pineapple,\nki wi, mango',
  ];
  List<String> saleFruitsPrice = [
    '\$65.00',
    '\$70.00',
    '\$65.00',
    '\$70.00',
  ];
  List<String> saleFruitsMainPrice = [
    '\$85.00',
    '\$100.00',
    '\$85.00',
    '\$100.00',
  ];
  List<String> salePercentage = [
    '15%',
    '30%',
    '15%',
    '30%',
  ];

  List<String> popularFruitsList = [
    'images/grocery/meat2.png',
    'images/grocery/vegetable2.png',
    'images/grocery/fruit2.png',
    'images/grocery/juice.png',
  ];

  List<String> popularProductTitle = [
    'Salad with herbs spices 50g',
    'Fresh vegetables spices 50g',
    'Fruits and berries \nbanners.',
    'Natural papaya juice \ndrink',
  ];

  List<String> salesPercentage = [
    '15%',
    '30%',
    '15%',
    '30%',
  ];

  List<String> popularFruitsPrice = [
    '\$65.00',
    '\$70.00',
    '\$65.00',
    '\$70.00',
  ];
  List<String> popularFruitsMainPrice = [
    '\$85.00',
    '\$100.00',
    '\$85.00',
    '\$100.00',
  ];

  List<Color> colorList = [
    const Color(0xFFFFE7C3),
    const Color(0xFFFFD9DD),
    const Color(0xFFD2F3D3),
    const Color(0xFFFFF8B9),
    const Color(0xFFFFE7C3),
    const Color(0xFFFFD9DD),
    const Color(0xFFD2F3D3),
    const Color(0xFFFFF8B9),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: groceryMainColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: ListTile(
            minVerticalPadding: 0,
            contentPadding: EdgeInsets.zero,
            leading: const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(
                'images/grocery/profile2.png',
              ),
            ),
            title: Text(
              'Hello, Sahidul',
              style: kTextStyle.copyWith(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'What would you buy today?',
              style: kTextStyle.copyWith(
                color: groceryTextColor.withOpacity(0.8),
              ),
            ),
            trailing: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(color: groceryTextColor),
              ),
              child: const Icon(
                FeatherIcons.bell,
                color: groceryTextColor,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: groceryMainColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: ListTile(
                      leading: const Icon(FeatherIcons.search),
                      horizontalTitleGap: 2,
                      title: AppTextField(
                        showCursor: false,
                        cursorColor: Colors.black,
                        textFieldType: TextFieldType.NAME,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                              left: 5.0,
                            ),
                            hintText: ('Search your food'),
                            hintStyle: kTextStyle.copyWith(
                                color: groceryGreyTextColor),
                            border: InputBorder.none,
                            fillColor: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                color: Colors.white,
              ),
              width: context.width(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10.0),
                    HorizontalList(
                      padding: EdgeInsets.zero,
                      spacing: 10.0,
                      itemCount: bannerList.length,
                      itemBuilder: (_, i) {
                        return Image.asset(bannerList[i]);
                      },
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        Text(
                          'Categories',
                          style: kTextStyle.copyWith(
                              color: kTitleColor, fontSize: 18.0),
                        ),
                        const Spacer(),
                        Text(
                          'See All',
                          style:
                              kTextStyle.copyWith(color: groceryGreyTextColor),
                        ).onTap(() => const CategoryScreen().launch(context)),
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    HorizontalList(
                      padding: EdgeInsets.zero,
                      spacing: 10.0,
                      itemCount: categoryImage.length,
                      itemBuilder: (_, i) {
                        return Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: colorList[i],
                          ),
                          child: Column(
                            children: [
                              Center(
                                child: Image(
                                  image: AssetImage(
                                    categoryImage[i],
                                  ),
                                  width: 40.0,
                                  height: 40.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  categoryList[i],
                                  style: kTextStyle.copyWith(color: kTitleColor),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      'Flash Sale',
                      style: kTextStyle.copyWith(
                          color: kTitleColor, fontSize: 18.0),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Text(
                          'Closing In:',
                          style: kTextStyle.copyWith(
                              color: groceryGreyTextColor, fontSize: 18.0),
                        ),
                        const SizedBox(width: 4.0),
                        const SlideCountdownSeparated(
                          decoration: BoxDecoration(
                            color: groceryMainColor,
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          duration: Duration(days: 2),
                        ),
                        const Spacer(),
                        Text(
                          'See All',
                          style: kTextStyle.copyWith(
                            color: groceryGreyTextColor,
                          ),
                        ).onTap(() => const BestSellerScreen().launch(context)),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    HorizontalList(
                      padding: EdgeInsets.zero,
                      spacing: 10.0,
                      itemCount: bannerList.length,
                      itemBuilder: (_, i) {
                        return Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: groceryGreyTextColor.withOpacity(.30),
                                ),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    Image(
                                      image: AssetImage(saleFruitsList[i]),
                                      width: context.width() / 2.5,
                                      height: 100.0,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(height: 10.0),
                                    Text(
                                      saleFruitstitle[i],
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 5.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          saleFruitsPrice[i],
                                          style: kTextStyle.copyWith(
                                              color: groceryMainColor),
                                        ),
                                        const SizedBox(width: 5.0),
                                        Text(
                                          saleFruitsMainPrice[i],
                                          style: kTextStyle.copyWith(
                                              color: groceryMainColor
                                                  .withOpacity(.30),
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10.0),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          productCount = 1;
                                          selectedProduct = saleFruitstitle[i];
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 30.0,
                                            right: 30.0,
                                            top: 5.0,
                                            bottom: 5.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            border: Border.all(
                                                color: groceryGreyTextColor)),
                                        child: Text(
                                          'Add to bag',
                                          style: kTextStyle.copyWith(
                                              color: kTitleColor),
                                        ),
                                      ).visible(selectedProduct !=
                                          saleFruitstitle[i]),
                                    ),
                                    SizedBox(
                                      width: 140.0,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              height: 30.0,
                                              decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(5.0),
                                                    bottomLeft:
                                                        Radius.circular(5.0),
                                                  ),
                                                  color: groceryMainColor),
                                              child: const Icon(
                                                FeatherIcons.minus,
                                                color: Colors.white,
                                              ).onTap(() {
                                                setState(() {
                                                  productCount > 1
                                                      ? productCount--
                                                      : productCount = 1;
                                                });
                                              }),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              height: 30.0,
                                              decoration: const BoxDecoration(
                                                  color: groceryMainColor),
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    '$productCount in bag',
                                                    style: kTextStyle.copyWith(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              height: 30.0,
                                              decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(5.0),
                                                    bottomRight:
                                                        Radius.circular(5.0),
                                                  ),
                                                  color: groceryMainColor),
                                              child: const Icon(
                                                FeatherIcons.plus,
                                                color: Colors.white,
                                              ).onTap(() {
                                                setState(() {
                                                  productCount++;
                                                });
                                              }),
                                            ),
                                          ),
                                        ],
                                      ).visible(
                                          selectedProduct == saleFruitstitle[i]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    RotatedBox(
                                      quarterTurns: 3,
                                      child: Transform.scale(
                                        scaleY: 1.3,
                                        child: const Icon(
                                          Icons.bookmark,
                                          size: 40.0,
                                          color: Color(0xFFFF3B76),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      salePercentage[i],
                                      style: kTextStyle.copyWith(
                                          color: Colors.white,
                                          fontSize: 10.0),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: context.width() / 4.2,
                                ),
                                const Icon(
                                  LineIcons.heart,
                                  color: groceryGreyTextColor,
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        Text(
                          'Popular Products',
                          style: kTextStyle.copyWith(
                              color: kTitleColor, fontSize: 18.0),
                        ),
                        const Spacer(),
                        Text(
                          'See All',
                          style:
                              kTextStyle.copyWith(color: groceryGreyTextColor),
                        ).onTap(() => const BestSellerScreen().launch(context)),
                      ],
                    ),
                    const SizedBox(height: 15.0),
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.0,
                      childAspectRatio: 0.75,
                      mainAxisSpacing: 5.0,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(
                        4,
                        (i) {
                          return Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color:
                                        groceryGreyTextColor.withOpacity(.30),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    children: [
                                      Image(
                                        image: AssetImage(popularFruitsList[i]),
                                        width: context.width() / 2.5,
                                        height: 100.0,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(height: 10.0),
                                      Text(
                                        popularProductTitle[i],
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 5.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            popularFruitsPrice[i],
                                            style: kTextStyle.copyWith(
                                                color: groceryMainColor),
                                          ),
                                          const SizedBox(width: 5.0),
                                          Text(
                                            popularFruitsMainPrice[i],
                                            style: kTextStyle.copyWith(
                                                color: groceryMainColor
                                                    .withOpacity(.30),
                                                decoration:
                                                    TextDecoration.lineThrough),
                                          ).visible(i == 0),
                                        ],
                                      ),
                                      const SizedBox(height: 10.0),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            productCount = 1;
                                            selectedProduct =
                                                popularProductTitle[i];
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 30.0,
                                              right: 30.0,
                                              top: 5.0,
                                              bottom: 5.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              border: Border.all(
                                                  color: groceryGreyTextColor)),
                                          child: Text(
                                            'Add to bag',
                                            style: kTextStyle.copyWith(
                                                color: kTitleColor),
                                          ),
                                        ).visible(selectedProduct !=
                                            popularProductTitle[i]),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              height: 30.0,
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(5.0),
                                                    bottomLeft:
                                                        Radius.circular(5.0),
                                                  ),
                                                  color: groceryMainColor),
                                              child: const Icon(
                                                FeatherIcons.minus,
                                                color: Colors.white,
                                              ).onTap(() {
                                                setState(() {
                                                  productCount > 1
                                                      ? productCount--
                                                      : productCount = 1;
                                                });
                                              }),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              height: 30.0,
                                              decoration: const BoxDecoration(
                                                  color: groceryMainColor),
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    '$productCount in bag',
                                                    style: kTextStyle.copyWith(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              height: 30.0,
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(5.0),
                                                    bottomRight:
                                                        Radius.circular(5.0),
                                                  ),
                                                  color: groceryMainColor),
                                              child: const Icon(
                                                FeatherIcons.plus,
                                                color: Colors.white,
                                              ).onTap(() {
                                                setState(() {
                                                  productCount++;
                                                });
                                              }),
                                            ),
                                          ),
                                        ],
                                      ).visible(selectedProduct ==
                                          popularProductTitle[i]),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      RotatedBox(
                                        quarterTurns: 3,
                                        child: Transform.scale(
                                          scaleY: 1.3,
                                          child: const Icon(
                                            Icons.bookmark,
                                            size: 40.0,
                                            color: Color(0xFFFF3B76),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        salesPercentage[i],
                                        style: kTextStyle.copyWith(
                                            color: Colors.white,
                                            fontSize: 10.0),
                                      ),
                                    ],
                                  ).visible(i == 0),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(
                                    FeatherIcons.heart,
                                    color: groceryGreyTextColor,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
