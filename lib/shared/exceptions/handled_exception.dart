import 'dart:async';

class HandledException implements Exception {
  HandledException(this.message);

  final String message;

  factory HandledException.fromException(Object error) {
    if (error is HandledException) return error;
    return HandledException(error.toString());
  }

  static Future<T> guard<T>(FutureOr<T> Function() action) async {
    try {
      return await Future<T>.value(action());
    } on HandledException {
      rethrow;
    } catch (error) {
      throw HandledException.fromException(error);
    }
  }

  @override
  String toString() => message;
}
