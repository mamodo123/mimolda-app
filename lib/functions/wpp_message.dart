import 'package:intl/intl.dart';

import '../models/order.dart';

String? buildWppMessage(MimoldaOrder order) {
  final products = getProducts(order.products);
  var messageBuffer = """*Pedido de provação*
  
Cliente: ${order.client}
Local de entrega:  ${order.address.id == '' ? 'Retirar na loja' : order.address.fullAddress}
Data de entrega: ${DateFormat('dd/MM/yyyy').format(order.deliveryDate)}
Período: ${order.period}
Pagamento: ${order.payment}

Produtos:
--------------------------
$products
--------------------------

Valor original: ${'R\$${(order.originalValue / 100).toStringAsFixed(2)}'}
Descontos: ${'R\$${(order.discounts / 100).toStringAsFixed(2)}'}
Frete: ${'R\$${(order.freight / 100).toStringAsFixed(2)}'}

Valor total: ${'R\$${(order.totalValue / 100).toStringAsFixed(2)}'}""";
  return messageBuffer;
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
