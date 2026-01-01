enum LoginFailureType {
  /// Incorrect username or password
  invalidCredentials,

  /// Network connectivity issues
  network,
}

class LoginException implements Exception {
  final LoginFailureType type;
  final Object? cause;

  const LoginException({
    required this.type,
    this.cause,
  });

  @override
  String toString() => 'LoginException($type)';
}
