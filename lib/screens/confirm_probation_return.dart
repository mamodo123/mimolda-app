import 'package:flutter/material.dart';
import 'package:mimolda/models/order.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../const/app_config.dart';
import '../const/constants.dart';
import '../const/values.dart';
import '../data_manager/nuvemshop.dart';
import '../functions/wpp_message.dart';
import '../models/full_store.dart';
import '../widgets/buttons.dart';
import '../widgets/cart_cost_section.dart';
import '../widgets/cart_item_single_view.dart';
import 'cart_probation_screen.dart';

class ConfirmProbationReturn extends StatefulWidget {
  final ProbationPurchase probationPurchase;

  const ConfirmProbationReturn({super.key, required this.probationPurchase});

  @override
  State<ConfirmProbationReturn> createState() => _ConfirmProbationReturnState();
}

class _ConfirmProbationReturnState extends State<ConfirmProbationReturn> {
  bool loading = false;
  String whichPaymentIsChecked = 'Cartão';
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final hasPurchase = widget.probationPurchase.products != null;
    final hasReturn = widget.probationPurchase.hasReturn;
    final options = [if (hasPurchase) 'compra', if (hasReturn) 'devolução'];
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
            title: MyGoogleText(
              text: 'Confirmar ${options.join('/')}',
              fontColor: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 18,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
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
                      if (hasReturn)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const MyGoogleText(
                              text: 'Devoluções',
                              fontSize: 20,
                              fontColor: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                            const SizedBox(height: 5),
                            Column(
                              children: widget.probationPurchase.returnProducts!
                                  .map<Widget>((product) {
                                return ProductOrderItemSingleView(
                                  product: product,
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      if (hasPurchase)
                        Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const MyGoogleText(
                                  text: 'Compras',
                                  fontSize: 20,
                                  fontColor: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                                const SizedBox(height: 5),
                                Column(
                                  children: widget
                                      .probationPurchase.purchaseProducts!
                                      .map<Widget>((product) {
                                    return ProductOrderItemSingleView(
                                      product: product,
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const MyGoogleText(
                                  text: 'Método de pagamento',
                                  fontSize: 20,
                                  fontColor: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: secondaryColor3),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                  ),
                                  child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: paymentImageList.length,
                                      itemBuilder: (context, i) {
                                        return whichPaymentIsChecked ==
                                                paymentNameList[i]
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
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                  trailing: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        whichPaymentIsChecked =
                                                            paymentNameList[i];
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons
                                                          .radio_button_checked,
                                                      color: primaryColor,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : ListTile(
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
                                                      Icons.radio_button_off),
                                                ),
                                              );
                                      }),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                    hintText:
                                        'Ex: Pagarei amanhã na loja ao devolver.',
                                  ),
                                  textFieldType: TextFieldType.MULTILINE,
                                  minLines: 3,
                                  maxLines: null,
                                  maxLength: 100,
                                ),
                              ],
                            ),

                            ///_____Cost_Section_____________
                            CartProbationSection(
                              products: Map.fromEntries(widget
                                  .probationPurchase.purchaseProducts!
                                  .map((e) => MapEntry(e, e.quantity))),
                              freight: null,
                              showFreight: false,
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      Button1(
                          loading: loading,
                          buttonText: 'Realizar ${options.join(' e ')}',
                          buttonColor: primaryColor,
                          onPressFunction: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            setState(() {
                              loading = true;
                            });
                            final fullStore = context.read<FullStoreNotifier>();
                            final now = DateTime.now();
                            MimoldaOrder? purchaseOrder;
                            if (hasPurchase) {
                              final originalValue = widget
                                  .probationPurchase.purchaseProducts!
                                  .fold<int>(
                                      0,
                                      (total, e) =>
                                          total +
                                          (e.quantity * (e.price ?? 0)));
                              final promotionalValue = widget
                                  .probationPurchase.purchaseProducts!
                                  .fold<int>(
                                      0,
                                      (total, e) =>
                                          total +
                                          (e.quantity *
                                              (e.promotionalPrice ??
                                                  e.price ??
                                                  0)));
                              final discounts =
                                  promotionalValue - originalValue;
                              purchaseOrder = MimoldaOrder(
                                id: null,
                                client:
                                    widget.probationPurchase.oldOrder.client,
                                clientId:
                                    widget.probationPurchase.oldOrder.clientId,
                                payment: whichPaymentIsChecked,
                                storeId: storeId,
                                storeType: storeType,
                                observations: controller.text.trim(),
                                address: null,
                                products:
                                    widget.probationPurchase.purchaseProducts!,
                                originalValue: originalValue,
                                discounts: discounts,
                                freight: null,
                                status: 'accepted',
                                period: null,
                                deliveryDate: null,
                                createdAt: now,
                                updatedAt: now,
                                statusHistory: [
                                  {
                                    'status': 'proven',
                                    'updatedAt': widget
                                        .probationPurchase.oldOrder.createdAt,
                                  },
                                  {
                                    'status': 'ordered',
                                    'updatedAt': now,
                                  },
                                  {
                                    'status': 'accepted',
                                    'updatedAt': now,
                                  }
                                ],
                                justification: null,
                                notification: 'store',
                                probationOrderId:
                                    widget.probationPurchase.oldOrder.id,
                                purchaseOrderId: null,
                                type: 'purchase',
                              );
                              await saveOrder(purchaseOrder);
                              await fullStore.reloadOrders(purchases: true);
                            }

                            final returnProducts =
                                widget.probationPurchase.returnProducts;
                            if (returnProducts != null) {
                              await setReturningProducts(
                                  widget.probationPurchase.oldOrder,
                                  returnProducts);
                            }

                            await fullStore.reloadOrders();

                            if (context.mounted) {
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Pedido registrado!'),
                                    content: const Text(
                                      'Agora, você será redirecionado para o WhatsApp da loja para confirmar seu pedido e finalizar a sua provação.\n\nIsso acelera o processo e garante que não haverá problemas.',
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                            //
                            final message = buildFromProbationOrderMessage(
                                widget.probationPurchase, purchaseOrder);
                            final link = WhatsAppUnilink(
                              phoneNumber: fullStore.store.phoneNumber,
                              text: message,
                            );
                            await launchUrl(Uri.parse(link.toString()));
                            setState(() {
                              loading = false;
                            });

                            fullStore.clearCart();
                            if (context.mounted) {
                              Navigator.of(context).popUntil(
                                  (route) => route.settings.name == '/home');
                            }
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
}
