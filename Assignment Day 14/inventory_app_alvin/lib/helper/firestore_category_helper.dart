import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/category.dart';

class FirestoreCategoryHelper {
  final categoryRef = FirebaseFirestore.instance
      .collection('category')
      .withConverter<Category>(
        fromFirestore: (snapshots, _) =>
            Category.fromJson(snapshots.data()!),
        toFirestore: (category, _) => category.toJson(),
      );

  Future<DocumentReference<Category>> addCategory(Category category) async {
    final doc = await categoryRef.add(category);

    final categoryRefUpdated = categoryRef.doc(doc.id);
    categoryRefUpdated.update({'id': doc.id});

    return doc;
  }

  Future removeCategory(int id) async {
    await categoryRef.doc(id.toString()).delete();
  }

  Future<bool> isFavourite(int id) async {
    final result = await categoryRef.doc(id.toString()).get();
    return result.exists;
  }

  Future<List<Category>> getAllCategory() async {
    final dataSnapshot = await categoryRef.get();
    return dataSnapshot.docs.map((doc) => doc.data()).toList();
  }

  Stream<QuerySnapshot> getAllCategoryRealTime() {
    return categoryRef.snapshots();
  }

  Future<void> updateCategory(Category category) async {
    if (category.id == null) {
      throw ArgumentError('Category ID cannot be null for update operation.');
    }
    final docRef = categoryRef.doc(category.id);
    await docRef.set(category);
  }
  Future<void> deleteCategory(String id) async {
    final docRef = categoryRef.doc(id);
    await docRef.delete();
  }
}