import 'package:drift/drift.dart';

/// プラットフォーム固有のデータベース接続を作成する
QueryExecutor createDatabaseConnection() {
  throw UnsupportedError('Platform-specific implementations are required');
}
