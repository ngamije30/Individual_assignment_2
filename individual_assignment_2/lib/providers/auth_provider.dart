import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _repo = AuthRepository();

  User? user;
  bool isLoading = false;

  AuthProvider() {
    _repo.authStateChanges.listen((u) {
      user = u;
      notifyListeners();
    });
  }

  Future<void> signUp(String email, String password) async {
    isLoading = true;
    notifyListeners();
    await _repo.signUp(email, password);
    isLoading = false;
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    isLoading = true;
    notifyListeners();
    await _repo.signIn(email, password);
    isLoading = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _repo.signOut();
  }
} 