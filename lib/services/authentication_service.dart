import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_costs/main.dart';
import 'package:firebase_costs/models/user_model.dart';
import 'package:firebase_costs/services/database_service.dart';

class AuthenticationService {
  FirebaseAuth auth = FirebaseAuth.instance;

  DatabaseService databaseService;

  AuthenticationService(this.databaseService);

  Future<UserCredential?> signUp(UserModel user) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user.email!, password: user.password!);
      verifyEmail();

      userUid = userCredential.user?.uid ?? '';

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  Future<UserCredential?> signIn(UserModel user) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: user.email!, password: user.password!);

      userUid = userCredential.user?.uid ?? '';

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  Future<void> verifyEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      return await user.sendEmailVerification();
    }
  }

  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
