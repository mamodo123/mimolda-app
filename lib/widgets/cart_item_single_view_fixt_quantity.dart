import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../const/constants.dart';

class CartItemsSingleViewFixedQuantity extends StatefulWidget {
  const CartItemsSingleViewFixedQuantity({Key? key}) : super(key: key);

  @override
  State<CartItemsSingleViewFixedQuantity> createState() =>
      _CartItemsSingleViewFixedQuantityState();
}

class _CartItemsSingleViewFixedQuantityState
    extends State<CartItemsSingleViewFixedQuantity> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        right: 8,
        bottom: 8,
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(
              width: 1,
              color: secondaryColor3,
            )),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: secondaryColor3,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: secondaryColor3,
                  image: const DecorationImage(
                      image: AssetImage('images/woman.png')),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: MyGoogleText(
                    text: 'Para Homens',
                    fontSize: 16,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  width: context.width() / 2,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const MyGoogleText(
                              text: 'Color:',
                              fontSize: 12,
                              fontColor: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              height: 15,
                              width: 15,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  color: Colors.red),
                            ),
                          ],
                        ),
                        Row(
                          children: const [
                            MyGoogleText(
                              text: 'Size:',
                              fontSize: 12,
                              fontColor: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                            SizedBox(width: 5),
                            MyGoogleText(
                              text: 'L',
                              fontSize: 14,
                              fontColor: Colors.red,
                              fontWeight: FontWeight.normal,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: context.width() / 2,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        MyGoogleText(
                          text: '\$40.00',
                          fontSize: 16,
                          fontColor: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                        MyGoogleText(
                          text: 'Qty: 1',
                          fontSize: 16,
                          fontColor: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
