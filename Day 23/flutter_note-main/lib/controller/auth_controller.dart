import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_note/auth_helper.dart';
import 'package:flutter_note/firestore_user_helper.dart';

class AuthController extends GetxController {
  final AuthHelper authHelper;
  final FirestoreUserHelper userHelper;

  AuthController(this.authHelper, this.userHelper);

  final Rxn<User> user = Rxn<User>();
  final RxBool loading = false.obs;
  final RxnString error = RxnString();

  @override
  void onInit() {
    super.onInit();
    FirebaseAuth.instance.authStateChanges().listen((firebaseUser) {
      user.value = firebaseUser;
    });
  }

  Future<void> signIn(String email, String password) async {
    try {
      loading.value = true;
      error.value = null;

      await authHelper.signInWithEmailAndPassword(email, password);
    } catch (e) {
      error.value = e.toString();
    } finally {
      loading.value = false;
    }
  }

  Future<void> signOut() async {
    await authHelper.signOut();
  }

  User? get currentUser => user.value;
}
