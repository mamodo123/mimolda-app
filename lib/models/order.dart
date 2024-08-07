import '../functions/date.dart';
import 'address.dart';

class MimoldaOrder {
  final String client, clientId, storeId, storeType, status, observations, type;
  final Address? address;
  final List<ProductOrder> products;
  final List<ProductOrder>? returningProducts;
  final int originalValue, discounts;
  final int? freight;
  final DateTime? deliveryDate;
  final DateTime createdAt, updatedAt;
  final List<Map<String, dynamic>> statusHistory;
  final String? payment,
      period,
      id,
      justification,
      notification,
      probationOrderId,
      purchaseOrderId;

  int get totalValue => originalValue + discounts + (freight ?? 0);

  bool get isExpired {
    if (deliveryDate == null) {
      return false;
    }
    if (status != 'ordered') {
      return false;
    }
    final now = DateTime.now();

    if (isSameDay(createdAt, deliveryDate!.toUtc())) {
      return now.difference(createdAt).inMinutes >= 3 * 60;
    } else {
      return now.difference(createdAt).inMinutes >= 6 * 60 ||
          (isSameDay(now, deliveryDate!.toUtc()) && now.hour >= 12);
    }
  }

  String? get late {
    if (deliveryDate == null) {
      return null;
    }
    if (['accepted', 'onProbation'].contains(status)) {
      final now = DateTime.now();
      if (status == 'accepted') {
        if (isSameDay(now, deliveryDate!.toUtc())) {
          return 'Hoje';
        } else if (now.isAfter(deliveryDate!.toUtc())) {
          return 'Atrasado';
        }
      } else if (status == 'onProbation') {
        final returnDay = deliveryDate!.toUtc().add(const Duration(days: 2));
        if (isSameDay(now, returnDay)) {
          return 'Hoje';
        } else if (now.isAfter(returnDay)) {
          return 'Atrasado';
        }
      }
    }
    return null;
  }

  MimoldaOrder.fromJson(Map<String, dynamic> data, this.id)
      : client = data['client'],
        clientId = data['clientId'],
        payment = data['payment'],
        storeId = data['storeId'],
        storeType = data['storeType'],
        status = data['status'],
        period = data['period'],
        observations = data['observations'] ?? '',
        originalValue = data['originalValue'],
        discounts = data['discounts'],
        freight = data['freight'],
        deliveryDate = data['deliveryDate']?.toDate(),
        createdAt = data['createdAt'].toDate(),
        updatedAt = data['updatedAt'].toDate(),
        address = data['address'] == null
            ? null
            : Address.fromJson(data['address']['id'], data['address']),
        products = (data['products'] as List)
            .map((productMap) => ProductOrder.fromJson(productMap))
            .toList(),
        returningProducts = (data['products'] as List?)
            ?.map((productMap) => ProductOrder.fromJson(productMap))
            .toList(),
        statusHistory = (data['statusHistory'] as List?)
                ?.map((e) => Map<String, dynamic>.from(e))
                .toList() ??
            [],
        justification = data['justification'],
        notification = data['notification'],
        probationOrderId = data['probationOrderId'],
        purchaseOrderId = data['purchaseOrderId'],
        type = data['type'] ?? 'probation';

  MimoldaOrder({
    required this.id,
    required this.client,
    required this.clientId,
    required this.payment,
    required this.storeId,
    required this.storeType,
    required this.observations,
    required this.address,
    required this.products,
    required this.returningProducts,
    required this.originalValue,
    required this.discounts,
    required this.freight,
    required this.status,
    required this.period,
    required this.deliveryDate,
    required this.createdAt,
    required this.updatedAt,
    required this.statusHistory,
    required this.justification,
    required this.notification,
    required this.probationOrderId,
    required this.purchaseOrderId,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
        'client': client,
        'clientId': clientId,
        'payment': payment,
        'storeId': storeId,
        'storeType': storeType,
        'observations': observations,
        'address': address?.toJson(),
        'originalValue': originalValue,
        'discounts': discounts,
        'freight': freight,
        'status': status,
        'products': products.map<Map<String, dynamic>>((e) => e.toJson()),
        'returningProducts':
            returningProducts?.map<Map<String, dynamic>>((e) => e.toJson()),
        'period': period,
        'deliveryDate': deliveryDate,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'statusHistory': statusHistory,
        'probationOrderId': probationOrderId,
        'purchaseOrderId': purchaseOrderId,
        'type': type,
      };
}

class ProductOrder {
  final String product, productId;
  final String? image;
  final Map<String, String> attributes;
  final int? price, promotionalPrice;
  final int quantity;

  ProductOrder.fromJson(Map<String, dynamic> data)
      : product = data['product'],
        productId = data['productId'],
        image = data['image'],
        price = data['price'],
        promotionalPrice = data['promotionalPrice'],
        quantity = data['quantity'],
        attributes = Map.from(data['attributes']);

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
