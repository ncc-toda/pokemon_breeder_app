import 'dart:developer' as developer;

import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'database.dart';

part 'local_database_provider.g.dart';

/// グローバルなLocalDatabaseインスタンス
LocalDatabase? _globalDatabase;

/// LocalDatabase のインスタンスを提供する Provider。
///
/// Generator により `localDatabaseProvider` が生成される。
/// keepAlive により、プロバイダーが頻繁に破棄されることを防ぐ。
/// グローバル単一インスタンスを使用して複数インスタンス作成を防ぐ。
@Riverpod(keepAlive: true)
LocalDatabase localDatabase(Ref ref) {
  if (_globalDatabase != null) {
    developer.log('Returning existing global database instance', name: 'LocalDatabaseProvider');
    return _globalDatabase!;
  }
  
  developer.log('Creating new global database instance', name: 'LocalDatabaseProvider');
  _globalDatabase = LocalDatabase();
  
  // Web環境では自動的なclose呼び出しを避ける
  // アプリ終了時にブラウザが適切にリソースを解放する
  return _globalDatabase!;
}
