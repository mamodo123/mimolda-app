import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mimolda/models/user.dart';

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
      return UserMimolda.fromJson(data);
    }
  }
}
