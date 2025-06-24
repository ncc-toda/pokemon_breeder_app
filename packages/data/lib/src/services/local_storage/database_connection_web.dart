import 'dart:developer' as developer;

import 'package:drift/drift.dart';
import 'package:drift/web.dart';

/// Web環境でのデータベース接続を作成する
QueryExecutor createDatabaseConnection() {
  return LazyDatabase(() async {
    try {
      developer.log('Creating WebDatabase for pokemon_breeder_db', name: 'DatabaseConnection');
      final database = WebDatabase.withStorage(
        DriftWebStorage.indexedDb('pokemon_breeder_db', migrateFromLocalStorage: false),
      );
      developer.log('WebDatabase created successfully', name: 'DatabaseConnection');
      return database;
    } catch (error, stackTrace) {
      developer.log(
        'Failed to create WebDatabase: $error',
        name: 'DatabaseConnection',
        error: error,
        stackTrace: stackTrace,
      );
      // フォールバック: シンプルなWebDatabase
      developer.log('Falling back to simple WebDatabase', name: 'DatabaseConnection');
      return WebDatabase('pokemon_breeder_db_fallback');
    }
  });
}
