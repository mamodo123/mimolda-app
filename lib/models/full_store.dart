import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mimolda/models/category.dart';
import 'package:mimolda/models/product.dart';
import 'package:mimolda/models/store.dart';
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

  late final Store store;

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

  Future<void> reloadUser(
      {required bool reloadOrders, required bool reloadPurchases}) async {
    final user = await getUser(
        orders: reloadOrders ? null : _user?.orders,
        purchases: reloadPurchases ? null : _user?.purchases);
    _user = user;
    notifyListeners();
  }

  Future<void> reloadAddresses() async {
    final userFirebase = FirebaseAuth.instance.currentUser;
    if (userFirebase != null && user != null) {
      final addresses = await getAddresses(userFirebase.uid);
      user?.addresses = addresses;
      notifyListeners();
    }
  }

  Future<void> reloadWishlist() async {
    final userFirebase = FirebaseAuth.instance.currentUser;
    if (userFirebase != null && user != null) {
      final wishlist = await getWishlist(userFirebase.uid);
      user?.wishlist = wishlist;
      notifyListeners();
    }
  }

  Future<void> reloadOrders({bool purchases = false}) async {
    final userFirebase = FirebaseAuth.instance.currentUser;
    if (userFirebase != null && user != null) {
      final products = await getOrders(userFirebase.uid, purchases: purchases);
      if (purchases) {
        user?.purchases = products;
      } else {
        user?.orders = products;
      }
      notifyListeners();
    }
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

  void clearCart() {
    cart.clear();
    notifyListeners();
  }

  Future<bool> loadStore() async {
    final store = await getStore();
    if (store != null) {
      this.store = store;
      return true;
    }
    return false;
  }
}
