// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pokemon.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Pokemon {
  /// PokeAPI から取得される ID（例: 1, 25, 151）
  int get id;

  /// Pokemon 名（英語）
  String get name;

  /// 図鑑番号（通常は id と同じ）
  int get pokedexNumber;

  /// スプライト画像URL
  String get imageUrl;

  /// Create a copy of Pokemon
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PokemonCopyWith<Pokemon> get copyWith =>
      _$PokemonCopyWithImpl<Pokemon>(this as Pokemon, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Pokemon &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.pokedexNumber, pokedexNumber) ||
                other.pokedexNumber == pokedexNumber) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, pokedexNumber, imageUrl);

  @override
  String toString() {
    return 'Pokemon(id: $id, name: $name, pokedexNumber: $pokedexNumber, imageUrl: $imageUrl)';
  }
}

/// @nodoc
abstract mixin class $PokemonCopyWith<$Res> {
  factory $PokemonCopyWith(Pokemon value, $Res Function(Pokemon) _then) =
      _$PokemonCopyWithImpl;
  @useResult
  $Res call({int id, String name, int pokedexNumber, String imageUrl});
}

/// @nodoc
class _$PokemonCopyWithImpl<$Res> implements $PokemonCopyWith<$Res> {
  _$PokemonCopyWithImpl(this._self, this._then);

  final Pokemon _self;
  final $Res Function(Pokemon) _then;

  /// Create a copy of Pokemon
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? pokedexNumber = null,
    Object? imageUrl = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      pokedexNumber: null == pokedexNumber
          ? _self.pokedexNumber
          : pokedexNumber // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrl: null == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _Pokemon extends Pokemon {
  const _Pokemon(
      {required this.id,
      required this.name,
      required this.pokedexNumber,
      required this.imageUrl})
      : super._();

  /// PokeAPI から取得される ID（例: 1, 25, 151）
  @override
  final int id;

  /// Pokemon 名（英語）
  @override
  final String name;

  /// 図鑑番号（通常は id と同じ）
  @override
  final int pokedexNumber;

  /// スプライト画像URL
  @override
  final String imageUrl;

  /// Create a copy of Pokemon
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PokemonCopyWith<_Pokemon> get copyWith =>
      __$PokemonCopyWithImpl<_Pokemon>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Pokemon &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.pokedexNumber, pokedexNumber) ||
                other.pokedexNumber == pokedexNumber) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, pokedexNumber, imageUrl);

  @override
  String toString() {
    return 'Pokemon(id: $id, name: $name, pokedexNumber: $pokedexNumber, imageUrl: $imageUrl)';
  }
}

/// @nodoc
abstract mixin class _$PokemonCopyWith<$Res> implements $PokemonCopyWith<$Res> {
  factory _$PokemonCopyWith(_Pokemon value, $Res Function(_Pokemon) _then) =
      __$PokemonCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String name, int pokedexNumber, String imageUrl});
}

/// @nodoc
class __$PokemonCopyWithImpl<$Res> implements _$PokemonCopyWith<$Res> {
  __$PokemonCopyWithImpl(this._self, this._then);

  final _Pokemon _self;
  final $Res Function(_Pokemon) _then;

  /// Create a copy of Pokemon
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? pokedexNumber = null,
    Object? imageUrl = null,
  }) {
    return _then(_Pokemon(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      pokedexNumber: null == pokedexNumber
          ? _self.pokedexNumber
          : pokedexNumber // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrl: null == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
