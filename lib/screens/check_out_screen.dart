import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mimolda/functions/wpp_message.dart';
import 'package:mimolda/screens/shipping_address.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../const/app_config.dart';
import '../const/constants.dart';
import '../data_manager/nuvemshop.dart';
import '../models/address.dart';
import '../models/full_store.dart';
import '../models/order.dart';
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
  Address? selectedAddress;
  int? freight;
  var loading = false;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: loading,
      child: Scaffold(
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
                    GestureDetector(
                      onTap: selectAddress,
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
                                Expanded(
                                  child: MyGoogleText(
                                    text: selectedAddress == null
                                        ? 'Endereço'
                                        : selectedAddress!.name,
                                    fontSize: 16,
                                    fontColor: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                TextButton(
                                  onPressed: selectAddress,
                                  child: MyGoogleText(
                                    text: selectedAddress == null
                                        ? 'Selecionar'
                                        : 'Alterar',
                                    fontSize: 16,
                                    fontColor: secondaryColor1,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )
                              ],
                            ),
                            Flexible(
                              child: MyGoogleText(
                                text: selectedAddress == null
                                    ? 'Selecione um endereço'
                                    : selectedAddress!.fullAddress,
                                fontSize: 16,
                                fontColor: textColors,
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ],
                        ),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
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
                                          image:
                                              AssetImage(paymentImageList[i])),
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
                    CartCostSection(freight: freight),

                    ///___________Pay_Now_Button___________________________________
                    Button1(
                        loading: loading,
                        buttonText: 'Enviar pedido',
                        buttonColor: primaryColor,
                        onPressFunction: selectedAddress == null
                            ? null
                            : () async {
                                setState(() {
                                  loading = true;
                                });
                                final fullStore =
                                    context.read<FullStoreNotifier>();
                                final originalValue =
                                    fullStore.cartWithoutDiscount;
                                final discounts = fullStore.cartDiscount;
                                final freight = this.freight!;
                                final clientId =
                                    FirebaseAuth.instance.currentUser!.uid;

                                List<ProductOrder> products = [];

                                for (final productEntry
                                    in fullStore.cart.entries) {
                                  final product = productEntry.key;
                                  for (final variantEntry
                                      in productEntry.value.entries) {
                                    final variant = variantEntry.key;
                                    final quantity = variantEntry.value;

                                    final productOrder = ProductOrder(
                                        product: product.name,
                                        productId: product.id,
                                        image: variant.image ??
                                            product.images.first,
                                        attributes: variant.attributes,
                                        price: variant.price,
                                        promotionalPrice:
                                            variant.promotionalPrice,
                                        quantity: quantity);
                                    products.add(productOrder);
                                  }
                                }

                                final order = MimoldaOrder(
                                    client: fullStore.user!.name,
                                    clientId: clientId,
                                    payment: whichPaymentIsChecked,
                                    storeId: storeId,
                                    storeType: storeType,
                                    address: selectedAddress!,
                                    products: products,
                                    originalValue: originalValue,
                                    discounts: discounts,
                                    freight: freight,
                                    status: 'ordered');

                                await saveOrder(order);
                                // TODO
                                // await showSavedOrderDialog();

                                final message = buildWppMessage(order);

                                final link = WhatsAppUnilink(
                                  phoneNumber: phoneNumber,
                                  text: message,
                                );

                                await launchUrl(Uri.parse(link.toString()));
                                setState(() {
                                  loading = false;
                                });
                                // const ConfirmOrderScreen().launch(context);
                              }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectAddress() async {
    final address = await ShippingAddress(
      selectedAddress: selectedAddress,
    ).launch<Address>(context);

    setState(() {
      selectedAddress = address;
    });

    final freight =
        selectedAddress == null ? null : await calcFreight(address!);

    setState(() {
      this.freight = freight;
    });
  }

  Future<int> calcFreight(Address address) async {
    //TODO
    return 1990;
  }
}
