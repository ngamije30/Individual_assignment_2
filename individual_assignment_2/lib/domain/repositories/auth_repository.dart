import '../models/user.dart';

abstract class AuthRepository {
  Future<User?> signUp(String email, String password);
  Future<User?> signIn(String email, String password);
  Future<void> signOut();
  Stream<User?> get user;
} 