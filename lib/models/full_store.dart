import 'package:flutter/material.dart';
import 'package:mimolda/models/category.dart';
import 'package:mimolda/models/product.dart';
import 'package:mimolda/models/user.dart';

import '../data_manager/nuvemshop.dart';
import '../data_manager/user.dart';

class FullStore {
  final List<Product> products;

  List<Category> get categories => products.fold<Set<Category>>(
      <Category>{},
      (previousValue, element) =>
          previousValue..addAll(element.categories)).toList();

  List<Product> get promotionalProducts => products
      .where((element) => element.variants.fold<bool>(
          false,
          (previousValue, element) =>
              previousValue || element.promotionalPrice != null))
      .toList();

  List<Product> get bestSelling => products
      .where((element) => element.tags.contains('Mais vendidas'))
      .toList();

  List<Product> get news =>
      products.where((element) => element.tags.contains('Lancamento')).toList();

  const FullStore({required this.products});
}

class FullStoreNotifier with ChangeNotifier {
  FullStore _fullStore;
  final Map<Product, Map<Variant, int>> cart = {};
  UserMimolda? _user;

  FullStore get fullStore => _fullStore;

  UserMimolda? get user => _user;

  int get cartSize => cart.entries
      .map((e) => e.value.entries.fold<int>(
          0, (previousValue, element) => previousValue + element.value))
      .fold<int>(0, (previousValue, element) => previousValue + element);

  set fullStore(FullStore fullStore) {
    _fullStore = fullStore;
    notifyListeners();
  }

  set user(UserMimolda? user) {
    _user = user;
    notifyListeners();
  }

  int get cartWithDiscount => cart.entries.fold<int>(
      0,
      (previousValue, productEntry) =>
          previousValue +
          productEntry.value.entries.fold(
              0,
              (previousValue, variantEntry) =>
                  previousValue +
                  variantEntry.value *
                      (variantEntry.key.promotionalPrice ??
                          variantEntry.key.price ??
                          0)));

  int get cartWithoutDiscount => cart.entries.fold<int>(
      0,
      (previousValue, productEntry) =>
          previousValue +
          productEntry.value.entries.fold(
              0,
              (previousValue, variantEntry) =>
                  previousValue +
                  variantEntry.value * (variantEntry.key.price ?? 0)));

  int get cartDiscount => cartWithDiscount - cartWithoutDiscount;

  Future<void> reloadFullStore() async {
    final fullStore = await getFullStore();
    _fullStore = fullStore;
    final user = await getUser();
    _user = user;
    notifyListeners();
  }

  Future<void> reloadUser() async {
    final user = await getUser();
    _user = user;
    notifyListeners();
  }

  void addToCart(Product product, Variant variant, {int? quantity}) {
    final variantMap = cart[product] ?? {};
    final oldQuantity = variantMap[variant] ?? 0;
    variantMap[variant] = quantity ?? oldQuantity + 1;
    cart[product] = variantMap;
    notifyListeners();
  }

  void removeFromCart(Product product, Variant variant, {int? quantity}) {
    if (cart.containsKey(product)) {
      if (cart[product]!.containsKey(variant)) {
        cart[product]!.remove(variant);
        if (cart[product]!.isEmpty) {
          cart.remove(product);
        }
      }
    }
    notifyListeners();
  }

  FullStoreNotifier({required FullStore fullStore}) : _fullStore = fullStore;
}
