import 'dart:developer' as developer;

import 'package:drift/drift.dart';

import 'database_connection.dart'
    if (dart.library.html) 'database_connection_web.dart'
    if (dart.library.io) 'database_connection_native.dart';

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

/// パーティ内ポケモンテーブル定義（育成カウンター情報を含む）
class PartyPokemons extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// パーティID（外部キー）
  IntColumn get partyId => integer().references(Parties, #id)();

  /// ポケモンID
  IntColumn get pokemonId => integer()();

  /// パーティ内での位置（0-5）
  IntColumn get position => integer().check(position.isBetweenValues(0, 5))();

  /// 育成カウンター
  IntColumn get breedingCounter => integer().withDefault(const Constant(0))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
        {partyId, position}, // パーティ内での位置は一意
      ];
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

@DriftDatabase(tables: [Parties, PartyPokemons])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(createDatabaseConnection()) {
    // 複数データベースインスタンス警告を無効化
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  }

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          developer.log('Creating database schema (version $schemaVersion)', name: 'LocalDatabase');
          await m.createAll();
          developer.log('Database schema created successfully', name: 'LocalDatabase');
        },
        onUpgrade: (Migrator m, int from, int to) async {
          developer.log('Upgrading database schema from $from to $to', name: 'LocalDatabase');
          if (from < 2) {
            // v1 -> v2: PartyPokemonsテーブルを追加
            developer.log('Adding PartyPokemons table', name: 'LocalDatabase');
            await m.createTable(partyPokemons);

            // 既存のパーティデータをPartyPokemonsテーブルに移行
            developer.log('Migrating existing party data', name: 'LocalDatabase');
            await _migratePartyData();
            developer.log('Party data migration completed', name: 'LocalDatabase');
          }
          developer.log('Database upgrade completed', name: 'LocalDatabase');
        },
      );

  /// 既存のパーティデータをPartyPokemonsテーブルに移行する。
  Future<void> _migratePartyData() async {
    final existingParties = await select(parties).get();

    for (final party in existingParties) {
      final pokemonIds = party.pokemonIds;
      for (int i = 0; i < pokemonIds.length && i < 6; i++) {
        final pokemonId = int.tryParse(pokemonIds[i]);
        if (pokemonId != null) {
          await into(partyPokemons).insert(PartyPokemonsCompanion.insert(
            partyId: party.id,
            pokemonId: pokemonId,
            position: i,
            breedingCounter: const Value(0),
          ));
        }
      }
    }
  }

  // CRUD convenience methods -------------------------------------------------
  Future<int> insertParty(PartiesCompanion companion) async {
    developer.log('Inserting party: ${companion.name.value}', name: 'LocalDatabase');
    final id = await into(parties).insert(companion);
    developer.log('Party inserted with ID: $id', name: 'LocalDatabase');
    return id;
  }

  Future<List<Party>> getAllParties() async {
    developer.log('Getting all parties', name: 'LocalDatabase');
    final result = await select(parties).get();
    developer.log('Retrieved ${result.length} parties from database', name: 'LocalDatabase');
    return result;
  }

  Future<bool> updateParty(Party party) async {
    developer.log('Updating party: ${party.name} (ID: ${party.id})', name: 'LocalDatabase');
    final result = await update(parties).replace(party);
    developer.log('Party update result: $result', name: 'LocalDatabase');
    return result;
  }

  Future<int> deleteParty(int id) async {
    developer.log('Deleting party with ID: $id', name: 'LocalDatabase');
    final result = await (delete(parties)..where((tbl) => tbl.id.equals(id))).go();
    developer.log('Party delete result: $result rows affected', name: 'LocalDatabase');
    return result;
  }

  // PartyPokemons CRUD methods -----------------------------------------------
  Future<List<PartyPokemon>> getPartyPokemons(int partyId) =>
      (select(partyPokemons)
            ..where((tbl) => tbl.partyId.equals(partyId))
            ..orderBy([(tbl) => OrderingTerm.asc(tbl.position)]))
          .get();

  Future<int> insertPartyPokemon(PartyPokemonsCompanion companion) =>
      into(partyPokemons).insert(companion);

  Future<bool> updatePartyPokemon(PartyPokemon partyPokemon) =>
      update(partyPokemons).replace(partyPokemon);

  Future<int> deletePartyPokemon(int id) =>
      (delete(partyPokemons)..where((tbl) => tbl.id.equals(id))).go();

  Future<int> deletePartyPokemonsByPartyId(int partyId) =>
      (delete(partyPokemons)..where((tbl) => tbl.partyId.equals(partyId))).go();

  /// 育成カウンターを更新する。
  Future<bool> updateBreedingCounter(int partyPokemonId, int counter) async {
    final result = await (update(partyPokemons)
          ..where((tbl) => tbl.id.equals(partyPokemonId)))
        .write(PartyPokemonsCompanion(
      breedingCounter: Value(counter),
      updatedAt: Value(DateTime.now()),
    ));
    return result > 0;
  }
}
