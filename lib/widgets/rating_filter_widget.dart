import 'package:flutter/material.dart';

import '../const/constants.dart';
class StarRating extends StatefulWidget {
  const StarRating({Key? key}) : super(key: key);

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  final ratingList = const [1, 2, 3, 4, 5];
  int selectedRating = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, i) => GestureDetector(
        onTap: () {
          setState(() {
            selectedRating = ratingList[i];
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: selectedRating == ratingList[i]
              ? Container(
            width: 60,
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.5,
                color: Colors.white,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: secondaryColor1,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 16,
                ),
                MyGoogleText(
                  text: ratingList[i].toString(),
                  fontWeight: FontWeight.normal,
                  fontColor: Colors.white,
                  fontSize: 16,
                ),
              ],
            ),
          )
              : Container(
            width: 60,
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.5,
                color: textColors,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star,
                  color: textColors,
                  size: 16,
                ),
                MyGoogleText(
                  text: ratingList[i].toString(),
                  fontWeight: FontWeight.normal,
                  fontColor: textColors,
                  fontSize: 16,
                ),
              ],
            ),
          ),
        ),
      ),
      itemCount: ratingList.length,
    );
  }
}
