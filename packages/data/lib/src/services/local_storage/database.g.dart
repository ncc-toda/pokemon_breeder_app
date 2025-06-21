// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PartiesTable extends Parties with TableInfo<$PartiesTable, Party> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PartiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> pokemonIds =
      GeneratedColumn<String>('pokemon_ids', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<String>>($PartiesTable.$converterpokemonIds);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, pokemonIds, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'parties';
  @override
  VerificationContext validateIntegrity(Insertable<Party> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Party map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Party(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      pokemonIds: $PartiesTable.$converterpokemonIds.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pokemon_ids'])!),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $PartiesTable createAlias(String alias) {
    return $PartiesTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converterpokemonIds =
      const _StringListConverter();
}

class Party extends DataClass implements Insertable<Party> {
  final int id;

  /// パーティのタイトル
  final String name;

  /// 6体のポケモンIDをカンマ区切りで保持 (簡易実装)
  final List<String> pokemonIds;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Party(
      {required this.id,
      required this.name,
      required this.pokemonIds,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      map['pokemon_ids'] = Variable<String>(
          $PartiesTable.$converterpokemonIds.toSql(pokemonIds));
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PartiesCompanion toCompanion(bool nullToAbsent) {
    return PartiesCompanion(
      id: Value(id),
      name: Value(name),
      pokemonIds: Value(pokemonIds),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Party.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Party(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      pokemonIds: serializer.fromJson<List<String>>(json['pokemonIds']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'pokemonIds': serializer.toJson<List<String>>(pokemonIds),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Party copyWith(
          {int? id,
          String? name,
          List<String>? pokemonIds,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Party(
        id: id ?? this.id,
        name: name ?? this.name,
        pokemonIds: pokemonIds ?? this.pokemonIds,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Party copyWithCompanion(PartiesCompanion data) {
    return Party(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      pokemonIds:
          data.pokemonIds.present ? data.pokemonIds.value : this.pokemonIds,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Party(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('pokemonIds: $pokemonIds, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, pokemonIds, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Party &&
          other.id == this.id &&
          other.name == this.name &&
          other.pokemonIds == this.pokemonIds &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PartiesCompanion extends UpdateCompanion<Party> {
  final Value<int> id;
  final Value<String> name;
  final Value<List<String>> pokemonIds;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const PartiesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.pokemonIds = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PartiesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required List<String> pokemonIds,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : name = Value(name),
        pokemonIds = Value(pokemonIds);
  static Insertable<Party> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? pokemonIds,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (pokemonIds != null) 'pokemon_ids': pokemonIds,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PartiesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<List<String>>? pokemonIds,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return PartiesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      pokemonIds: pokemonIds ?? this.pokemonIds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (pokemonIds.present) {
      map['pokemon_ids'] = Variable<String>(
          $PartiesTable.$converterpokemonIds.toSql(pokemonIds.value));
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PartiesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('pokemonIds: $pokemonIds, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PartyPokemonsTable extends PartyPokemons
    with TableInfo<$PartyPokemonsTable, PartyPokemon> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PartyPokemonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _partyIdMeta =
      const VerificationMeta('partyId');
  @override
  late final GeneratedColumn<int> partyId = GeneratedColumn<int>(
      'party_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES parties (id)'));
  static const VerificationMeta _pokemonIdMeta =
      const VerificationMeta('pokemonId');
  @override
  late final GeneratedColumn<int> pokemonId = GeneratedColumn<int>(
      'pokemon_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
      'position', aliasedName, false,
      check: () => ComparableExpr(position).isBetweenValues(0, 5),
      type: DriftSqlType.int,
      requiredDuringInsert: true);
  static const VerificationMeta _breedingCounterMeta =
      const VerificationMeta('breedingCounter');
  @override
  late final GeneratedColumn<int> breedingCounter = GeneratedColumn<int>(
      'breeding_counter', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, partyId, pokemonId, position, breedingCounter, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'party_pokemons';
  @override
  VerificationContext validateIntegrity(Insertable<PartyPokemon> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('party_id')) {
      context.handle(_partyIdMeta,
          partyId.isAcceptableOrUnknown(data['party_id']!, _partyIdMeta));
    } else if (isInserting) {
      context.missing(_partyIdMeta);
    }
    if (data.containsKey('pokemon_id')) {
      context.handle(_pokemonIdMeta,
          pokemonId.isAcceptableOrUnknown(data['pokemon_id']!, _pokemonIdMeta));
    } else if (isInserting) {
      context.missing(_pokemonIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('breeding_counter')) {
      context.handle(
          _breedingCounterMeta,
          breedingCounter.isAcceptableOrUnknown(
              data['breeding_counter']!, _breedingCounterMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {partyId, position},
      ];
  @override
  PartyPokemon map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PartyPokemon(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      partyId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}party_id'])!,
      pokemonId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pokemon_id'])!,
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position'])!,
      breedingCounter: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}breeding_counter'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $PartyPokemonsTable createAlias(String alias) {
    return $PartyPokemonsTable(attachedDatabase, alias);
  }
}

class PartyPokemon extends DataClass implements Insertable<PartyPokemon> {
  final int id;

  /// パーティID（外部キー）
  final int partyId;

  /// ポケモンID
  final int pokemonId;

  /// パーティ内での位置（0-5）
  final int position;

  /// 育成カウンター
  final int breedingCounter;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PartyPokemon(
      {required this.id,
      required this.partyId,
      required this.pokemonId,
      required this.position,
      required this.breedingCounter,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['party_id'] = Variable<int>(partyId);
    map['pokemon_id'] = Variable<int>(pokemonId);
    map['position'] = Variable<int>(position);
    map['breeding_counter'] = Variable<int>(breedingCounter);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PartyPokemonsCompanion toCompanion(bool nullToAbsent) {
    return PartyPokemonsCompanion(
      id: Value(id),
      partyId: Value(partyId),
      pokemonId: Value(pokemonId),
      position: Value(position),
      breedingCounter: Value(breedingCounter),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PartyPokemon.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PartyPokemon(
      id: serializer.fromJson<int>(json['id']),
      partyId: serializer.fromJson<int>(json['partyId']),
      pokemonId: serializer.fromJson<int>(json['pokemonId']),
      position: serializer.fromJson<int>(json['position']),
      breedingCounter: serializer.fromJson<int>(json['breedingCounter']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'partyId': serializer.toJson<int>(partyId),
      'pokemonId': serializer.toJson<int>(pokemonId),
      'position': serializer.toJson<int>(position),
      'breedingCounter': serializer.toJson<int>(breedingCounter),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PartyPokemon copyWith(
          {int? id,
          int? partyId,
          int? pokemonId,
          int? position,
          int? breedingCounter,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      PartyPokemon(
        id: id ?? this.id,
        partyId: partyId ?? this.partyId,
        pokemonId: pokemonId ?? this.pokemonId,
        position: position ?? this.position,
        breedingCounter: breedingCounter ?? this.breedingCounter,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  PartyPokemon copyWithCompanion(PartyPokemonsCompanion data) {
    return PartyPokemon(
      id: data.id.present ? data.id.value : this.id,
      partyId: data.partyId.present ? data.partyId.value : this.partyId,
      pokemonId: data.pokemonId.present ? data.pokemonId.value : this.pokemonId,
      position: data.position.present ? data.position.value : this.position,
      breedingCounter: data.breedingCounter.present
          ? data.breedingCounter.value
          : this.breedingCounter,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PartyPokemon(')
          ..write('id: $id, ')
          ..write('partyId: $partyId, ')
          ..write('pokemonId: $pokemonId, ')
          ..write('position: $position, ')
          ..write('breedingCounter: $breedingCounter, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, partyId, pokemonId, position, breedingCounter, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PartyPokemon &&
          other.id == this.id &&
          other.partyId == this.partyId &&
          other.pokemonId == this.pokemonId &&
          other.position == this.position &&
          other.breedingCounter == this.breedingCounter &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PartyPokemonsCompanion extends UpdateCompanion<PartyPokemon> {
  final Value<int> id;
  final Value<int> partyId;
  final Value<int> pokemonId;
  final Value<int> position;
  final Value<int> breedingCounter;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const PartyPokemonsCompanion({
    this.id = const Value.absent(),
    this.partyId = const Value.absent(),
    this.pokemonId = const Value.absent(),
    this.position = const Value.absent(),
    this.breedingCounter = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PartyPokemonsCompanion.insert({
    this.id = const Value.absent(),
    required int partyId,
    required int pokemonId,
    required int position,
    this.breedingCounter = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : partyId = Value(partyId),
        pokemonId = Value(pokemonId),
        position = Value(position);
  static Insertable<PartyPokemon> custom({
    Expression<int>? id,
    Expression<int>? partyId,
    Expression<int>? pokemonId,
    Expression<int>? position,
    Expression<int>? breedingCounter,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (partyId != null) 'party_id': partyId,
      if (pokemonId != null) 'pokemon_id': pokemonId,
      if (position != null) 'position': position,
      if (breedingCounter != null) 'breeding_counter': breedingCounter,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PartyPokemonsCompanion copyWith(
      {Value<int>? id,
      Value<int>? partyId,
      Value<int>? pokemonId,
      Value<int>? position,
      Value<int>? breedingCounter,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return PartyPokemonsCompanion(
      id: id ?? this.id,
      partyId: partyId ?? this.partyId,
      pokemonId: pokemonId ?? this.pokemonId,
      position: position ?? this.position,
      breedingCounter: breedingCounter ?? this.breedingCounter,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (partyId.present) {
      map['party_id'] = Variable<int>(partyId.value);
    }
    if (pokemonId.present) {
      map['pokemon_id'] = Variable<int>(pokemonId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (breedingCounter.present) {
      map['breeding_counter'] = Variable<int>(breedingCounter.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PartyPokemonsCompanion(')
          ..write('id: $id, ')
          ..write('partyId: $partyId, ')
          ..write('pokemonId: $pokemonId, ')
          ..write('position: $position, ')
          ..write('breedingCounter: $breedingCounter, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  $LocalDatabaseManager get managers => $LocalDatabaseManager(this);
  late final $PartiesTable parties = $PartiesTable(this);
  late final $PartyPokemonsTable partyPokemons = $PartyPokemonsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [parties, partyPokemons];
}

typedef $$PartiesTableCreateCompanionBuilder = PartiesCompanion Function({
  Value<int> id,
  required String name,
  required List<String> pokemonIds,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$PartiesTableUpdateCompanionBuilder = PartiesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<List<String>> pokemonIds,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$PartiesTableReferences
    extends BaseReferences<_$LocalDatabase, $PartiesTable, Party> {
  $$PartiesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PartyPokemonsTable, List<PartyPokemon>>
      _partyPokemonsRefsTable(_$LocalDatabase db) =>
          MultiTypedResultKey.fromTable(db.partyPokemons,
              aliasName: $_aliasNameGenerator(
                  db.parties.id, db.partyPokemons.partyId));

  $$PartyPokemonsTableProcessedTableManager get partyPokemonsRefs {
    final manager = $$PartyPokemonsTableTableManager($_db, $_db.partyPokemons)
        .filter((f) => f.partyId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_partyPokemonsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PartiesTableFilterComposer
    extends Composer<_$LocalDatabase, $PartiesTable> {
  $$PartiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get pokemonIds => $composableBuilder(
          column: $table.pokemonIds,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> partyPokemonsRefs(
      Expression<bool> Function($$PartyPokemonsTableFilterComposer f) f) {
    final $$PartyPokemonsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.partyPokemons,
        getReferencedColumn: (t) => t.partyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PartyPokemonsTableFilterComposer(
              $db: $db,
              $table: $db.partyPokemons,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PartiesTableOrderingComposer
    extends Composer<_$LocalDatabase, $PartiesTable> {
  $$PartiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pokemonIds => $composableBuilder(
      column: $table.pokemonIds, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$PartiesTableAnnotationComposer
    extends Composer<_$LocalDatabase, $PartiesTable> {
  $$PartiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get pokemonIds =>
      $composableBuilder(
          column: $table.pokemonIds, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> partyPokemonsRefs<T extends Object>(
      Expression<T> Function($$PartyPokemonsTableAnnotationComposer a) f) {
    final $$PartyPokemonsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.partyPokemons,
        getReferencedColumn: (t) => t.partyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PartyPokemonsTableAnnotationComposer(
              $db: $db,
              $table: $db.partyPokemons,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PartiesTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $PartiesTable,
    Party,
    $$PartiesTableFilterComposer,
    $$PartiesTableOrderingComposer,
    $$PartiesTableAnnotationComposer,
    $$PartiesTableCreateCompanionBuilder,
    $$PartiesTableUpdateCompanionBuilder,
    (Party, $$PartiesTableReferences),
    Party,
    PrefetchHooks Function({bool partyPokemonsRefs})> {
  $$PartiesTableTableManager(_$LocalDatabase db, $PartiesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PartiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PartiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PartiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<List<String>> pokemonIds = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              PartiesCompanion(
            id: id,
            name: name,
            pokemonIds: pokemonIds,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required List<String> pokemonIds,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              PartiesCompanion.insert(
            id: id,
            name: name,
            pokemonIds: pokemonIds,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$PartiesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({partyPokemonsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (partyPokemonsRefs) db.partyPokemons
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (partyPokemonsRefs)
                    await $_getPrefetchedData<Party, $PartiesTable,
                            PartyPokemon>(
                        currentTable: table,
                        referencedTable: $$PartiesTableReferences
                            ._partyPokemonsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PartiesTableReferences(db, table, p0)
                                .partyPokemonsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.partyId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PartiesTableProcessedTableManager = ProcessedTableManager<
    _$LocalDatabase,
    $PartiesTable,
    Party,
    $$PartiesTableFilterComposer,
    $$PartiesTableOrderingComposer,
    $$PartiesTableAnnotationComposer,
    $$PartiesTableCreateCompanionBuilder,
    $$PartiesTableUpdateCompanionBuilder,
    (Party, $$PartiesTableReferences),
    Party,
    PrefetchHooks Function({bool partyPokemonsRefs})>;
typedef $$PartyPokemonsTableCreateCompanionBuilder = PartyPokemonsCompanion
    Function({
  Value<int> id,
  required int partyId,
  required int pokemonId,
  required int position,
  Value<int> breedingCounter,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$PartyPokemonsTableUpdateCompanionBuilder = PartyPokemonsCompanion
    Function({
  Value<int> id,
  Value<int> partyId,
  Value<int> pokemonId,
  Value<int> position,
  Value<int> breedingCounter,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$PartyPokemonsTableReferences
    extends BaseReferences<_$LocalDatabase, $PartyPokemonsTable, PartyPokemon> {
  $$PartyPokemonsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PartiesTable _partyIdTable(_$LocalDatabase db) =>
      db.parties.createAlias(
          $_aliasNameGenerator(db.partyPokemons.partyId, db.parties.id));

  $$PartiesTableProcessedTableManager get partyId {
    final $_column = $_itemColumn<int>('party_id')!;

    final manager = $$PartiesTableTableManager($_db, $_db.parties)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_partyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PartyPokemonsTableFilterComposer
    extends Composer<_$LocalDatabase, $PartyPokemonsTable> {
  $$PartyPokemonsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get pokemonId => $composableBuilder(
      column: $table.pokemonId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get breedingCounter => $composableBuilder(
      column: $table.breedingCounter,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$PartiesTableFilterComposer get partyId {
    final $$PartiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.partyId,
        referencedTable: $db.parties,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PartiesTableFilterComposer(
              $db: $db,
              $table: $db.parties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PartyPokemonsTableOrderingComposer
    extends Composer<_$LocalDatabase, $PartyPokemonsTable> {
  $$PartyPokemonsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get pokemonId => $composableBuilder(
      column: $table.pokemonId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get position => $composableBuilder(
      column: $table.position, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get breedingCounter => $composableBuilder(
      column: $table.breedingCounter,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$PartiesTableOrderingComposer get partyId {
    final $$PartiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.partyId,
        referencedTable: $db.parties,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PartiesTableOrderingComposer(
              $db: $db,
              $table: $db.parties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PartyPokemonsTableAnnotationComposer
    extends Composer<_$LocalDatabase, $PartyPokemonsTable> {
  $$PartyPokemonsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get pokemonId =>
      $composableBuilder(column: $table.pokemonId, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<int> get breedingCounter => $composableBuilder(
      column: $table.breedingCounter, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$PartiesTableAnnotationComposer get partyId {
    final $$PartiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.partyId,
        referencedTable: $db.parties,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PartiesTableAnnotationComposer(
              $db: $db,
              $table: $db.parties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PartyPokemonsTableTableManager extends RootTableManager<
    _$LocalDatabase,
    $PartyPokemonsTable,
    PartyPokemon,
    $$PartyPokemonsTableFilterComposer,
    $$PartyPokemonsTableOrderingComposer,
    $$PartyPokemonsTableAnnotationComposer,
    $$PartyPokemonsTableCreateCompanionBuilder,
    $$PartyPokemonsTableUpdateCompanionBuilder,
    (PartyPokemon, $$PartyPokemonsTableReferences),
    PartyPokemon,
    PrefetchHooks Function({bool partyId})> {
  $$PartyPokemonsTableTableManager(
      _$LocalDatabase db, $PartyPokemonsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PartyPokemonsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PartyPokemonsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PartyPokemonsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> partyId = const Value.absent(),
            Value<int> pokemonId = const Value.absent(),
            Value<int> position = const Value.absent(),
            Value<int> breedingCounter = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              PartyPokemonsCompanion(
            id: id,
            partyId: partyId,
            pokemonId: pokemonId,
            position: position,
            breedingCounter: breedingCounter,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int partyId,
            required int pokemonId,
            required int position,
            Value<int> breedingCounter = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              PartyPokemonsCompanion.insert(
            id: id,
            partyId: partyId,
            pokemonId: pokemonId,
            position: position,
            breedingCounter: breedingCounter,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PartyPokemonsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({partyId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (partyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.partyId,
                    referencedTable:
                        $$PartyPokemonsTableReferences._partyIdTable(db),
                    referencedColumn:
                        $$PartyPokemonsTableReferences._partyIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PartyPokemonsTableProcessedTableManager = ProcessedTableManager<
    _$LocalDatabase,
    $PartyPokemonsTable,
    PartyPokemon,
    $$PartyPokemonsTableFilterComposer,
    $$PartyPokemonsTableOrderingComposer,
    $$PartyPokemonsTableAnnotationComposer,
    $$PartyPokemonsTableCreateCompanionBuilder,
    $$PartyPokemonsTableUpdateCompanionBuilder,
    (PartyPokemon, $$PartyPokemonsTableReferences),
    PartyPokemon,
    PrefetchHooks Function({bool partyId})>;

class $LocalDatabaseManager {
  final _$LocalDatabase _db;
  $LocalDatabaseManager(this._db);
  $$PartiesTableTableManager get parties =>
      $$PartiesTableTableManager(_db, _db.parties);
  $$PartyPokemonsTableTableManager get partyPokemons =>
      $$PartyPokemonsTableTableManager(_db, _db.partyPokemons);
}
