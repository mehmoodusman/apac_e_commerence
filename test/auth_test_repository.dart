import 'package:apac_e_commerce/src/authentication/presentation/bloc/auth_event.dart';
import 'package:apac_e_commerce/src/authentication/presentation/bloc/auth_state.dart';
import 'package:bloc/bloc.dart';

import 'auth_test.dart';

class AuthBlocTest extends Bloc<AuthEvent, AuthState> {
  final SimpleAuthRepository firebaseAuth;

  AuthBlocTest({
    required this.firebaseAuth,
  }) : super(AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
      AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          event.email, event.password);
      emit(AuthAuthenticated(event.email));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onRegisterRequested(
      AuthRegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          event.email, event.password);
      emit(AuthAuthenticated(event.email));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
      AuthLogoutRequested event, Emitter<AuthState> emit) async {
    await firebaseAuth.signOut();
    emit(AuthUnauthenticated());
  }
}
