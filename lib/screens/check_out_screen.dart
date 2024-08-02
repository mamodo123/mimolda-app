import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mimolda/screens/shipping_address.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../const/app_config.dart';
import '../const/constants.dart';
import '../const/values.dart';
import '../models/address.dart';
import '../models/full_store.dart';
import '../models/order.dart';
import '../widgets/buttons.dart';
import 'confirm_order_screen2.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  String whichPaymentIsChecked = 'Cartão';
  Address? selectedAddress;
  int? freight;
  DateTime? _selectedDate;
  String? _selectedPeriod;
  var loading = false;

  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      locale: const Locale('pt', 'BR'),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 2)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: loading,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
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
                      MyGoogleText(
                        text:
                            'Endereço de ${selectedAddress?.id == '' ? 'retirada' : 'entrega'}',
                        fontSize: 20,
                        fontColor: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: selectAddress,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: secondaryColor3),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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

                      MyGoogleText(
                        text:
                            'Data de ${selectedAddress?.id == '' ? 'retirada' : 'entrega'}',
                        fontSize: 20,
                        fontColor: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => _selectDate(context),
                              child: Text(_selectedDate == null
                                  ? 'Selecione a data'
                                  : DateFormat('dd/MM/yyyy')
                                      .format(_selectedDate!)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const MyGoogleText(
                        text: 'Período',
                        fontSize: 20,
                        fontColor: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text('Manhã'),
                              value: 'Manhã',
                              groupValue: _selectedPeriod,
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedPeriod = value;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              title: const Text('Tarde'),
                              value: 'Tarde',
                              groupValue: _selectedPeriod,
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedPeriod = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      ///_______Payment_method________________________
                      // const Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      const MyGoogleText(
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
                      //   ],
                      // ),
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
                                            image: AssetImage(
                                                paymentImageList[i])),
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
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                    )
                                  : ListTile(
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
                                        icon:
                                            const Icon(Icons.radio_button_off),
                                      ),
                                    );
                            }),
                      ),
                      const SizedBox(height: 20),
                      const MyGoogleText(
                        text: 'Observações',
                        fontSize: 20,
                        fontColor: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      const SizedBox(height: 10),

                      AppTextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Ex: Entregar antes das 15:00.',
                        ),
                        textFieldType: TextFieldType.MULTILINE,
                        minLines: 3,
                        maxLines: null,
                        maxLength: 100,
                      ),

                      const SizedBox(height: 20),

                      ///___________Pay_Now_Button___________________________________
                      Button1(
                          loading: loading,
                          buttonText: 'Revisar pedido',
                          buttonColor: primaryColor,
                          onPressFunction: selectedAddress == null ||
                                  _selectedDate == null ||
                                  _selectedPeriod == null
                              ? null
                              : () async {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
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
                                  final now = DateTime.now();
                                  final order = MimoldaOrder(
                                      id: null,
                                      justification: null,
                                      notification: 'store',
                                      statusHistory: [
                                        {'status': 'ordered', 'updatedAt': now}
                                      ],
                                      client: fullStore.user!.name,
                                      clientId: clientId,
                                      payment: whichPaymentIsChecked,
                                      storeId: storeId,
                                      storeType: storeType,
                                      observations: controller.text,
                                      address: selectedAddress!,
                                      products: products,
                                      originalValue: originalValue,
                                      discounts: discounts,
                                      freight: freight,
                                      status: 'ordered',
                                      period: _selectedPeriod!,
                                      deliveryDate: _selectedDate!,
                                      createdAt: now,
                                      updatedAt: now,
                                      probationOrderId: null,
                                      purchaseOrderId: null,
                                      type: 'probation');

                                  ConfirmOrderScreen2(order: order)
                                      .launch(context);
                                }),
                    ],
                  ),
                ),
              ],
            ),
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
