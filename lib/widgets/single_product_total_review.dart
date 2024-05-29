import 'package:flutter/material.dart';
import 'package:mimolda/const/constants.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SingleProductTotalReview extends StatelessWidget {
  const SingleProductTotalReview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                        Radius.circular(40)),
                    border: Border.all(
                        width: 2, color: primaryColor),
                  ),
                  child: const Center(
                    child: MyGoogleText(
                      text: '4.9',
                      fontSize: 30,
                      fontWeight: FontWeight.normal,
                      fontColor: secondaryColor1,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                const MyGoogleText(
                  text: 'Total 22 Reviews',
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontColor: Colors.black,
                ),
              ],
            ),
            Positioned(
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star,
                          size: 18, color: ratingColor),
                      const Icon(Icons.star,
                          size: 18, color: ratingColor),
                      const Icon(Icons.star,
                          size: 18, color: ratingColor),
                      const Icon(Icons.star,
                          size: 18, color: ratingColor),
                      const Icon(Icons.star,
                          size: 18, color: ratingColor),
                      LinearPercentIndicator(
                        width: 130,
                        lineHeight: 8.0,
                        percent: 0.8,
                        progressColor: secondaryColor1,
                        backgroundColor: secondaryColor3,
                        barRadius:
                            const Radius.circular(15),
                      ),
                      const SizedBox(
                          width: 30,
                          child: Center(child: Text('12'))),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star,
                          size: 18, color: ratingColor),
                      const Icon(Icons.star,
                          size: 18, color: ratingColor),
                      const Icon(Icons.star,
                          size: 18, color: ratingColor),
                      const Icon(Icons.star,
                          size: 18, color: ratingColor),
                      LinearPercentIndicator(
                        width: 130,
                        lineHeight: 8.0,
                        percent: 0.25,
                        progressColor: secondaryColor1,
                        backgroundColor: secondaryColor3,
                        barRadius:
                            const Radius.circular(15),
                      ),
                      const SizedBox(
                          width: 30,
                          child: Center(child: Text('5'))),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star,
                          size: 18, color: ratingColor),
                      const Icon(Icons.star,
                          size: 18, color: ratingColor),
                      const Icon(Icons.star,
                          size: 18, color: ratingColor),
                      LinearPercentIndicator(
                        width: 130,
                        lineHeight: 8.0,
                        percent: 0.15,
                        progressColor: secondaryColor1,
                        backgroundColor: secondaryColor3,
                        barRadius:
                            const Radius.circular(15),
                      ),
                      const SizedBox(
                          width: 30,
                          child: Center(child: Text('4'))),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star,
                          size: 18, color: ratingColor),
                      const Icon(Icons.star,
                          size: 18, color: ratingColor),
                      LinearPercentIndicator(
                        width: 130,
                        lineHeight: 8.0,
                        percent: 0.5,
                        progressColor: secondaryColor1,
                        backgroundColor: secondaryColor3,
                        barRadius:
                            const Radius.circular(15),
                      ),
                      const SizedBox(
                          width: 30,
                          child: Center(child: Text('2'))),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star,
                          size: 18, color: ratingColor),
                      LinearPercentIndicator(
                        width: 130,
                        lineHeight: 8.0,
                        percent: 0,
                        progressColor: secondaryColor1,
                        backgroundColor: secondaryColor3,
                        barRadius:
                            const Radius.circular(15),
                      ),
                      const SizedBox(
                          width: 30,
                          child: Center(child: Text('0'))),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
