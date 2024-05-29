import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mimolda/const/app_config.dart';
import 'package:mimolda/models/category.dart';
import 'package:mimolda/models/full_store.dart';

import '../models/product.dart';

Future<List<Category>> getCategories() async {
  final db = FirebaseFirestore.instance;

  final categoriesSnapshot =
      await db.collection('stores').doc(storeId).collection('categories').get();
  return categoriesSnapshot.docs
      .map((e) => getCategoryFromJson(e.data()))
      .toList();
}

Category getCategoryFromJson(Map<String, dynamic> data) {
  final names = data['name'] as Map<String, dynamic>;
  final name = names.isEmpty
      ? ''
      : names['pt'] ?? names['en'] ?? names[names.keys.first];

  return Category(name: name);
}

Future<List<Product>> getProducts() async {
  final db = FirebaseFirestore.instance;

  final productsSnapshot =
      await db.collection('stores').doc(storeId).collection('products').get();
  final Map<String, Category> categoriesMap = {};
  return productsSnapshot.docs
      .map((e) => getProductFromJson(e.data(), categoriesMap))
      .toList();
}

Product getProductFromJson(
    Map<String, dynamic> data, Map<String, Category> categoriesMap) {
  final names = data['name'] as Map<String, dynamic>;
  final name = names.isEmpty
      ? ''
      : names['pt'] ?? names['en'] ?? names[names.keys.first];

  final descriptions = data['description'] as Map<String, dynamic>;
  final description = descriptions.isEmpty
      ? ''
      : descriptions['pt'] ??
          descriptions['en'] ??
          descriptions[descriptions.keys.first];

  final categoriesJson = data['categories'] as List<dynamic>;
  final categories = <Category>[];
  for (final categoryJson in categoriesJson) {
    final category = getCategoryFromJson(categoryJson);
    if (categoriesMap.containsKey(category.name)) {
      categories.add(categoriesMap[category.name]!);
    } else {
      categoriesMap[category.name] = category;
      categories.add(category);
    }
  }

  final imagesList = data['images'] as List<dynamic>;
  final images = imagesList.map<String>((e) => e['src']).toList();
  final imagesID = imagesList.map<int>((e) => e['id']).toList();
  final imagesMap = Map.fromIterables(imagesID, images);

  final attributes =
      (data['attributes'] as List<dynamic>).map<String>((attribute) {
    return attribute['pt'] ??
        attribute['en'] ??
        attribute[attribute.keys.first];
  }).toList();

  final variantsMap = data['variants'] as List<dynamic>;
  final variants = variantsMap.map<Variant>((variant) {
    final priceString = variant['price'];
    final price =
        priceString != null ? (double.parse(priceString) * 100).toInt() : null;
    final promotionalString = variant['promotional_price'];
    final promotionalPrice = promotionalString != null
        ? (double.parse(promotionalString) * 100).toInt()
        : null;

    final values = (variant['values'] as List<dynamic>).map<String>((value) {
      return value['pt'] ?? value['en'] ?? value[value.keys.first];
    }).toList();

    final attributesMap = Map.fromIterables(attributes, values);
    final imageId = variant['image_id'] as int?;
    final image = imageId == null ? images.first : imagesMap[imageId];
    return Variant(
        price: price,
        promotionalPrice: promotionalPrice,
        attributes: attributesMap,
        image: image);
  }).toList();
  final tags = (data['tags'] as String).split(',');

  return Product(
      name: name,
      description: description,
      images: images,
      categories: categories,
      variants: variants,
      attributes: attributes,
      tags: tags);
}

Future<FullStore> getFullStore() async {
  // final categories = await getCategories();
  final products = await getProducts();
  return FullStore(products: products);
}
