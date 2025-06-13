// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pokemon_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PokemonDto {
  String get name;
  String get url;

  /// Create a copy of PokemonDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PokemonDtoCopyWith<PokemonDto> get copyWith =>
      _$PokemonDtoCopyWithImpl<PokemonDto>(this as PokemonDto, _$identity);

  /// Serializes this PokemonDto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PokemonDto &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, url);

  @override
  String toString() {
    return 'PokemonDto(name: $name, url: $url)';
  }
}

/// @nodoc
abstract mixin class $PokemonDtoCopyWith<$Res> {
  factory $PokemonDtoCopyWith(
          PokemonDto value, $Res Function(PokemonDto) _then) =
      _$PokemonDtoCopyWithImpl;
  @useResult
  $Res call({String name, String url});
}

/// @nodoc
class _$PokemonDtoCopyWithImpl<$Res> implements $PokemonDtoCopyWith<$Res> {
  _$PokemonDtoCopyWithImpl(this._self, this._then);

  final PokemonDto _self;
  final $Res Function(PokemonDto) _then;

  /// Create a copy of PokemonDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? url = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _PokemonDto implements PokemonDto {
  const _PokemonDto({required this.name, required this.url});
  factory _PokemonDto.fromJson(Map<String, dynamic> json) =>
      _$PokemonDtoFromJson(json);

  @override
  final String name;
  @override
  final String url;

  /// Create a copy of PokemonDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PokemonDtoCopyWith<_PokemonDto> get copyWith =>
      __$PokemonDtoCopyWithImpl<_PokemonDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PokemonDtoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PokemonDto &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, url);

  @override
  String toString() {
    return 'PokemonDto(name: $name, url: $url)';
  }
}

/// @nodoc
abstract mixin class _$PokemonDtoCopyWith<$Res>
    implements $PokemonDtoCopyWith<$Res> {
  factory _$PokemonDtoCopyWith(
          _PokemonDto value, $Res Function(_PokemonDto) _then) =
      __$PokemonDtoCopyWithImpl;
  @override
  @useResult
  $Res call({String name, String url});
}

/// @nodoc
class __$PokemonDtoCopyWithImpl<$Res> implements _$PokemonDtoCopyWith<$Res> {
  __$PokemonDtoCopyWithImpl(this._self, this._then);

  final _PokemonDto _self;
  final $Res Function(_PokemonDto) _then;

  /// Create a copy of PokemonDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? url = null,
  }) {
    return _then(_PokemonDto(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
