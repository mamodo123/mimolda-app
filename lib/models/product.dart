import 'package:mimolda/models/category.dart';

class Product {
  final String id;
  final String name, description;
  final List<String> images;
  final List<Category> categories;
  final List<Variant> variants;
  final List<String> attributes;
  final List<String> tags;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.images,
      required this.categories,
      required this.variants,
      required this.attributes,
      required this.tags});
}

class Variant {
  final int? price, promotionalPrice;
  final Map<String, String> attributes;
  final String? image;

  Variant(
      {required this.price,
      required this.promotionalPrice,
      required this.attributes,
      required this.image});
}
