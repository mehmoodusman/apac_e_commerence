abstract class AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  AuthLoginRequested({required this.email, required this.password});
}

class AuthRegisterRequested extends AuthEvent {
  final String email;
  final String password;

  AuthRegisterRequested({required this.email, required this.password});
}

class AuthLogoutRequested extends AuthEvent {}
