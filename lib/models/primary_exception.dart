// import 'dart:html';

class PrimaryException implements Exception {
  final String message;
  PrimaryException(this.message);

  @override
  String toString() {
    return message;
  }
}
