import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  AuthCubit(this.authRepository) : super(AuthInitial()) {
    authRepository.user.listen((user) {
      if (user == null) {
        emit(AuthLoggedOut());
      } else {
        emit(AuthLoggedIn(user));
      }
    });
  }

  Future<void> signUp(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signUp(email, password);
      if (user != null) {
        emit(AuthLoggedIn(user));
      } else {
        emit(const AuthError('Sign up failed.'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signIn(email, password);
      if (user != null) {
        emit(AuthLoggedIn(user));
      } else {
        emit(const AuthError('Sign in failed.'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signOut() async {
    await authRepository.signOut();
    emit(AuthLoggedOut());
  }
} 