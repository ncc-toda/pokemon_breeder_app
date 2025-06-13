import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

/// パーティテーブル定義
class Parties extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// パーティのタイトル
  TextColumn get name => text().withLength(min: 1, max: 64)();

  /// 6体のポケモンIDをカンマ区切りで保持 (簡易実装)
  TextColumn get pokemonIds => text().map(const _StringListConverter())();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class _StringListConverter extends TypeConverter<List<String>, String> {
  const _StringListConverter();

  @override
  List<String> fromSql(String fromDb) {
    if (fromDb.isEmpty) return <String>[];
    return fromDb.split(',');
  }

  @override
  String toSql(List<String> value) => value.join(',');
}

@DriftDatabase(tables: [Parties])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // CRUD convenience methods -------------------------------------------------
  Future<int> insertParty(PartiesCompanion companion) =>
      into(parties).insert(companion);

  Future<List<Party>> getAllParties() => select(parties).get();

  Future<bool> updateParty(Party party) => update(parties).replace(party);

  Future<int> deleteParty(int id) =>
      (delete(parties)..where((tbl) => tbl.id.equals(id))).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String dbPath = p.join(appDocDir.path, 'pokemon_breeder.db');
    return NativeDatabase(File(dbPath));
  });
}
