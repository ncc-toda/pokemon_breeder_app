import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'database.dart';

part 'local_database_provider.g.dart';

/// LocalDatabase のインスタンスを提供する Provider。
///
/// Generator により `localDatabaseProvider` が生成される。
/// keepAlive により、プロバイダーが頻繁に破棄されることを防ぐ。
@Riverpod(keepAlive: true)
LocalDatabase localDatabase(Ref ref) {
  final db = LocalDatabase();
  // Web環境では自動的なclose呼び出しを避ける
  // アプリ終了時にブラウザが適切にリソースを解放する
  return db;
}
