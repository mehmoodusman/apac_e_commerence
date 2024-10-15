abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String email;

  AuthAuthenticated(this.email);
}

class AuthError extends AuthState {
  final String errorMessage;

  AuthError(this.errorMessage);
}

class AuthUnauthenticated extends AuthState {}
