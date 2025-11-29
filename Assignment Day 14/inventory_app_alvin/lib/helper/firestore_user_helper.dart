import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/users.dart';

class FirestoreUserHelper {
  final _userRef = FirebaseFirestore.instance
      .collection('users')
      .withConverter<Users>(
        fromFirestore: (snapshot, _) => Users.fromJson(snapshot.data()!),
        toFirestore: (users, _) => users.toJson(),
      );

  Future addUser(Users user) async {
    await _userRef.doc(user.id).set(user);
  }
}