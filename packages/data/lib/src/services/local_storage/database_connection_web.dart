import 'dart:developer' as developer;

import 'package:drift/drift.dart';
// ignore: deprecated_member_use
import 'package:drift/web.dart';

/// グローバルなQueryExecutorインスタンス
QueryExecutor? _globalExecutor;

/// Web環境でのデータベース接続を作成する
QueryExecutor createDatabaseConnection() {
  if (_globalExecutor != null) {
    developer.log('Returning existing global QueryExecutor',
        name: 'DatabaseConnection');
    return _globalExecutor!;
  }

  developer.log('Creating new global QueryExecutor',
      name: 'DatabaseConnection');
  _globalExecutor = LazyDatabase(() async {
    try {
      developer.log('Creating WebDatabase for pokemon_breeder_db',
          name: 'DatabaseConnection');
      final database = WebDatabase.withStorage(
        DriftWebStorage.indexedDb('pokemon_breeder_db',
            migrateFromLocalStorage: false),
      );
      developer.log('WebDatabase created successfully',
          name: 'DatabaseConnection');
      return database;
    } catch (error, stackTrace) {
      developer.log(
        'Failed to create WebDatabase: $error',
        name: 'DatabaseConnection',
        error: error,
        stackTrace: stackTrace,
      );
      // フォールバック: シンプルなWebDatabase
      developer.log('Falling back to simple WebDatabase',
          name: 'DatabaseConnection');
      return WebDatabase('pokemon_breeder_db_fallback');
    }
  });

  return _globalExecutor!;
}
