import 'package:flutter/material.dart';
import 'package:mimolda/screens/confirm_order_screen.dart';
import 'package:mimolda/screens/shipping_address.dart';
import 'package:nb_utils/nb_utils.dart';

import '../const/constants.dart';
import '../widgets/buttons.dart';
import '../widgets/cart_cost_section.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  List<String> paymentImageList = [
    'images/credit-card.png',
    'images/dollar-bill.png',
    'images/pix.png'
  ];
  List<String> paymentNameList = ['Cartão', 'Dinheiro', 'Pix'];
  String whichPaymentIsChecked = 'Cartão';

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
          text: 'Check Out',
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
                  ///____________Shipping_address__________________________
                  const MyGoogleText(
                    text: 'Endereço de entrega',
                    fontSize: 20,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: secondaryColor3),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const MyGoogleText(
                              text: 'Casa',
                              fontSize: 16,
                              fontColor: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                            TextButton(
                              onPressed: () {
                                const ShippingAddress().launch(context);
                              },
                              child: const MyGoogleText(
                                text: 'Alterar',
                                fontSize: 16,
                                fontColor: secondaryColor1,
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ],
                        ),
                        const Flexible(
                          child: MyGoogleText(
                            text:
                                'Rua Jardim dos Eucaliptos, 800 - Campeche, Florianópolis - SC',
                            fontSize: 16,
                            fontColor: textColors,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  ///_______Payment_method________________________
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyGoogleText(
                        text: 'Método de pagamento',
                        fontSize: 20,
                        fontColor: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      // TextButton(
                      //   onPressed: () {
                      //     const PaymentMethodScreen().launch(context);
                      //   },
                      //   child: const MyGoogleText(
                      //     text: 'Alterar',
                      //     fontSize: 16,
                      //     fontColor: secondaryColor1,
                      //     fontWeight: FontWeight.normal,
                      //   ),
                      // )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: secondaryColor3),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: paymentImageList.length,
                        itemBuilder: (context, i) {
                          return whichPaymentIsChecked == paymentNameList[i]
                              ? Card(
                                  elevation: 0.5,
                                  child: ListTile(
                                    leading: Image(
                                        image: AssetImage(paymentImageList[i])),
                                    title: MyGoogleText(
                                      text: paymentNameList[i],
                                      fontSize: 16,
                                      fontColor: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          whichPaymentIsChecked =
                                              paymentNameList[i];
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.radio_button_checked,
                                        color: secondaryColor1,
                                      ),
                                    ),
                                  ),
                                )
                              : ListTile(
                                  leading: Image(
                                      image: AssetImage(paymentImageList[i])),
                                  title: MyGoogleText(
                                    text: paymentNameList[i],
                                    fontSize: 16,
                                    fontColor: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        whichPaymentIsChecked =
                                            paymentNameList[i];
                                      });
                                    },
                                    icon: const Icon(Icons.radio_button_off),
                                  ),
                                );
                        }),
                  ),
                  const SizedBox(height: 20),

                  ///_____Cost_Section_____________
                  const CartCostSection(freight: 1990),

                  ///___________Pay_Now_Button___________________________________
                  Button1(
                      buttonText: 'Pagar agora',
                      buttonColor: primaryColor,
                      onPressFunction: () {
                        const ConfirmOrderScreen().launch(context);
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
