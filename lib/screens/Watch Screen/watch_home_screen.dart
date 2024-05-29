import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../const/constants.dart';
import '../best_seller_screen.dart';

class WatchHomeScreen extends StatefulWidget {
  const WatchHomeScreen({Key? key}) : super(key: key);

  @override
  State<WatchHomeScreen> createState() => _WatchHomeScreenState();
}

class _WatchHomeScreenState extends State<WatchHomeScreen> {
  List<String> brandList = [
    'images/watch/rolex.png',
    'images/watch/apple.png',
    'images/watch/seiko.png',
    'images/watch/zenith.png',
  ];

  int item = 10;
  List<String> brandTitle = [
    'Rolex',
    'Apple',
    'Seiko',
    'Zenith',
  ];
  List<String> specialOfferList = [
    'images/watch/watch10.png',
    'images/watch/watch11.png',
    'images/watch/watch12.png',
  ];

  List<String> specialOfferListTitle = [
    'Tissot Chrono XL',
    'Apple Watch',
    'Manufacture Royale',
  ];
  List<String> specialOfferListReview = [
    '4.8 (35 review)',
    '4.9 (27 review)',
    '4.9 (27 review)',
  ];
  List<String> specialOfferPrice = [
    '\$90.00',
    '\$50.00',
    '\$80.00',
  ];
  List<String> specialOfferMainPrice = [
    '\$110.00',
    '\$80.00',
    '\$110.00',
  ];
  List<String> specialOfferPercentage = ['20%', '20%', '20%'];

  List<Color> colorList = [
    const Color(0xFFEDECFF),
    const Color(0xFFFFF1E0),
    const Color(0xFFF1FFF4),
  ];
  List<String> trendingItemList = [
    'images/watch/watch13.png',
    'images/watch/watch14.png',
    'images/watch/watch15.png',
  ];
  List<String> trendingItemTitle = [
    'Glashütte Original',
    'Heart Rate Monitor',
    'Stuhrling Original',
  ];
  List<String> trendingItemReview = [
    '4.9 (27 review)',
    '4.9 (27 review)',
    '4.9 (27 review)',
  ];
  List<String> trendingItemPrice = [
    '\$230.00',
    '\$250.00',
    '\$250.00',
  ];
  List<String> trendingItemMainPrice = [
    '\$250.00',
    '\$250.00',
    '\$250.00',
  ];
  List<String> trendingItemPercentage = ['20%', '20%', '20%'];

