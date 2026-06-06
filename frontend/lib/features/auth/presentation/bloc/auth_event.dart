sealed class AuthEvent {
  const AuthEvent();
}

class AuthSignInRequested extends AuthEvent {
  final String email;
  final String password;
  const AuthSignInRequested({required this.email, required this.password});
}

class AuthSignUpRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  const AuthSignUpRequested({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}

class AuthSignOutRequested extends AuthEvent {
  const AuthSignOutRequested();
}

class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}
