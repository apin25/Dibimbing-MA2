import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_app_alvin/models/category.dart';
import 'package:inventory_app_alvin/models/inventory.dart';

class FirestoreInventoryHelper {
  CollectionReference<Inventory> _userInventoryRef() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) throw Exception("User not logged in");

    return FirebaseFirestore.instance
        .collection('users_inventory')
        .doc(uid)
        .collection('inventory')
        .withConverter<Inventory>(
          fromFirestore: (snapshot, _) => Inventory.fromJson(snapshot.data()!),
          toFirestore: (inventory, _) => inventory.toJson(),
        );
  }

  // CREATE
  Future<DocumentReference<Inventory>> addInventory(Inventory inventory) async {
    final ref = _userInventoryRef();
    final doc = await ref.add(inventory);
    await ref.doc(doc.id).update({'id': doc.id});
    return doc;
  }

 Stream<List<Inventory>> streamInventory() {
  final ref = _userInventoryRef()
      .orderBy('created_at', descending: true);

  return ref.snapshots().asyncMap((query) async {
    List<Inventory> items = [];

    for (var doc in query.docs) {
      final data = doc.data();
      final categoryId = data.category;

      Category? categoryDetails;
      if (categoryId != "" && categoryId.isNotEmpty) {
        final catDoc = await FirebaseFirestore.instance
            .collection('category')
            .doc(categoryId)
            .get();

        if (catDoc.exists) {
          categoryDetails = Category.fromJson(catDoc.data()!);
        }
      }

      data.categoryDetails = categoryDetails;
      items.add(data);
    }

    return items;
  });
}


  Future<void> updateInventory(Inventory inventory) async {
    if (inventory.id == null) {
      throw ArgumentError('Inventory ID cannot be null');
    }

    final ref = _userInventoryRef();
    await ref.doc(inventory.id).set(inventory);
  }

  Future<void> inActiveInventory(Inventory inventory) async {
    if (inventory.id == null) {
      throw ArgumentError('Inventory ID cannot be null');
    }

    final ref = _userInventoryRef();
    
    final newStatus = !inventory.isActive;

    await ref.doc(inventory.id).update({
      "is_active": newStatus ? 1 : 0,
      "updated_at": DateTime.now().toIso8601String(),
    });
  }


  Future<void> deleteInventory(String id) async {
    final ref = _userInventoryRef();
    await ref.doc(id).delete();
  }

  Stream<QuerySnapshot<Inventory>> getInventoryStream() {
    final ref = _userInventoryRef();
    return ref.orderBy('created_at', descending: true).snapshots();
  }
}