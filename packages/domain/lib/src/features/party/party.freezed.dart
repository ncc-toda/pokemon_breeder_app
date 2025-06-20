// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'party.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Party {
  int get id;
  String get name;
  List<int> get pokemonIds;
  DateTime get createdAt;
  DateTime get updatedAt;

  /// Create a copy of Party
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PartyCopyWith<Party> get copyWith =>
      _$PartyCopyWithImpl<Party>(this as Party, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Party &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other.pokemonIds, pokemonIds) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name,
      const DeepCollectionEquality().hash(pokemonIds), createdAt, updatedAt);

  @override
  String toString() {
    return 'Party(id: $id, name: $name, pokemonIds: $pokemonIds, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $PartyCopyWith<$Res> {
  factory $PartyCopyWith(Party value, $Res Function(Party) _then) =
      _$PartyCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String name,
      List<int> pokemonIds,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$PartyCopyWithImpl<$Res> implements $PartyCopyWith<$Res> {
  _$PartyCopyWithImpl(this._self, this._then);

  final Party _self;
  final $Res Function(Party) _then;

  /// Create a copy of Party
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? pokemonIds = null,
    Object? createdAt = null,
    Object? updatedAt = null,
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
      pokemonIds: null == pokemonIds
          ? _self.pokemonIds
          : pokemonIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
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

class _Party extends Party {
  const _Party(
      {required this.id,
      required this.name,
      required final List<int> pokemonIds,
      required this.createdAt,
      required this.updatedAt})
      : _pokemonIds = pokemonIds,
        super._();

  @override
  final int id;
  @override
  final String name;
  final List<int> _pokemonIds;
  @override
  List<int> get pokemonIds {
    if (_pokemonIds is EqualUnmodifiableListView) return _pokemonIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pokemonIds);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  /// Create a copy of Party
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PartyCopyWith<_Party> get copyWith =>
      __$PartyCopyWithImpl<_Party>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Party &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._pokemonIds, _pokemonIds) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name,
      const DeepCollectionEquality().hash(_pokemonIds), createdAt, updatedAt);

  @override
  String toString() {
    return 'Party(id: $id, name: $name, pokemonIds: $pokemonIds, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$PartyCopyWith<$Res> implements $PartyCopyWith<$Res> {
  factory _$PartyCopyWith(_Party value, $Res Function(_Party) _then) =
      __$PartyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      List<int> pokemonIds,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$PartyCopyWithImpl<$Res> implements _$PartyCopyWith<$Res> {
  __$PartyCopyWithImpl(this._self, this._then);

  final _Party _self;
  final $Res Function(_Party) _then;

  /// Create a copy of Party
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? pokemonIds = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_Party(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      pokemonIds: null == pokemonIds
          ? _self._pokemonIds
          : pokemonIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
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
mixin _$PartySlot {
  int get position;

  /// Create a copy of PartySlot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PartySlotCopyWith<PartySlot> get copyWith =>
      _$PartySlotCopyWithImpl<PartySlot>(this as PartySlot, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PartySlot &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @override
  int get hashCode => Object.hash(runtimeType, position);

  @override
  String toString() {
    return 'PartySlot(position: $position)';
  }
}

/// @nodoc
abstract mixin class $PartySlotCopyWith<$Res> {
  factory $PartySlotCopyWith(PartySlot value, $Res Function(PartySlot) _then) =
      _$PartySlotCopyWithImpl;
  @useResult
  $Res call({int position});
}

/// @nodoc
class _$PartySlotCopyWithImpl<$Res> implements $PartySlotCopyWith<$Res> {
  _$PartySlotCopyWithImpl(this._self, this._then);

  final PartySlot _self;
  final $Res Function(PartySlot) _then;

  /// Create a copy of PartySlot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? position = null,
  }) {
    return _then(_self.copyWith(
      position: null == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _PartySlotFilled extends PartySlot {
  const _PartySlotFilled({required this.pokemonId, required this.position})
      : super._();

  final int pokemonId;
  @override
  final int position;

  /// Create a copy of PartySlot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PartySlotFilledCopyWith<_PartySlotFilled> get copyWith =>
      __$PartySlotFilledCopyWithImpl<_PartySlotFilled>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PartySlotFilled &&
            (identical(other.pokemonId, pokemonId) ||
                other.pokemonId == pokemonId) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pokemonId, position);

  @override
  String toString() {
    return 'PartySlot.filled(pokemonId: $pokemonId, position: $position)';
  }
}

/// @nodoc
abstract mixin class _$PartySlotFilledCopyWith<$Res>
    implements $PartySlotCopyWith<$Res> {
  factory _$PartySlotFilledCopyWith(
          _PartySlotFilled value, $Res Function(_PartySlotFilled) _then) =
      __$PartySlotFilledCopyWithImpl;
  @override
  @useResult
  $Res call({int pokemonId, int position});
}

/// @nodoc
class __$PartySlotFilledCopyWithImpl<$Res>
    implements _$PartySlotFilledCopyWith<$Res> {
  __$PartySlotFilledCopyWithImpl(this._self, this._then);

  final _PartySlotFilled _self;
  final $Res Function(_PartySlotFilled) _then;

  /// Create a copy of PartySlot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? pokemonId = null,
    Object? position = null,
  }) {
    return _then(_PartySlotFilled(
      pokemonId: null == pokemonId
          ? _self.pokemonId
          : pokemonId // ignore: cast_nullable_to_non_nullable
              as int,
      position: null == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _PartySlotEmpty extends PartySlot {
  const _PartySlotEmpty({required this.position}) : super._();

  @override
  final int position;

  /// Create a copy of PartySlot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PartySlotEmptyCopyWith<_PartySlotEmpty> get copyWith =>
      __$PartySlotEmptyCopyWithImpl<_PartySlotEmpty>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PartySlotEmpty &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @override
  int get hashCode => Object.hash(runtimeType, position);

  @override
  String toString() {
    return 'PartySlot.empty(position: $position)';
  }
}

/// @nodoc
abstract mixin class _$PartySlotEmptyCopyWith<$Res>
    implements $PartySlotCopyWith<$Res> {
  factory _$PartySlotEmptyCopyWith(
          _PartySlotEmpty value, $Res Function(_PartySlotEmpty) _then) =
      __$PartySlotEmptyCopyWithImpl;
  @override
  @useResult
  $Res call({int position});
}

/// @nodoc
class __$PartySlotEmptyCopyWithImpl<$Res>
    implements _$PartySlotEmptyCopyWith<$Res> {
  __$PartySlotEmptyCopyWithImpl(this._self, this._then);

  final _PartySlotEmpty _self;
  final $Res Function(_PartySlotEmpty) _then;

  /// Create a copy of PartySlot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? position = null,
  }) {
    return _then(_PartySlotEmpty(
      position: null == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
