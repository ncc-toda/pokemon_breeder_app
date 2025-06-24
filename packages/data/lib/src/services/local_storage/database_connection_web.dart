import 'package:drift/drift.dart';
import 'package:drift/web.dart';

/// Web環境でのデータベース接続を作成する
QueryExecutor createDatabaseConnection() {
  return WebDatabase('pokemon_breeder_db');
}
