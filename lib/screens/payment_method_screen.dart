import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:mimolda/widgets/buttons.dart';
import 'package:nb_utils/nb_utils.dart';

import '../const/constants.dart';
import 'add_card_screen.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  List<String> cardNumber = ['1221 2255 6654 8987', '5487 5687 6589 2354'];
  int checked = 5;
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
          text: 'Payment Method',
          fontColor: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 18,
        ),
      ),
      body: Container(
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
            const MyGoogleText(
              text: 'Your payment cards',
              fontSize: 18,
              fontColor: Colors.black,
              fontWeight: FontWeight.normal,
            ),
            Column(
              children: [
                PaymentCard(cardNumber: cardNumber),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Button1(
                buttonText: 'Add Card',
                buttonColor: primaryColor,
                onPressFunction: () {
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    context: context,
                    builder: (context) => const AddCardScreen(),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class PaymentCard extends StatefulWidget {
  const PaymentCard({
    Key? key,
    required this.cardNumber,
  }) : super(key: key);

  final List<String> cardNumber;

  @override
  State<PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  int checked = 5;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CreditCardWidget(
          cardNumber: widget.cardNumber[0],
          expiryDate: '05/31',
          cardHolderName: 'Ibne Riead',
          cvvCode: '117',
          showBackView: false,
          onCreditCardWidgetChange:
              // ignore: non_constant_identifier_names
              (CreditCardBrand) {}, //true when you want to show cvv(back) view
        ),
        checked == 0
            ? Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      checked = 0;
                    });
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.check_box,
                        color: primaryColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      MyGoogleText(
                        text: 'Use as the payment method',
                        fontSize: 16,
                        fontColor: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      checked = 0;
                      Navigator.pop(context);
                    });
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.check_box_outline_blank,
                        color: textColors,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      MyGoogleText(
                        text: 'Use as the payment method',
                        fontSize: 16,
                        fontColor: textColors,
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  ),
                ),
              ),
        CreditCardWidget(
          cardNumber: widget.cardNumber[1],
          expiryDate: '05/31',
          cardHolderName: 'Tar Kul',
          cvvCode: '217',
          showBackView: false,
          onCreditCardWidgetChange:
              // ignore: non_constant_identifier_names
              (CreditCardBrand) {}, //true when you want to show cvv(back) view
        ),
        checked == 1
            ? Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      checked = 1;
                    });
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.check_box,
                        color: primaryColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      MyGoogleText(
                        text: 'Use as the payment method',
                        fontSize: 16,
                        fontColor: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      checked = 1;
                      Navigator.pop(context);
                    });
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.check_box_outline_blank,
                        color: textColors,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      MyGoogleText(
                        text: 'Use as the payment method',
                        fontSize: 16,
                        fontColor: textColors,
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
