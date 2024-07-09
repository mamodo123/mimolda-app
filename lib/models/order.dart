import 'package:mimolda/models/address.dart';

enum OrderStatus {
  ordered,
  accepted,
  refused,
  canceled,
  sent,
  onProbation,
  waitingReturn,
  finished
}

class MimoldaOrder {
  final String client, clientId, payment, storeId, storeType, status;
  final Address address;
  final List<ProductOrder> products;
  final int originalValue, discounts, freight;

  int get totalValue => originalValue - discounts + freight;

  MimoldaOrder(
      {required this.client,
      required this.clientId,
      required this.payment,
      required this.storeId,
      required this.storeType,
      required this.address,
      required this.products,
      required this.originalValue,
      required this.discounts,
      required this.freight,
      required this.status});

  Map<String, dynamic> toJson() => {
        'client': client,
        'clientId': clientId,
        'payment': payment,
        'storeId': storeId,
        'storeType': storeType,
        'address': address.toJson(),
        'originalValue': originalValue,
        'discounts': discounts,
        'freight': freight,
        'status': status,
        'products': products.map<Map<String, dynamic>>((e) => e.toJson()),
      };
}

class ProductOrder {
  final String product, productId;
  final String? image;
  final Map<String, String> attributes;
  final int? price, promotionalPrice;
  final int quantity;

  ProductOrder(
      {required this.product,
      required this.productId,
      required this.image,
      required this.attributes,
      required this.price,
      required this.promotionalPrice,
      required this.quantity});

  Map<String, dynamic> toJson() => {
        'product': product,
        'productId': productId,
        'image': image,
        'attributes': attributes,
        'price': price,
        'promotionalPrice': promotionalPrice,
        'quantity': quantity,
      };
}
