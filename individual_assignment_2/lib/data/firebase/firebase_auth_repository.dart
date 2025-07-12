import 'package:firebase_auth/firebase_auth.dart' as fb;
import '../../domain/models/user.dart';
import '../../domain/repositories/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  final fb.FirebaseAuth _firebaseAuth = fb.FirebaseAuth.instance;

  @override
  Future<User?> signUp(String email, String password) async {
    final cred = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    final fbUser = cred.user;
    if (fbUser == null) return null;
    return User(id: fbUser.uid, email: fbUser.email ?? '');
  }

  @override
  Future<User?> signIn(String email, String password) async {
    final cred = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    final fbUser = cred.user;
    if (fbUser == null) return null;
    return User(id: fbUser.uid, email: fbUser.email ?? '');
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Stream<User?> get user => _firebaseAuth.authStateChanges().map((fbUser) =>
      fbUser == null ? null : User(id: fbUser.uid, email: fbUser.email ?? ''));
} 