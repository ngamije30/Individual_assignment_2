import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../data/firebase/firebase_auth_repository.dart';
import '../data/firebase/firebase_notes_repository.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/repositories/notes_repository.dart';
import 'cubit/auth_cubit.dart';
import 'cubit/notes_cubit.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/notes_screen.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool showLogin = true;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(create: (_) => FirebaseAuthRepository()),
        Provider<NotesRepository>(create: (_) => FirebaseNotesRepository()),
      ],
      child: BlocProvider(
        create: (context) => AuthCubit(context.read<AuthRepository>()),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthLoggedIn) {
              return BlocProvider(
                create: (_) => NotesCubit(
                  notesRepository: context.read<NotesRepository>(),
                  userId: state.user.id,
                ),
                child: NotesScreen(
                  onLogout: () => context.read<AuthCubit>().signOut(),
                ),
              );
            } else if (showLogin) {
              return LoginScreen(
                onSignupTap: () => setState(() => showLogin = false),
              );
            } else {
              return SignupScreen(
                onLoginTap: () => setState(() => showLogin = true),
              );
            }
          },
        ),
      ),
    );
  }
} 