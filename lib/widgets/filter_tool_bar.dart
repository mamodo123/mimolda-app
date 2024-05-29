import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:iconly/iconly.dart';

import '../const/constants.dart';

class FilterToolBar extends StatefulWidget {
  const FilterToolBar({Key? key,}) : super(key: key);
  @override
  State<FilterToolBar> createState() => _FilterToolBarState();
}

class _FilterToolBarState extends State<FilterToolBar> {
  bool isSingleView = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () {},
          child: Row(
            children: const [
              Icon(
                FeatherIcons.sliders,
                color: Colors.black,
              ),
              SizedBox(width: 5),
              MyGoogleText(
                text: 'Sort',
                fontSize: 16,
                fontColor: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Row(
            children: const [
              Icon(
                IconlyLight.filter,
                color: Colors.black,
              ),
              SizedBox(width: 5),
              MyGoogleText(
                text: 'Filter',
                fontSize: 16,
                fontColor: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  isSingleView = false;
                });
              },
              icon: isSingleView
                  ? const Icon(
                      IconlyLight.category,
                      color: textColors,
                    )
                  : const Icon(
                      IconlyLight.category,
                      color: Colors.black,
                    ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  isSingleView = true;
                });
              },
              icon: isSingleView
                  ? const Icon(
                      Icons.rectangle_outlined,
                      color: Colors.black,
                    )
                  : const Icon(
                      Icons.rectangle_outlined,
                      color: textColors,
                    ),
            ),
          ],
        ),
      ],
    );
  }
}
