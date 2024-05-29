import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:nb_utils/nb_utils.dart';

import '../const/constants.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  double initialRating = 0;

  List<bool> isChecked = [false, false, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const MyGoogleText(
          text: 'Wishlist (6)',
          fontColor: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 18,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: TextButton(
              onPressed: () {},
              child: const MyGoogleText(
                text: 'Delete',
                fontColor: secondaryColor1,
                fontWeight: FontWeight.normal,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 20, bottom: 20),
              width: context.width(),
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
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          right: 8,
                          bottom: 8,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            border: Border.all(
                              width: 1,
                              color: secondaryColor3,
                            ),
                          ),
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    color: secondaryColor3,
                                    image: const DecorationImage(
                                        image: AssetImage('images/woman.png')),
                                  ),
                                ),
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: context.width() / 1.8,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: MyGoogleText(
                                              text: 'Para Homens',
                                              fontSize: 18,
                                              fontColor: textColors,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isChecked[index] =
                                                    !isChecked[index];
                                              });
                                            },
                                            child: isChecked[index]
                                                ? const Icon(
                                                    Icons.check_circle,
                                                    color: primaryColor,
                                                  )
                                                : const Icon(
                                                    Icons.circle_outlined,
                                                    color: primaryColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(5),
                                      child: MyGoogleText(
                                        text: '\$40.00',
                                        fontSize: 16,
                                        fontColor: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: context.width() / 1.8,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              RatingBarWidget(
                                                rating: initialRating,
                                                activeColor: ratingColor,
                                                inActiveColor: ratingColor,
                                                size: 16,
                                                onRatingChanged: (aRating) {
                                                  setState(() {
                                                    initialRating = aRating;
                                                  });
                                                },
                                              ),
                                              const SizedBox(width: 5),
                                              const MyGoogleText(
                                                text: '(22 Review)',
                                                fontSize: 12,
                                                fontColor: textColors,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                              color: primaryColor
                                                  .withOpacity(0.05),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(30)),
                                            ),
                                            child: const Center(
                                                child: Icon(
                                              IconlyLight.bag,
                                              color: primaryColor,
                                            )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ])
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
