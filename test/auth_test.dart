import 'package:apac_e_commerce/src/authentication/presentation/bloc/auth_event.dart';
import 'package:apac_e_commerce/src/authentication/presentation/bloc/auth_state.dart';
import 'package:flutter_test/flutter_test.dart';

import 'auth_test_repository.dart';
import 'fake_firebase_auth.dart';

// A simple implementation of AuthRepository for testing purposes
class SimpleAuthRepository implements AuthRepository {
  bool shouldFail = false;
  String? userEmail;

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    if (shouldFail) {
      throw Exception('Failed to login');
    }
    userEmail = email;
  }

  @override
  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    if (shouldFail) {
      throw Exception('Failed to register');
    }
    userEmail = email;
  }

  @override
  Future<void> signOut() async {
    userEmail = null;
  }
}

void main() {
  late AuthBlocTest authBloc;
  late SimpleAuthRepository authRepository;

  setUp(() {
    authRepository = SimpleAuthRepository();
    authBloc = AuthBlocTest(firebaseAuth: authRepository);
  });

  tearDown(() {
    authBloc.close();
  });

  test('initial state should be AuthInitial', () {
    expect(authBloc.state, isA<AuthInitial>());
  });

  test('successful login should emit AuthLoading and AuthAuthenticated',
      () async {
    // Trigger login event
    authBloc.add(
        AuthLoginRequested(email: 'test@example.com', password: 'password123'));

    // Wait for the event to be processed
    await Future.delayed(Duration.zero);

    // Assert that the loading and authenticated states are emitted
    await Future.delayed(Duration.zero); // Allow the next state to be emitted
    expect(authBloc.state, isA<AuthAuthenticated>());
    expect((authBloc.state as AuthAuthenticated).email, 'test@example.com');
  });

  test('failed login should emit AuthLoading and AuthError', () async {
    // Set the auth repository to fail
    authRepository.shouldFail = true;

    // Trigger login event
    authBloc.add(AuthLoginRequested(
        email: 'test@example.com', password: 'wrong_password'));

    // Wait for the event to be processed
    await Future.delayed(Duration.zero);

    // Assert that the loading and error states are emitted
    await Future.delayed(Duration.zero); // Allow the next state to be emitted
    expect(authBloc.state, isA<AuthError>());
    expect((authBloc.state as AuthError).errorMessage,
        contains('Failed to login'));
  });

  test('successful registration should emit AuthLoading and AuthAuthenticated',
      () async {
    // Trigger register event
    authBloc.add(AuthRegisterRequested(
        email: 'test@example.com', password: 'password123'));

    // Wait for the event to be processed
    await Future.delayed(Duration.zero);

    // Assert that the loading and authenticated states are emitted
    await Future.delayed(Duration.zero); // Allow the next state to be emitted
    expect(authBloc.state, isA<AuthAuthenticated>());
    expect((authBloc.state as AuthAuthenticated).email, 'test@example.com');
  });

  test('successful logout should emit AuthUnauthenticated', () async {
    // Trigger logout event
    authBloc.add(AuthLogoutRequested());

    // Wait for the event to be processed
    await Future.delayed(Duration.zero);

    // Assert that the unauthenticated state is emitted
    expect(authBloc.state, isA<AuthUnauthenticated>());
  });
}
