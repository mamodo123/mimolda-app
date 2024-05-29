import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:nb_utils/nb_utils.dart';

import '../const/constants.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({Key? key}) : super(key: key);

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  final fieldText = TextEditingController();
  String initialSearchValue = '';
  List<String> searchHistory = [];
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
          text: 'Search Product',
          fontColor: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 18,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              height: context.height() - AppBar().preferredSize.height,
              padding: const EdgeInsets.all(20),
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
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    height: 60,
                    width: context.width(),
                    decoration: const BoxDecoration(
                      color: secondaryColor3,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(width: 15),
                        const Icon(
                          FeatherIcons.search,
                          color: textColors,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: TextEditingController(),
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search Product'),
                            cursorColor: textColors,
                            onFieldSubmitted: (value) {
                              setState(() {
                                searchHistory.add(value);
                                TextEditingController().clear();
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const MyGoogleText(
                          text: 'Recent Searches',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          fontColor: Colors.black,
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              searchHistory.clear();
                            });
                          },
                          child: const MyGoogleText(
                            text: 'Clear all',
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            fontColor: textColors,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchHistory.length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: MyGoogleText(
                                  text: searchHistory[index],
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  fontColor: textColors,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      searchHistory.removeAt(index);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: textColors,
                                  ))
                            ],
                          );
                        }),
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
