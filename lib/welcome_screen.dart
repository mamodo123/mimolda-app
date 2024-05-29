import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mimolda/screens/Grocery%20Screen/grocery_home.dart';
import 'package:mimolda/screens/Watch%20Screen/watch_home.dart';
import 'package:mimolda/screens/home_screens/home.dart';
import 'package:nb_utils/nb_utils.dart';

import 'const/constants.dart';

class WelComeScreen extends StatefulWidget {
  const WelComeScreen({Key? key}) : super(key: key);

  @override
  State<WelComeScreen> createState() => _WelComeScreenState();
}

class _WelComeScreenState extends State<WelComeScreen> {

  PageController controller = PageController();

  List<String> categoryTitle = [
    'Fashion Screen',
    'Grocery Screen',
    'Watch Screen',
  ];
  List<String> categorySubTitle = [
    'Check Fashion  App Design',
    'Check Grocery  App Design',
    'Check Watch App Design',
  ];

  List<String> imageList = [
    'images/fashion.png',
    'images/grocery.png',
    'images/watchh.png',
  ];

  List<Widget> screenList = [
    const Home(),
    const GroceryHome(),
    const WatchHome()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(alignment: Alignment.bottomCenter, children: [
          Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Center(
                child: Image(
                  image: AssetImage('images/maanlogo.png'),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CarouselSlider.builder(
                options: CarouselOptions(
                  height: 200,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration:
                  const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                ),
                itemCount: 10,
                itemBuilder:
                    (BuildContext context, int index, int realIndex) {
                  return SizedBox(
                    height: 200,
                    width: 330,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 200,
                          width: 145,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0)),
                            color: Color(0xFFFBFBFB),
                            image: DecorationImage(
                              image: AssetImage('images/ad1.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 3.0),
                        Column(
                          children: [
                            Container(
                              height: 100,
                              width: 180,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                ),
                                color: Color(0xFFFBFBFB),
                                image: DecorationImage(
                                  image: AssetImage('images/ad2.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 3.0,
                            ),
                            Container(
                              height: 97,
                              width: 180,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20.0),
                                ),
                                color: Color(0xFFFBFBFB),
                                image: DecorationImage(
                                  image: AssetImage('images/ad3.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.40,
            maxChildSize: 1.0,
            minChildSize: 0.40,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: const Color(0xFFDADADA),
                          ),
                          height: 3.0,
                          width: 40.0,
                        ),
                        const SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Select Your',
                                style: kTextStyle.copyWith(
                                  color: kTitleColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26.0,
                                ),
                                children: [
                                  TextSpan(
                                    text: ' Shop',style: kTextStyle.copyWith(
                                    color: const Color(0xFFE2396C),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26.0,
                                  ),

                                  )
                                ]
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15.0),
                        ListView.builder(
                          itemCount: imageList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, i) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, bottom: 5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: const Color(0xFFDADADA),
                                  ),
                                ),
                                child: ListTile(
                                  onTap: (() => screenList[i].launch(context)),
                                  contentPadding:
                                      const EdgeInsets.only(left: 10.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  leading: Image(
                                    image: AssetImage(imageList[i]),
                                  ),
                                  title: Text(
                                    categoryTitle[i],
                                    style:
                                        kTextStyle.copyWith(color: kTitleColor,fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    categorySubTitle[i],
                                    style: kTextStyle.copyWith(
                                        color: kGreyTextColor),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ]),
      ),
    );
  }
}
