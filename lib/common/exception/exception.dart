class NetworkException implements Exception {
  final String? message;

  NetworkException([this.message]);

  @override
  String toString() => message == null ? '' : message.toString();
}

class NoResponse extends NetworkException {
  NoResponse([super.message]);
}
