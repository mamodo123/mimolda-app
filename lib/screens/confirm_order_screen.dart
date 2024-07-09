import 'package:flutter/material.dart';
import 'package:mimolda/models/product.dart';
import 'package:mimolda/screens/payment_method_screen.dart';
import 'package:mimolda/screens/shipping_address.dart';
import 'package:mimolda/widgets/buttons.dart';
import 'package:mimolda/widgets/cart_item_single_view.dart';
import 'package:nb_utils/nb_utils.dart';

import '../const/constants.dart';
import '../widgets/cart_cost_section.dart';
import '../widgets/confirmation_popup.dart';

class ConfirmOrderScreen extends StatefulWidget {
  const ConfirmOrderScreen({super.key});

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            finish(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const MyGoogleText(
          text: 'Confirm Your Order',
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
                  ///___________Items_view_________________________________
                  const MyGoogleText(
                    text: 'Total Item (2)',
                    fontSize: 18,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                  SizedBox(
                    height: 130,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 2,
                      itemBuilder: (BuildContext ctx, index) {
                        return CartItemsSingleView(
                            Product(
                                name: '',
                                description: '',
                                images: [],
                                categories: [],
                                variants: [],
                                attributes: [],
                                tags: [], id: ''),
                            Variant(
                                price: null,
                                promotionalPrice: null,
                                attributes: {},
                                image: ''),
                            0);
                      },
                    ),
                  ),

                  ///____________Shipping_address__________________________
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              MyGoogleText(
                                text: 'Shipping Address',
                                fontSize: 18,
                                fontColor: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.check_circle,
                                color: primaryColor,
                              )
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              const ShippingAddress().launch(context);
                            },
                            child: const MyGoogleText(
                              text: 'Change',
                              fontSize: 16,
                              fontColor: secondaryColor1,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      const Flexible(
                        child: MyGoogleText(
                          text:
                              'Shaidul Islam - 6391 Elgin St. Celina, Delaware 10299 Bangladesh, 361025',
                          fontSize: 16,
                          fontColor: textColors,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  ///_____________Delivery details______________________________
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          MyGoogleText(
                            text: 'Delivery details',
                            fontSize: 18,
                            fontColor: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.check_circle,
                            color: primaryColor,
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Flexible(
                            child: MyGoogleText(
                              text: 'Standard Delivery',
                              fontSize: 16,
                              fontColor: textColors,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Flexible(
                            child: MyGoogleText(
                              text: '26 May 2022  (Sun 26 - Wed 30)',
                              fontSize: 16,
                              fontColor: textColors,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  ///_____________Payment Method______________________________

                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              MyGoogleText(
                                text: 'Payment Method',
                                fontSize: 18,
                                fontColor: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.check_circle,
                                color: primaryColor,
                              )
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              const PaymentMethodScreen().launch(context);
                            },
                            child: const MyGoogleText(
                              text: 'Change',
                              fontSize: 16,
                              fontColor: secondaryColor1,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Image(image: AssetImage('images/paypal2.png')),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                MyGoogleText(
                                  text: 'Paypal',
                                  fontSize: 16,
                                  fontColor: textColors,
                                  fontWeight: FontWeight.normal,
                                ),
                                SizedBox(height: 5),
                                MyGoogleText(
                                  text: '**** **** **** 2546',
                                  fontSize: 16,
                                  fontColor: textColors,
                                  fontWeight: FontWeight.normal,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  ///______________cost_section_______________________________
                  const CartCostSection(),

                  Button1(
                      buttonText: 'Pay Now',
                      buttonColor: primaryColor,
                      onPressFunction: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) =>
                                const RedeemConfirmationScreen(
                              image: 'images/confirm_order_pupup.png',
                              mainText: 'Order successfully!',
                              subText:
                                  'Your order will be delivered soon. Thank you.',
                              buttonText: 'Back to Home',
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