  List<String> newItemList = [
    'images/watch/watch16.png',
    'images/watch/watch17.png',
  ];
  List<String> newItemTitle = [
    'Tissot Seastar',
    'TAG Heuer Calibre',
  ];
  List<String> newItemReview = [
    '4.9 (27 review)',
    '4.9 (27 review)',
  ];
  List<String> newItemPrice = [
    '\$230.00',
    '\$250.00',
  ];
  List<String> newItemMainPrice = [
    '\$250.00',
    '\$250.00',
  ];
  List<String> newItemPercentage = [
    '20%',
    '20%',
  ];
  List<Color> newColorList = [
    const Color(0xFFF6EAFF),
    const Color(0xFFE4F2FF),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBFBFB),
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
                'images/watch/watchprofile.png',
              ),
            ),
            title: Text(
              'Hey, Sahidul',
              style: kTextStyle.copyWith(
                  color: watchTitleColor, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Explore new watch',
              style: kTextStyle.copyWith(
                color: watchTitleColor,
              ),
            ),
            trailing: Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: watchGreyTextColor,
                  ),
                ),
                child: const Icon(
                  FeatherIcons.search,
                  color: Color(0xFF282344),
                ).onTap(() {
                  showSearch(context: context, delegate: MyWatchSearch());
                })),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 10.0),
            child: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: watchGreyTextColor,
                ),
              ),
              child: const Icon(
                FeatherIcons.bell,
                color: Color(0xFF282344),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              HorizontalList(
                padding: EdgeInsets.zero,
                spacing: 10.0,
                itemCount: 5,
                itemBuilder: (_, i) {
                  return Image.asset('images/watch/watchbanner.png');
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              HorizontalList(
                padding: EdgeInsets.zero,
                spacing: 10.0,
                itemCount: brandList.length,
                itemBuilder: (_, i) {
                  return Container(
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 10.0, top: 5.0, bottom: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            brandList[i],
                          ),
                          backgroundColor: watchMainColor.withOpacity(0.10),
                        ),
                        const SizedBox(width: 5.0),
                        Text(
                          brandTitle[i],
                          style: kTextStyle.copyWith(
                              color: kTitleColor, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Text(
                    'Special Offers',
                    style: kTextStyle.copyWith(
                        color: watchSecondaryTextColor, fontSize: 18.0),
                  ),
                  const Spacer(),
                  Text(
                    'See All',
                    style: kTextStyle.copyWith(color: watchGreyTextColor),
                  ).onTap(() => const BestSellerScreen().launch(context)),
                ],
              ),
              const SizedBox(height: 15.0),
              HorizontalList(
                padding: EdgeInsets.zero,
                spacing: 10.0,
                itemCount: specialOfferList.length,
                itemBuilder: (_, i) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.transparent,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: Colors.transparent),
                              child: Image(
                                image: AssetImage(specialOfferList[i]),
                                height: 130,
                                width: 130,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                  ),
                                  color: watchSecondaryColor),
                              height: 20,
                              width: 40,
                              child: Center(
                                  child: Text(
                                specialOfferPercentage[i],
                                style: kTextStyle.copyWith(color: Colors.white,fontSize: 12.0),
                              )),
                            )
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          specialOfferListTitle[i],
                          style: kTextStyle.copyWith(
                              color: watchTitleColor,
                              ),
                        ),
                        const SizedBox(height: 5.0),
                        Row(
                          children: [
                            RatingBarWidget(
                              onRatingChanged: null,
                              itemCount: 1,
                              activeColor: const Color(0xFFFF9900),
                              size: 14.0,
                            ),
                            const SizedBox(width: 2.0),
                            Text(
                              specialOfferListReview[i],
                              style: kTextStyle.copyWith(
                                  fontSize: 12.0,
                                  color: watchGreyTextColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        Row(
                          children: [
                            Text(
                              specialOfferPrice[i],
                              style: kTextStyle.copyWith(
                                  color: watchTitleColor,fontSize: 14.0,

                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              specialOfferMainPrice[i],
                              style: kTextStyle.copyWith(
                                  color: kGreyTextColor,
                                  fontSize: 12.0,
                                  decoration: TextDecoration.lineThrough),
                            ).visible(i == 0),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Text(
                    'Trending Watch',
                    style: kTextStyle.copyWith(
                        color: watchSecondaryTextColor, fontSize: 18.0),
                  ),
                  const Spacer(),
                  Text(
                    'Sell All',
                    style: kTextStyle.copyWith(color: watchGreyTextColor),
                  ).onTap(() => const BestSellerScreen().launch(context)),
                ],
              ),
              const SizedBox(height: 15.0),
              HorizontalList(
                padding: EdgeInsets.zero,
                spacing: 10.0,
                itemCount: trendingItemList.length,
                itemBuilder: (_, i) {
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        padding:const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: colorList[i]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Stack(
                                children: [
                                  Image(
                                    image: AssetImage(trendingItemList[i]),
                                    height: 130,
                                    width: 130,
                                    fit: BoxFit.cover,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10.0),
                                            ),
                                            color: watchSecondaryColor),
                                        height: 20,
                                        width: 40,
                                        child: Center(
                                            child: Text(
                                          trendingItemPercentage[i],
                                          style: kTextStyle.copyWith(
                                              fontSize: 12.0,
                                              color: Colors.white),
                                        )),
                                      ).visible(i == 0),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Center(
                              child: Text(
                                trendingItemTitle[i],
                                style: kTextStyle.copyWith(
                                    color: watchTitleColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RatingBarWidget(
                                  onRatingChanged: null,
                                  itemCount: 1,
                                  activeColor: const Color(0xFFFF9900),
                                  size: 14.0,
                                ),
                                const SizedBox(width: 2.0),
                                Text(
                                  trendingItemReview[i],
                                  style: kTextStyle.copyWith(
                                      fontSize: 12.0,
                                      color: watchGreyTextColor),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5.0),
                            Row(
                              children: [
                                Text(
                                  trendingItemPrice[i],
                                  style: kTextStyle.copyWith(
                                      color: watchTitleColor,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 5.0),
                                Text(
                                  trendingItemMainPrice[i],
                                  style: kTextStyle.copyWith(
                                      color: kGreyTextColor,
                                      fontSize: 12.0,
                                      decoration: TextDecoration.lineThrough),
                                ).visible(i == 0),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(
                                  30.0,
                                ),
                                bottomRight: Radius.circular(30.0),
                                bottomLeft: Radius.circular(30.0),
                                topRight: Radius.circular(5)),
                            color: const Color(0xFFFFF2ED),
                            border: Border.all(color: Colors.white)),
                        child: const Icon(
                          FeatherIcons.heart,
                          color: watchSecondaryColor,
                          size: 14.0,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Text(
                    'New Arrivals',
                    style: kTextStyle.copyWith(
                        color: watchSecondaryTextColor, fontSize: 18.0),
                  ),
                  const Spacer(),
                  Text(
                    'Sell All',
                    style: kTextStyle.copyWith(color: watchGreyTextColor),
                  ).onTap(() => const BestSellerScreen().launch(context)),
                ],
              ),
              const SizedBox(height: 15.0),
              HorizontalList(
                padding: EdgeInsets.zero,
                spacing: 10.0,
                itemCount: item,
                itemBuilder: (_, i) {
                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: newColorList[item % 2]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Image(
                                  image: AssetImage(newItemList[item % 2]),
                                  height: 130,
                                  width: 130,
                                  fit: BoxFit.cover,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                          ),
                                          color: watchSecondaryColor),
                                      height: 20,
                                      width: 40,
                                      child: Center(
                                          child: Text(
                                        newItemPercentage[item % 2],
                                        style: kTextStyle.copyWith(
                                            color: Colors.white),
                                      )),
                                    ).visible(i == 1),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              newItemTitle[item % 2],
                              style: kTextStyle.copyWith(
                                  color: watchTitleColor,),
                            ),
                            const SizedBox(height: 5.0),
                            Row(
                              children: [
                                RatingBarWidget(
                                  onRatingChanged: null,
                                  itemCount: 1,
                                  activeColor: const Color(0xFFFF9900),
                                  size: 14.0,
                                ),
                                const SizedBox(width: 2.0),
                                Text(
                                  newItemReview[item % 2],
                                  style: kTextStyle.copyWith(
                                      fontSize: 12.0,
                                      color: watchGreyTextColor),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5.0),
                            Row(
                              children: [
                                Text(
                                  newItemPrice[item % 2],
                                  style: kTextStyle.copyWith(
                                      color: watchTitleColor,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 5.0),
                                Text(
                                  newItemMainPrice[item % 2],
                                  style: kTextStyle.copyWith(
                                      color: kGreyTextColor,
                                      fontSize: 12.0,
                                      decoration: TextDecoration.lineThrough),
                                ).visible(i == 1),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(
                                  30.0,
                                ),
                                bottomRight: Radius.circular(30.0),
                                bottomLeft: Radius.circular(30.0),
                                topRight: Radius.circular(5)),
                            color: const Color(0xFFFFF2ED),
                            border: Border.all(color: Colors.white)),
                        child: const Icon(
                          FeatherIcons.heart,
                          color: watchSecondaryColor,
                          size: 14.0,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyWatchSearch extends SearchDelegate {
  List<String> productList = [
    'Tissot Chrono XL',
    'Apple Watch',
    'Manufacture Royale',
  ];

  List<String> productsList = [
    'Rolex',
    'Casio',
    'Apple',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(onPressed: () {}, icon: const Icon(FeatherIcons.x))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.arrow_back).onTap(() => finish(context)),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
        itemCount: productsList.length,
        itemBuilder: (context, i) {
          return ListTile(
            title: Text(productsList[i]),
            trailing: const Icon(FeatherIcons.arrowRight),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, i) {
          return ListTile(
            title: Text(productList[i]),
            trailing: const Icon(FeatherIcons.arrowRight),
          );
        });
  }
}
