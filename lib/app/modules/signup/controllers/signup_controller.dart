import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:invoice/model/user_model.dart';

class SignupController extends GetxController {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  var passwordVisible = false.obs;

  static Future<User> signup(String email, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    addUser(UserModel(userId: credential.user!.uid, email: email));
    return credential.user!;
  }

  static Future<void> addUser(UserModel userModel) {
    return _db
        .collection(collectionUser)
        .doc(userModel.userId)
        .set(userModel.toMap());
  }

  void togglePasswordVisibility() {
    passwordVisible.toggle();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
