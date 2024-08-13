import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../const/translations.dart';
import '../data_manager/nuvemshop.dart';
import '../functions/hashcode.dart';
import '../models/order.dart';
import '../models/store.dart';
import '../widgets/cart_cost_section.dart';
import '../widgets/cart_item_single_view.dart';

class OrderDialog extends StatefulWidget {
  final Store store;
  final MimoldaOrder order;
  final Map<String, int> statusHistory;
  final bool isComputer;

  const OrderDialog(
      {super.key,
      required this.store,
      required this.order,
      required this.statusHistory,
      this.isComputer = true,
      required});

  @override
  State<OrderDialog> createState() => _OrderDialogState();
}

class _OrderDialogState extends State<OrderDialog> {
  var loading = false;

  final phoneMask = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );
  final cpfMask = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    final order = widget.order;

    return AbsorbPointer(
      absorbing: loading,
      child: Stack(
        children: [
          AlertDialog(
              insetPadding: const EdgeInsets.all(10),
              title: Center(
                  child: Text(
                'Pedido #${hashN(order.id ?? '', 6)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              )),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    if (order.probationOrderId != null)
                      Text(
                          'Origem: provação #${hashN(order.probationOrderId!, 6)}',
                          textAlign: TextAlign.center),
                    if (order.purchaseOrderId != null)
                      Text(
                          'Compra após provação: #${hashN(order.purchaseOrderId!, 6)}',
                          textAlign: TextAlign.center),
                    Text(
                        'Status: ${order.isExpired ? 'Expirado' : (order.type == 'purchase' ? purchaseStatusTranslator : orderStatusTranslator)[order.status]}'),
                    Text(
                        'Pedido em: ${DateFormat('dd/MM/yyyy kk:mm').format(order.createdAt)}'),
                    Text(
                        'Última atualização: ${DateFormat('dd/MM/yyyy kk:mm').format(order.updatedAt)}'),
                    if (order.justification != null)
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Justificativa:',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(order.justification!),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (order.address != null)
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Dados de ${order.address!.id.isEmpty ? 'retirada' : 'entrega'}:',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Text(
                                  order.address!.id.isEmpty
                                      ? 'Retirar na loja'
                                      : order.address!.fullAddress,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Text(
                              'Raio de distância: ${(Geolocator.distanceBetween(widget.store.storeAddress.latitude, widget.store.storeAddress.longitude, order.address!.latitude, order.address!.longitude) / 1000).toStringAsFixed(2).replaceAll('.', ',')} km'),
                          Text(
                              'Data de ${order.address!.id.isEmpty ? 'retirada' : 'entrega'}: ${DateFormat('dd/MM/yyyy').format(order.deliveryDate!.toUtc())}, ${order.period}'),
                        ],
                      ),
                    if (order.payment != null)
                      Text('Pagamento: ${order.payment}'),
                    if (order.observations.isNotEmpty)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Observações:',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(order.observations),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Produtos:',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Column(
                          children: order.products.map<Widget>((product) {
                            return ProductOrderItemSingleView(
                              product: product,
                            );
                          }).toList(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    if (order.returningProducts != null)
                      Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Devoluções:',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Column(
                            children:
                                order.returningProducts!.map<Widget>((product) {
                              return ProductOrderItemSingleView(
                                product: product,
                              );
                            }).toList(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    CartCostOrderSection(
                        order: order, onlyFreight: order.type == 'probation'),
                  ],
                ),
              ),
              actions: getActions(context, order)),
          if (loading)
            Container(
              color: Colors.white.withOpacity(0.7),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
        ],
      ),
    );
  }

  List<Widget> getActions(BuildContext context, MimoldaOrder order) {
    final status = order.status;
    if (order.isExpired) {
      return [
        TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Ok'),
            onPressed: () async {
              Navigator.of(context).pop();
            })
      ];
    } else if (status == 'ordered' ||
        (status == 'accepted' && order.address != null)) {
      return [
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Cancelar pedido'),
          onPressed: () async {
            setState(() {
              loading = true;
            });

            final justification = await getJustification(context);

            if (justification != null) {
              await setOrderField(order, 'justification', justification);
              await setStatusFromOrder(order, 'canceledByClient');

              setState(() {
                loading = false;
              });
              if (context.mounted) {
                Navigator.of(context).pop(true);
              }
            } else {
              setState(() {
                loading = false;
              });
            }
          },
        ),
        TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Ok'),
            onPressed: () async {
              Navigator.of(context).pop();
            })
      ];
    } else if (status == 'onProbation') {
      return [
        TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Finalizar provação'),
            onPressed: () async {
              Navigator.of(context)
                  .pushNamed('/cart_probation', arguments: order);
            }),
        TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Ok'),
            onPressed: () async {
              Navigator.of(context).pop();
            })
      ];
    } else {
      return [
        TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Ok'),
            onPressed: () async {
              Navigator.of(context).pop();
            })
      ];
    }
  }

  Future<String?> getJustification(BuildContext context,
      {String title = 'Justificativa',
      String hint = 'Digite o porquê do cancelamento (opcional)',
      String buttonText = 'Cancelar pedido',
      bool mandatory = false}) async {
    TextEditingController justificationController = TextEditingController();
    final formkey = GlobalKey<FormState>();

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: formkey,
                child: TextFormField(
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Campo não pode ser vazio';
                    }
                    return null;
                  },
                  controller: justificationController,
                  maxLines: null,
                  maxLength: 200,
                  decoration: InputDecoration(
                    hintText: hint,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Voltar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(buttonText),
              onPressed: () {
                if (!mandatory || (formkey.currentState?.validate() ?? true)) {
                  Navigator.of(context).pop(justificationController.text);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
