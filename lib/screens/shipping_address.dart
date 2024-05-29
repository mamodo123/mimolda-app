import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../const/constants.dart';
import '../widgets/add_new_address.dart';
import '../widgets/buttons.dart';

class ShippingAddress extends StatefulWidget {
  const ShippingAddress({Key? key}) : super(key: key);

  @override
  State<ShippingAddress> createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  String name = 'Shaidul Islam';
  List<String> addressList = [
    '6391 Elgin St. Celina, Delaware 10299',
    '3517 W. Gray St. Utica, Pennsylvania 57867',
    '8 Bukit Batok Street 41, Bangladesh,361025'
  ];
  int checked = 0;
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
          text: 'Shipping Address',
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
            ///____________Shipping_address__________________________
            const MyGoogleText(
              text: 'Shipping Address',
              fontSize: 20,
              fontColor: Colors.black,
              fontWeight: FontWeight.normal,
            ),
            const SizedBox(height: 20),

            ListView.builder(
                shrinkWrap: true,
                itemCount: addressList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: secondaryColor3),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyGoogleText(
                                text: name,
                                fontSize: 16,
                                fontColor: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const MyGoogleText(
                                  text: 'Edit',
                                  fontSize: 16,
                                  fontColor: secondaryColor1,
                                  fontWeight: FontWeight.normal,
                                ),
                              )
                            ],
                          ),
                          Flexible(
                            child: MyGoogleText(
                              text: addressList[index],
                              fontSize: 16,
                              fontColor: textColors,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          checked == index
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        checked = index;
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
                                          text: 'Use as the shipping address',
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
                                        checked = index;
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
                                          text: 'Use as the shipping address',
                                          fontSize: 16,
                                          fontColor: textColors,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  );
                }),

            ///___________Pay_Now_Button___________________________________

            const Spacer(),
            Button1(
                buttonText: 'Add New Address',
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
                    builder: (context) => const AddNewAddress(),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
