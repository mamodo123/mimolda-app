import 'package:mimolda/models/address.dart';

enum OrderStatus {
  ordered,
  accepted,
  refused,
  canceled,
  sent,
  onProbation,
  waitingReturn,
  finished,
  paymentProblem,
}

class MimoldaOrder {
  final String client,
      clientId,
      payment,
      storeId,
      storeType,
      status,
      period,
      observations;
  final Address address;
  final List<ProductOrder> products;
  final int originalValue, discounts, freight;
  final DateTime deliveryDate, createdAt, updatedAt;

  int get totalValue => originalValue + discounts + freight;

  MimoldaOrder({
    required this.client,
    required this.clientId,
    required this.payment,
    required this.storeId,
    required this.storeType,
    required this.observations,
    required this.address,
    required this.products,
    required this.originalValue,
    required this.discounts,
    required this.freight,
    required this.status,
    required this.period,
    required this.deliveryDate,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        'client': client,
        'clientId': clientId,
        'payment': payment,
        'storeId': storeId,
        'storeType': storeType,
        'observations': observations,
        'address': address.toJson(),
        'originalValue': originalValue,
        'discounts': discounts,
        'freight': freight,
        'status': status,
        'products': products.map<Map<String, dynamic>>((e) => e.toJson()),
        'period': period,
        'deliveryDate': deliveryDate,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
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
