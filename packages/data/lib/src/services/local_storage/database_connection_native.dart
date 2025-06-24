import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// ネイティブ環境でのデータベース接続を作成する
QueryExecutor createDatabaseConnection() {
  return LazyDatabase(() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final dbPath = p.join(appDocDir.path, 'pokemon_breeder.db');
    return NativeDatabase(File(dbPath));
  });
}
