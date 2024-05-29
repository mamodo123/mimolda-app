import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../const/constants.dart';

class CastomarReviewCommends extends StatelessWidget {
  const CastomarReviewCommends({
    Key? key,
    required this.peopleReviewName,
    required this.peopleReviewPhoto,
    required this.peopleReviewRatings,
    required this.peopleReviewCommends,
  }) : super(key: key);

  final List<String> peopleReviewName;
  final List<String> peopleReviewPhoto;
  final List<int> peopleReviewRatings;
  final List<String> peopleReviewCommends;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: peopleReviewName.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              border: Border.all(width: 1, color: secondaryColor3),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        image: DecorationImage(
                            image: AssetImage(peopleReviewPhoto[index]),
                            fit: BoxFit.fitWidth),
                      ),
                    ),
                    title: MyGoogleText(
                      text: peopleReviewName[index],
                      fontSize: 18,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                    subtitle: RatingBarWidget(
                      rating: peopleReviewRatings[index].toDouble(),
                      activeColor: ratingColor,
                      inActiveColor: ratingColor,
                      size: 18,
                      onRatingChanged: (aRating) {},
                    ),
                    trailing: const MyGoogleText(
                      text: '8, June 2022',
                      fontSize: 12,
                      fontColor: textColors,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  MyGoogleText(
                    text: peopleReviewCommends[index],
                    fontSize: 16,
                    fontColor: textColors,
                    fontWeight: FontWeight.normal,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
