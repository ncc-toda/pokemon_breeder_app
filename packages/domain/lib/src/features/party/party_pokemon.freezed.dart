// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'party_pokemon.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PartyPokemon {
  int get id;
  int get partyId;
  int get pokemonId;
  int get position;
  int get breedingCounter;
  DateTime get createdAt;
  DateTime get updatedAt;

  /// Create a copy of PartyPokemon
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PartyPokemonCopyWith<PartyPokemon> get copyWith =>
      _$PartyPokemonCopyWithImpl<PartyPokemon>(
          this as PartyPokemon, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PartyPokemon &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.partyId, partyId) || other.partyId == partyId) &&
            (identical(other.pokemonId, pokemonId) ||
                other.pokemonId == pokemonId) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.breedingCounter, breedingCounter) ||
                other.breedingCounter == breedingCounter) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, partyId, pokemonId, position,
      breedingCounter, createdAt, updatedAt);

  @override
  String toString() {
    return 'PartyPokemon(id: $id, partyId: $partyId, pokemonId: $pokemonId, position: $position, breedingCounter: $breedingCounter, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $PartyPokemonCopyWith<$Res> {
  factory $PartyPokemonCopyWith(
          PartyPokemon value, $Res Function(PartyPokemon) _then) =
      _$PartyPokemonCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      int partyId,
      int pokemonId,
      int position,
      int breedingCounter,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$PartyPokemonCopyWithImpl<$Res> implements $PartyPokemonCopyWith<$Res> {
  _$PartyPokemonCopyWithImpl(this._self, this._then);

  final PartyPokemon _self;
  final $Res Function(PartyPokemon) _then;

  /// Create a copy of PartyPokemon
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? partyId = null,
    Object? pokemonId = null,
    Object? position = null,
    Object? breedingCounter = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      partyId: null == partyId
          ? _self.partyId
          : partyId // ignore: cast_nullable_to_non_nullable
              as int,
      pokemonId: null == pokemonId
          ? _self.pokemonId
          : pokemonId // ignore: cast_nullable_to_non_nullable
              as int,
      position: null == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      breedingCounter: null == breedingCounter
          ? _self.breedingCounter
          : breedingCounter // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _PartyPokemon extends PartyPokemon {
  const _PartyPokemon(
      {required this.id,
      required this.partyId,
      required this.pokemonId,
      required this.position,
      required this.breedingCounter,
      required this.createdAt,
      required this.updatedAt})
      : super._();

  @override
  final int id;
  @override
  final int partyId;
  @override
  final int pokemonId;
  @override
  final int position;
  @override
  final int breedingCounter;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  /// Create a copy of PartyPokemon
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PartyPokemonCopyWith<_PartyPokemon> get copyWith =>
      __$PartyPokemonCopyWithImpl<_PartyPokemon>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PartyPokemon &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.partyId, partyId) || other.partyId == partyId) &&
            (identical(other.pokemonId, pokemonId) ||
                other.pokemonId == pokemonId) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.breedingCounter, breedingCounter) ||
                other.breedingCounter == breedingCounter) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, partyId, pokemonId, position,
      breedingCounter, createdAt, updatedAt);

  @override
  String toString() {
    return 'PartyPokemon(id: $id, partyId: $partyId, pokemonId: $pokemonId, position: $position, breedingCounter: $breedingCounter, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$PartyPokemonCopyWith<$Res>
    implements $PartyPokemonCopyWith<$Res> {
  factory _$PartyPokemonCopyWith(
          _PartyPokemon value, $Res Function(_PartyPokemon) _then) =
      __$PartyPokemonCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      int partyId,
      int pokemonId,
      int position,
      int breedingCounter,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$PartyPokemonCopyWithImpl<$Res>
    implements _$PartyPokemonCopyWith<$Res> {
  __$PartyPokemonCopyWithImpl(this._self, this._then);

  final _PartyPokemon _self;
  final $Res Function(_PartyPokemon) _then;

  /// Create a copy of PartyPokemon
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? partyId = null,
    Object? pokemonId = null,
    Object? position = null,
    Object? breedingCounter = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_PartyPokemon(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      partyId: null == partyId
          ? _self.partyId
          : partyId // ignore: cast_nullable_to_non_nullable
              as int,
      pokemonId: null == pokemonId
          ? _self.pokemonId
          : pokemonId // ignore: cast_nullable_to_non_nullable
              as int,
      position: null == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
      breedingCounter: null == breedingCounter
          ? _self.breedingCounter
          : breedingCounter // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
