import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:nb_utils/nb_utils.dart';

import '../const/constants.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({
    Key? key,
    required this.name,
    required this.color,
    required this.items,
    required this.image,
    required this.onTabFunction,
  }) : super(key: key);
  final String name;
  final Color color;
  final String items;
  final String image;
  final VoidCallback onTabFunction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTabFunction,
      child: Container(
        height: 100,
        width: context.width(),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            color: color),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyGoogleText(
                    text: name,
                    fontSize: 20,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyGoogleText(
                        text: items,
                        fontSize: 14,
                        fontColor: textColors,
                        fontWeight: FontWeight.normal,
                      ),
                      const SizedBox(width: 3.0,),
                      const Icon(IconlyLight.arrow_right_3,color: textColors,),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 120,
              width: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(image), fit: BoxFit.cover, alignment: Alignment.center),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
