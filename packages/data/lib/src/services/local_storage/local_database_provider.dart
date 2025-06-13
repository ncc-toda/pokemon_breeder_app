import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'database.dart';

part 'local_database_provider.g.dart';

/// LocalDatabase のインスタンスを提供する Provider。
///
/// Generator により `localDatabaseProvider` が生成される。
@riverpod
LocalDatabase localDatabase(Ref ref) {
  final db = LocalDatabase();
  ref.onDispose(db.close);
  return db;
}
