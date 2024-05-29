import 'package:flutter/material.dart';
import 'package:mimolda/widgets/buttons.dart';
import 'package:mimolda/widgets/cart_cost_section.dart';
import 'package:mimolda/widgets/cart_item_single_view_fixt_quantity.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../const/constants.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
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
            text: 'Order Details',
            fontColor: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 20,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          MyGoogleText(
                            text: 'Order ID: #2156254',
                            fontSize: 18,
                            fontColor: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                          MyGoogleText(
                            text: '12 May, 2022',
                            fontSize: 16,
                            fontColor: textColors,
                            fontWeight: FontWeight.normal,
                          ),
                        ],
                      ),
                    ),
                    const OrderTimeLineTile(),
                    const SizedBox(height: 20),
                    const MyGoogleText(
                      text: 'Item (2)',
                      fontSize: 18,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                    SizedBox(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (BuildContext ctx, index) {
                          return const CartItemsSingleViewFixedQuantity();
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    const CartCostSection(),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const MyGoogleText(
                          text: 'Payment Method',
                          fontSize: 18,
                          fontColor: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                        const SizedBox(height: 10),
                        const MyGoogleText(
                          text: 'Cash on delivery',
                          fontSize: 16,
                          fontColor: textColors,
                          fontWeight: FontWeight.normal,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 1,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(
                            width: 1,
                            color: secondaryColor3,
                          )),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const MyGoogleText(
                          text: 'Shipping Address',
                          fontSize: 18,
                          fontColor: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                        const SizedBox(height: 10),
                        const Flexible(
                          child: MyGoogleText(
                            text:
                                'Shaidul Islam 6391 Elgin St. Celina, Delaware 1029 Bangladesh, 361025',
                            fontSize: 16,
                            fontColor: textColors,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 1,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(
                            width: 1,
                            color: secondaryColor3,
                          )),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const MyGoogleText(
                          text: 'Delivery Details',
                          fontSize: 18,
                          fontColor: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                        const SizedBox(height: 10),
                        const MyGoogleText(
                          text: 'Standard Delivery',
                          fontSize: 16,
                          fontColor: textColors,
                          fontWeight: FontWeight.normal,
                        ),
                        const SizedBox(height: 10),
                        const MyGoogleText(
                          text: '26 May 2022  (Sun 26 - Wed 30)',
                          fontSize: 16,
                          fontColor: textColors,
                          fontWeight: FontWeight.normal,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 1,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(
                            width: 1,
                            color: secondaryColor3,
                          )),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Button1(
                        buttonText: 'Update Profile',
                        buttonColor: primaryColor,
                        onPressFunction: () {}),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class OrderTimeLineTile extends StatelessWidget {
  const OrderTimeLineTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            TimelineTile(
              endChild: const MyGoogleText(
                text: 'Confirmed',
                fontWeight: FontWeight.normal,
                fontColor: textColors,
                fontSize: 16,
              ),
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.center,
              isFirst: true,
              indicatorStyle: IndicatorStyle(
                height: 35,
                width: 35,
                indicator: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.white,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check_circle,
                      color: secondaryColor1,
                      size: 30,
                    ),
                  ),
                ),
              ),
              beforeLineStyle: const LineStyle(
                color: secondaryColor1,
                thickness: 3,
              ),
            ),
            TimelineTile(
              endChild: const MyGoogleText(
                text: 'Canceled',
                fontWeight: FontWeight.normal,
                fontColor: textColors,
                fontSize: 16,
              ),
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.center,
              beforeLineStyle: const LineStyle(
                color: secondaryColor1,
                thickness: 3,
              ),
              afterLineStyle: const LineStyle(
                color: secondaryColor1,
                thickness: 3,
              ),
              indicatorStyle: IndicatorStyle(
                height: 35,
                width: 35,
                indicator: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.white,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check_circle,
                      color: secondaryColor1,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
            TimelineTile(
              endChild: const MyGoogleText(
                text: 'Shipped',
                fontWeight: FontWeight.normal,
                fontColor: textColors,
                fontSize: 16,
              ),
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.center,
              beforeLineStyle: const LineStyle(
                color: secondaryColor1,
                thickness: 3,
              ),
              afterLineStyle: const LineStyle(
                color: secondaryColor1,
                thickness: 3,
              ),
              indicatorStyle: IndicatorStyle(
                height: 35,
                width: 35,
                indicator: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.white,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.circle,
                      color: secondaryColor1,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ),
            TimelineTile(
              endChild: const MyGoogleText(
                text: 'Delivered',
                fontWeight: FontWeight.normal,
                fontColor: textColors,
                fontSize: 16,
              ),
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.center,
              isLast: true,
              beforeLineStyle: const LineStyle(
                color: secondaryColor1,
                thickness: 3,
              ),
              indicatorStyle: IndicatorStyle(
                height: 35,
                width: 35,
                indicator: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.white,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.circle,
                      color: secondaryColor1,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
