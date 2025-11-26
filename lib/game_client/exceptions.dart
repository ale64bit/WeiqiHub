/// The type of login failure that occurred
enum LoginFailureType {
  /// Incorrect username or password
  invalidCredentials,

  /// Network connectivity issues
  network,

  /// Unknown or unspecified error
  unknown,
}

/// Exception thrown when login fails
class LoginException implements Exception {
  final String message;
  final LoginFailureType type;
  final Object? cause;

  const LoginException(
    this.message, {
    required this.type,
    this.cause,
  });

  @override
  String toString() => 'LoginException($type): $message';
}
