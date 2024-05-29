import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../const/constants.dart';
import 'buttons.dart';

class ReviewBottomSheet extends StatelessWidget {
  const ReviewBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MyGoogleText(
                  text: 'Write a Review',
                  fontSize: 20,
                  fontColor: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Image(
              image: AssetImage('images/review_pic.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: MyGoogleTextWhitAli(
                      fontSize: 26,
                      fontColor: Colors.black,
                      text: 'Haven’t Purchased this Product?',
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  MyGoogleTextWhitAli(
                    fontSize: 16,
                    fontColor: textColors,
                    text:
                        'Porta scelerisque sed lobortis in adipiscing et to rtor consectetur. Urna suscipit',
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Button1(
                  buttonText: 'Continue Shopping',
                  buttonColor: primaryColor,
                  onPressFunction: () {
                    Navigator.pop(context);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class GivingRatingBottomSheet extends StatefulWidget {
  const GivingRatingBottomSheet({Key? key}) : super(key: key);

  @override
  State<GivingRatingBottomSheet> createState() =>
      _GivingRatingBottomSheetState();
}

class _GivingRatingBottomSheetState extends State<GivingRatingBottomSheet> {
  double initialRating = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const MyGoogleText(
                text: 'Write a Review',
                fontSize: 20,
                fontColor: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 30),
          const MyGoogleText(
            text: 'Enter Your Opinion',
            fontSize: 20,
            fontColor: Colors.black,
            fontWeight: FontWeight.normal,
          ),
          const SizedBox(height: 20),
          Center(
            child: RatingBarWidget(
              rating: initialRating,
              activeColor: ratingColor,
              inActiveColor: ratingColor,
              size: 60,
              onRatingChanged: (aRating) {
                setState(() {
                  initialRating = aRating;
                });
              },
            ),
          ),
          const SizedBox(height: 30),
          const MyGoogleText(
            text: 'Enter Your Opinion',
            fontSize: 20,
            fontColor: Colors.black,
            fontWeight: FontWeight.normal,
          ),
          const SizedBox(height: 10),
          TextFormField(
            maxLines: 10,
            minLines: 5,
            decoration: InputDecoration(
              hintText: 'Massage',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            ),
          ),
          const SizedBox(height: 20),
          Button1(
            buttonText: 'Apply',
            buttonColor: primaryColor,
            onPressFunction: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
