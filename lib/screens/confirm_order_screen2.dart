import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

class ConfirmOrderScreen2 extends StatefulWidget {
  final MimoldaOrder order;

  const ConfirmOrderScreen2({super.key, required this.order});

  @override
  State<ConfirmOrderScreen2> createState() => _ConfirmOrderScreen2State();
}

class _ConfirmOrderScreen2State extends State<ConfirmOrderScreen2> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: loading,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: const MyGoogleText(
            text: 'Confirmar pedido',
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
                    const MyGoogleText(
                      text: 'Produtos',
                      fontSize: 20,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                    const SizedBox(height: 5),
                    Column(
                      children: widget.order.products.map<Widget>((product) {
                        return ProductOrderItemSingleView(
                          product: product,
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 20),

                    MyGoogleText(
                      text:
                          'Endereço de ${widget.order.address.id == '' ? 'retirada' : 'entrega'}',
                      fontSize: 20,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                    const SizedBox(height: 5),
                    MyGoogleText(
                      text: widget.order.address.fullAddress,
                      fontSize: 15,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                    const SizedBox(height: 20),
                    MyGoogleText(
                      text:
                          'Data de ${widget.order.address.id == '' ? 'retirada' : 'entrega'}',
                      fontSize: 20,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                    const SizedBox(height: 5),
                    MyGoogleText(
                      text: DateFormat('dd/MM/yyyy')
                          .format(widget.order.deliveryDate),
                      fontSize: 15,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                    const SizedBox(height: 20),
                    MyGoogleText(
                      text:
                          'Período de ${widget.order.address.id == '' ? 'retirada' : 'entrega'}',
                      fontSize: 20,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                    const SizedBox(height: 5),
                    MyGoogleText(
                      text: widget.order.period,
                      fontSize: 15,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                    const SizedBox(height: 20),
                    const MyGoogleText(
                      text: 'Método de pagamento',
                      fontSize: 20,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                    const SizedBox(height: 5),
                    ListTile(
                      leading: Image(
                          image: AssetImage(paymentImageList[
                              paymentNameList.indexOf(widget.order.payment)])),
                      title: MyGoogleText(
                        text: widget.order.payment,
                        fontSize: 16,
                        fontColor: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const MyGoogleText(
                      text: 'Observações',
                      fontSize: 20,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.all(5),
                      width: double.infinity,
                      color: Colors.grey.shade50,
                      child: MyGoogleText(
                        text: widget.order.observations.trim().isEmpty
                            ? 'Nenhuma'
                            : widget.order.observations,
                        fontSize: 16,
                        fontColor: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 20),

                    ///_____Cost_Section_____________
                    CartCostSection(freight: widget.order.freight),

                    Button1(
                        loading: loading,
                        buttonText: 'Realizar pedido',
                        buttonColor: primaryColor,
                        onPressFunction: () async {
                          setState(() {
                            loading = true;
                          });

                          final fullStore = context.read<FullStoreNotifier>();

                          await saveOrder(widget.order);

                          if (context.mounted) {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Pedido registrado!'),
                                  content: const Text(
                                    'Agora, você será redirecionado para o WhatsApp da loja para confirmar seu pedido.\n\nIsso acelera o processo e garante que não haverá problemas.',
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        // Aqui você pode adicionar o código para redirecionar para o WhatsApp
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }

                          final message = buildWppMessage(widget.order);

                          final link = WhatsAppUnilink(
                            phoneNumber: phoneNumber,
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
}
