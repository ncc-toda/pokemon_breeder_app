///  データ層でスローされる例外。
class DataException implements Exception {
  DataException(this.message, {this.original});

  final String message;
  final Object? original;

  @override
  String toString() => 'DataException: $message ${original ?? ''}';
}
