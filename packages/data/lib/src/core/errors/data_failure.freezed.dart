// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DataFailure {
  String? get message;

  /// Create a copy of DataFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DataFailureCopyWith<DataFailure> get copyWith =>
      _$DataFailureCopyWithImpl<DataFailure>(this as DataFailure, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DataFailure &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'DataFailure(message: $message)';
  }
}

/// @nodoc
abstract mixin class $DataFailureCopyWith<$Res> {
  factory $DataFailureCopyWith(
          DataFailure value, $Res Function(DataFailure) _then) =
      _$DataFailureCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$DataFailureCopyWithImpl<$Res> implements $DataFailureCopyWith<$Res> {
  _$DataFailureCopyWithImpl(this._self, this._then);

  final DataFailure _self;
  final $Res Function(DataFailure) _then;

  /// Create a copy of DataFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_self.copyWith(
      message: null == message
          ? _self.message!
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _Network implements DataFailure {
  const _Network({required this.message});

  @override
  final String message;

  /// Create a copy of DataFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NetworkCopyWith<_Network> get copyWith =>
      __$NetworkCopyWithImpl<_Network>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Network &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'DataFailure.network(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$NetworkCopyWith<$Res>
    implements $DataFailureCopyWith<$Res> {
  factory _$NetworkCopyWith(_Network value, $Res Function(_Network) _then) =
      __$NetworkCopyWithImpl;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$NetworkCopyWithImpl<$Res> implements _$NetworkCopyWith<$Res> {
  __$NetworkCopyWithImpl(this._self, this._then);

  final _Network _self;
  final $Res Function(_Network) _then;

  /// Create a copy of DataFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(_Network(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _Parsing implements DataFailure {
  const _Parsing({required this.message});

  @override
  final String message;

  /// Create a copy of DataFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ParsingCopyWith<_Parsing> get copyWith =>
      __$ParsingCopyWithImpl<_Parsing>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Parsing &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'DataFailure.parsing(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$ParsingCopyWith<$Res>
    implements $DataFailureCopyWith<$Res> {
  factory _$ParsingCopyWith(_Parsing value, $Res Function(_Parsing) _then) =
      __$ParsingCopyWithImpl;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$ParsingCopyWithImpl<$Res> implements _$ParsingCopyWith<$Res> {
  __$ParsingCopyWithImpl(this._self, this._then);

  final _Parsing _self;
  final $Res Function(_Parsing) _then;

  /// Create a copy of DataFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(_Parsing(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _EmptyResponse implements DataFailure {
  const _EmptyResponse({this.message});

  @override
  final String? message;

  /// Create a copy of DataFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EmptyResponseCopyWith<_EmptyResponse> get copyWith =>
      __$EmptyResponseCopyWithImpl<_EmptyResponse>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EmptyResponse &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'DataFailure.emptyResponse(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$EmptyResponseCopyWith<$Res>
    implements $DataFailureCopyWith<$Res> {
  factory _$EmptyResponseCopyWith(
          _EmptyResponse value, $Res Function(_EmptyResponse) _then) =
      __$EmptyResponseCopyWithImpl;
  @override
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$EmptyResponseCopyWithImpl<$Res>
    implements _$EmptyResponseCopyWith<$Res> {
  __$EmptyResponseCopyWithImpl(this._self, this._then);

  final _EmptyResponse _self;
  final $Res Function(_EmptyResponse) _then;

  /// Create a copy of DataFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_EmptyResponse(
      message: freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _Unexpected implements DataFailure {
  const _Unexpected({required this.message});

  @override
  final String message;

  /// Create a copy of DataFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnexpectedCopyWith<_Unexpected> get copyWith =>
      __$UnexpectedCopyWithImpl<_Unexpected>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Unexpected &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'DataFailure.unexpected(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$UnexpectedCopyWith<$Res>
    implements $DataFailureCopyWith<$Res> {
  factory _$UnexpectedCopyWith(
          _Unexpected value, $Res Function(_Unexpected) _then) =
      __$UnexpectedCopyWithImpl;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$UnexpectedCopyWithImpl<$Res> implements _$UnexpectedCopyWith<$Res> {
  __$UnexpectedCopyWithImpl(this._self, this._then);

  final _Unexpected _self;
  final $Res Function(_Unexpected) _then;

  /// Create a copy of DataFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(_Unexpected(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
