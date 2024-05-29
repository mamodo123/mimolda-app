import 'package:flutter/material.dart';
import 'package:mimolda/screens/splash_screen/order_details.dart';
import 'package:nb_utils/nb_utils.dart';

import '../const/constants.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  var currentItem = 0;
  final productType = [
    'All Order',
    'Processing',
    'Delivery',
    'Cancel Order',
    'Tops',
    'Pants'
  ];
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
          text: 'My Order',
          fontColor: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 20,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: HorizontalList(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentItem = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 12, bottom: 12),
                      decoration: BoxDecoration(
                        color: currentItem == index
                            ? secondaryColor1
                            : Colors.white,
                        border: Border.all(
                          width: 1,
                          color: secondaryColor3,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                      ),
                      child: MyGoogleText(
                        text: productType[index],
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        fontColor:
                            currentItem == index ? Colors.white : Colors.black,
                      ),
                    ),
                  );
                },
                itemCount: productType.length,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              width: context.width(),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: GestureDetector(
                      onTap: () {
                        const OrderDetailsScreen().launch(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(width: 1, color: secondaryColor3),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const MyGoogleText(
                              text: 'Order ID: #2156254',
                              fontSize: 16,
                              fontColor: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 20,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  MyGoogleText(
                                    text: 'Items (2)',
                                    fontSize: 16,
                                    fontColor: textColors,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  MyGoogleText(
                                    text: 'Total Amount \$76.00',
                                    fontSize: 14,
                                    fontColor: textColors,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 20,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  MyGoogleText(
                                    text: '12 May, 2022',
                                    fontSize: 16,
                                    fontColor: textColors,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  MyGoogleText(
                                    text: 'Delivered',
                                    fontSize: 14,
                                    fontColor: Colors.green,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
