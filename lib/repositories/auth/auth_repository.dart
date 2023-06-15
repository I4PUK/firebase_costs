import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_costs/models/user_model.dart';
import 'package:firebase_costs/services/authentication_service.dart';

abstract class AuthRepository {
  Future<UserCredential?> signUp(UserModel user);
  Future<UserCredential?> signIn(UserModel user);
  Future<void> signOut();
}

class AuthRepositoryImpl implements AuthRepository {
  AuthenticationService authService;

  AuthRepositoryImpl(this.authService);

  @override
  Future<UserCredential?> signUp(UserModel user) {
    try {
      return authService.signUp(user);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  @override
  Future<UserCredential?> signIn(UserModel user) {
    try {
      return authService.signIn(user);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  @override
  Future<void> signOut() {
    return authService.signOut();
  }
}
