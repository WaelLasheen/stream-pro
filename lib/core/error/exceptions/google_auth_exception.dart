class GoogleAuthException implements Exception {
  final String message;
  final bool isCancelled;

  const GoogleAuthException(this.message, {this.isCancelled = false});

  const GoogleAuthException.cancelled() : message = '', isCancelled = true;

  @override
  String toString() => isCancelled ? 'Google sign-in cancelled' : message;
}
