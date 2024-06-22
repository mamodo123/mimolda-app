import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mimolda/models/address.dart';
import 'package:mimolda/models/product.dart';
import 'package:mimolda/models/user.dart';

import '../const/app_config.dart';

Future<UserMimolda?> getUser() async {
  final auth = FirebaseAuth.instance;
  final user = auth.currentUser;
  if (user == null) {
    return null;
  } else {
    await user.reload();
    final uid = user.uid;
    final firestore = FirebaseFirestore.instance;
    final snapshot = await firestore.collection('users').doc(uid).get();
    final data = snapshot.data();
    if (data == null) {
      return null;
    } else {
      final addresses = await getAddresses(uid);
      final wishlist = await getWishlist(uid);
      return UserMimolda.fromJson(data, addresses, wishlist);
    }
  }
}

Future<List<Address>> getAddresses(String uid) async {
  final firestore = FirebaseFirestore.instance;
  final docs = await firestore
      .collection('users')
      .doc(uid)
      .collection('addresses')
      .get();
  return docs.docs
      .map<Address>((e) => Address.fromJson(e.id, e.data()))
      .toList();
}

Future<bool> updateUserAddress(String? id, Map<String, dynamic> data) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final uid = user.uid;
    final firestore = FirebaseFirestore.instance;
    final addressesCollection =
        firestore.collection('users').doc(uid).collection('addresses');
    if (id == null) {
      await addressesCollection.add(data);
    } else {
      await addressesCollection.doc(id).set(data);
    }
    return true;
  } else {
    return false;
  }
}

Future<void> deleteUserAddress(String id) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final uid = user.uid;
    final firestore = FirebaseFirestore.instance;
    final doc =
        firestore.collection('users').doc(uid).collection('addresses').doc(id);
    await doc.delete();
  }
}

Future<List<String>> getWishlist(String uid) async {
  final firestore = FirebaseFirestore.instance;
  final docs = await firestore
      .collection('users')
      .doc(uid)
      .collection('stores')
      .doc(storeId)
      .collection('wishlist')
      .get();
  return docs.docs.map<String>((e) => e['product']).toList();
}

Future<bool?> itemWishlist(Product product) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final uid = user.uid;
    final firestore = FirebaseFirestore.instance;
    final doc = firestore
        .collection('users')
        .doc(uid)
        .collection('stores')
        .doc(storeId)
        .collection('wishlist')
        .doc(product.id);

    final snapshot = await doc.get();
    if (snapshot.exists) {
      await doc.delete();
      return false;
    } else {
      await doc.set({
        'product': product.id,
        'wishlist': true,
      });
      return true;
    }
  }
  return null;
}
