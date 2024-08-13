import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../models/order.dart';
import '../screens/cart_probation_screen.dart';
import 'hashcode.dart';

String buildNormalOrderMessage(MimoldaOrder order) {
  final products = getProducts(order.products);
  var messageBuffer = [
    '*Pedido de ${order.type == 'purchase' ? 'compra' : 'provação'}*',
    '',
    'Cliente: ${order.client}',
    if (order.address != null)
      'Local de entrega:  ${order.address!.id == '' ? 'Retirar na loja' : order.address!.fullAddress}',
    if (order.deliveryDate != null)
      'Data de entrega: ${DateFormat('dd/MM/yyyy').format(order.deliveryDate!)}',
    if (order.period != null) 'Período: ${order.period}',
    if (order.payment != null) 'Pagamento: ${order.payment}',
    'Observações: ${order.observations}',
    '',
    'Produtos:',
    '--------------------------',
    products,
    '--------------------------',
    '',
    'Valor original: ${'R\$${(order.originalValue / 100).toStringAsFixed(2)}'}',
    'Descontos: ${'R\$${(order.discounts / 100).toStringAsFixed(2)}'}',
    if (order.freight != null)
      'Frete: ${'R\$${(order.freight! / 100).toStringAsFixed(2)}'}',
    '',
    'Valor total: ${'R\$${(order.totalValue / 100).toStringAsFixed(2)}'}'
  ];
  return messageBuffer.join('\n');
}

String getProducts(List<ProductOrder> products) {
  final items = <String>[];
  for (final product in products) {
    final variantName = product.attributes.values.join(' ');
    items.add(
        '${product.quantity}x ${product.product}${variantName == '' ? '' : ' ($variantName)'}');
  }
  return items.join('\n');
}

String? buildFromProbationOrderMessage(
    ProbationPurchase probationPurchase, MimoldaOrder? purchaseOrder) {
  final oldOrder = probationPurchase.oldOrder;
  final titleArray = [
    if (probationPurchase.hasReturn) 'devolução',
    if (purchaseOrder != null) 'compra'
  ];
  final title = '*${titleArray.join(' e ').capitalizeFirstLetter()} de peças*';

  final purchaseArray = purchaseOrder == null
      ? ['  Nenhuma']
      : [
          if (purchaseOrder.payment != null)
            'Pagamento: ${purchaseOrder.payment}',
          'Observações: ${purchaseOrder.observations}',
          '',
          'Produtos:',
          '--------------------------',
          getProducts(purchaseOrder.products),
          '--------------------------',
          '',
          'Valor original: ${'R\$${(purchaseOrder.originalValue / 100).toStringAsFixed(2)}'}',
          'Descontos: ${'R\$${(purchaseOrder.discounts / 100).toStringAsFixed(2)}'}',
          '',
          'Valor total: ${'R\$${(purchaseOrder.totalValue / 100).toStringAsFixed(2)}'}',
        ];
  final returnProbationArray = probationPurchase.hasReturn
      ? [
          '',
          'Produtos:',
          '--------------------------',
          getProducts(probationPurchase.returnProducts!),
          '--------------------------',
        ]
      : [' Nenhuma'];

  return [
    title,
    '',
    'Cliente: ${oldOrder.client}',
    'Pedido de provação original: #${hashN(oldOrder.id ?? '', 6)}'
        '',
    '*Compra*',
    ...purchaseArray,
    '*Devolução*',
    ...returnProbationArray,
  ].join('\n');
}
