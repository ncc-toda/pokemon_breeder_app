// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'domain_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DomainFailure {
  String get message;
  Object? get cause;

  /// Create a copy of DomainFailure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DomainFailureCopyWith<DomainFailure> get copyWith =>
      _$DomainFailureCopyWithImpl<DomainFailure>(
          this as DomainFailure, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DomainFailure &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.cause, cause));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(cause));

  @override
  String toString() {
    return 'DomainFailure(message: $message, cause: $cause)';
  }
}

/// @nodoc
abstract mixin class $DomainFailureCopyWith<$Res> {
  factory $DomainFailureCopyWith(
          DomainFailure value, $Res Function(DomainFailure) _then) =
      _$DomainFailureCopyWithImpl;
  @useResult
  $Res call({String message, Object? cause});
}

/// @nodoc
class _$DomainFailureCopyWithImpl<$Res>
    implements $DomainFailureCopyWith<$Res> {
  _$DomainFailureCopyWithImpl(this._self, this._then);

  final DomainFailure _self;
  final $Res Function(DomainFailure) _then;

  /// Create a copy of DomainFailure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? cause = freezed,
  }) {
    return _then(_self.copyWith(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      cause: freezed == cause ? _self.cause : cause,
    ));
  }
}

/// @nodoc

class _DataFetchFailed implements DomainFailure {
  const _DataFetchFailed({required this.message, this.cause});

  @override
  final String message;
  @override
  final Object? cause;

  /// Create a copy of DomainFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DataFetchFailedCopyWith<_DataFetchFailed> get copyWith =>
      __$DataFetchFailedCopyWithImpl<_DataFetchFailed>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DataFetchFailed &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.cause, cause));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(cause));

  @override
  String toString() {
    return 'DomainFailure.dataFetchFailed(message: $message, cause: $cause)';
  }
}

/// @nodoc
abstract mixin class _$DataFetchFailedCopyWith<$Res>
    implements $DomainFailureCopyWith<$Res> {
  factory _$DataFetchFailedCopyWith(
          _DataFetchFailed value, $Res Function(_DataFetchFailed) _then) =
      __$DataFetchFailedCopyWithImpl;
  @override
  @useResult
  $Res call({String message, Object? cause});
}

/// @nodoc
class __$DataFetchFailedCopyWithImpl<$Res>
    implements _$DataFetchFailedCopyWith<$Res> {
  __$DataFetchFailedCopyWithImpl(this._self, this._then);

  final _DataFetchFailed _self;
  final $Res Function(_DataFetchFailed) _then;

  /// Create a copy of DomainFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
    Object? cause = freezed,
  }) {
    return _then(_DataFetchFailed(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      cause: freezed == cause ? _self.cause : cause,
    ));
  }
}

/// @nodoc

class _DataSaveFailed implements DomainFailure {
  const _DataSaveFailed({required this.message, this.cause});

  @override
  final String message;
  @override
  final Object? cause;

  /// Create a copy of DomainFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DataSaveFailedCopyWith<_DataSaveFailed> get copyWith =>
      __$DataSaveFailedCopyWithImpl<_DataSaveFailed>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DataSaveFailed &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.cause, cause));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(cause));

  @override
  String toString() {
    return 'DomainFailure.dataSaveFailed(message: $message, cause: $cause)';
  }
}

/// @nodoc
abstract mixin class _$DataSaveFailedCopyWith<$Res>
    implements $DomainFailureCopyWith<$Res> {
  factory _$DataSaveFailedCopyWith(
          _DataSaveFailed value, $Res Function(_DataSaveFailed) _then) =
      __$DataSaveFailedCopyWithImpl;
  @override
  @useResult
  $Res call({String message, Object? cause});
}

/// @nodoc
class __$DataSaveFailedCopyWithImpl<$Res>
    implements _$DataSaveFailedCopyWith<$Res> {
  __$DataSaveFailedCopyWithImpl(this._self, this._then);

  final _DataSaveFailed _self;
  final $Res Function(_DataSaveFailed) _then;

  /// Create a copy of DomainFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
    Object? cause = freezed,
  }) {
    return _then(_DataSaveFailed(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      cause: freezed == cause ? _self.cause : cause,
    ));
  }
}

/// @nodoc

class _DataDeleteFailed implements DomainFailure {
  const _DataDeleteFailed({required this.message, this.cause});

  @override
  final String message;
  @override
  final Object? cause;

  /// Create a copy of DomainFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DataDeleteFailedCopyWith<_DataDeleteFailed> get copyWith =>
      __$DataDeleteFailedCopyWithImpl<_DataDeleteFailed>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DataDeleteFailed &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.cause, cause));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(cause));

  @override
  String toString() {
    return 'DomainFailure.dataDeleteFailed(message: $message, cause: $cause)';
  }
}

/// @nodoc
abstract mixin class _$DataDeleteFailedCopyWith<$Res>
    implements $DomainFailureCopyWith<$Res> {
  factory _$DataDeleteFailedCopyWith(
          _DataDeleteFailed value, $Res Function(_DataDeleteFailed) _then) =
      __$DataDeleteFailedCopyWithImpl;
  @override
  @useResult
  $Res call({String message, Object? cause});
}

/// @nodoc
class __$DataDeleteFailedCopyWithImpl<$Res>
    implements _$DataDeleteFailedCopyWith<$Res> {
  __$DataDeleteFailedCopyWithImpl(this._self, this._then);

  final _DataDeleteFailed _self;
  final $Res Function(_DataDeleteFailed) _then;

  /// Create a copy of DomainFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
    Object? cause = freezed,
  }) {
    return _then(_DataDeleteFailed(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      cause: freezed == cause ? _self.cause : cause,
    ));
  }
}

/// @nodoc

class _NetworkError implements DomainFailure {
  const _NetworkError({required this.message, this.cause});

  @override
  final String message;
  @override
  final Object? cause;

  /// Create a copy of DomainFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NetworkErrorCopyWith<_NetworkError> get copyWith =>
      __$NetworkErrorCopyWithImpl<_NetworkError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NetworkError &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.cause, cause));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(cause));

  @override
  String toString() {
    return 'DomainFailure.networkError(message: $message, cause: $cause)';
  }
}

/// @nodoc
abstract mixin class _$NetworkErrorCopyWith<$Res>
    implements $DomainFailureCopyWith<$Res> {
  factory _$NetworkErrorCopyWith(
          _NetworkError value, $Res Function(_NetworkError) _then) =
      __$NetworkErrorCopyWithImpl;
  @override
  @useResult
  $Res call({String message, Object? cause});
}

/// @nodoc
class __$NetworkErrorCopyWithImpl<$Res>
    implements _$NetworkErrorCopyWith<$Res> {
  __$NetworkErrorCopyWithImpl(this._self, this._then);

  final _NetworkError _self;
  final $Res Function(_NetworkError) _then;

  /// Create a copy of DomainFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
    Object? cause = freezed,
  }) {
    return _then(_NetworkError(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      cause: freezed == cause ? _self.cause : cause,
    ));
  }
}

/// @nodoc

class _DatabaseError implements DomainFailure {
  const _DatabaseError({required this.message, this.cause});

  @override
  final String message;
  @override
  final Object? cause;

  /// Create a copy of DomainFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DatabaseErrorCopyWith<_DatabaseError> get copyWith =>
      __$DatabaseErrorCopyWithImpl<_DatabaseError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DatabaseError &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.cause, cause));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(cause));

  @override
  String toString() {
    return 'DomainFailure.databaseError(message: $message, cause: $cause)';
  }
}

/// @nodoc
abstract mixin class _$DatabaseErrorCopyWith<$Res>
    implements $DomainFailureCopyWith<$Res> {
  factory _$DatabaseErrorCopyWith(
          _DatabaseError value, $Res Function(_DatabaseError) _then) =
      __$DatabaseErrorCopyWithImpl;
  @override
  @useResult
  $Res call({String message, Object? cause});
}

/// @nodoc
class __$DatabaseErrorCopyWithImpl<$Res>
    implements _$DatabaseErrorCopyWith<$Res> {
  __$DatabaseErrorCopyWithImpl(this._self, this._then);

  final _DatabaseError _self;
  final $Res Function(_DatabaseError) _then;

  /// Create a copy of DomainFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
    Object? cause = freezed,
  }) {
    return _then(_DatabaseError(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      cause: freezed == cause ? _self.cause : cause,
    ));
  }
}

/// @nodoc

class _ValidationError implements DomainFailure {
  const _ValidationError({required this.message, this.cause});

  @override
  final String message;
  @override
  final Object? cause;

  /// Create a copy of DomainFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ValidationErrorCopyWith<_ValidationError> get copyWith =>
      __$ValidationErrorCopyWithImpl<_ValidationError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ValidationError &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.cause, cause));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(cause));

  @override
  String toString() {
    return 'DomainFailure.validationError(message: $message, cause: $cause)';
  }
}

/// @nodoc
abstract mixin class _$ValidationErrorCopyWith<$Res>
    implements $DomainFailureCopyWith<$Res> {
  factory _$ValidationErrorCopyWith(
          _ValidationError value, $Res Function(_ValidationError) _then) =
      __$ValidationErrorCopyWithImpl;
  @override
  @useResult
  $Res call({String message, Object? cause});
}

/// @nodoc
class __$ValidationErrorCopyWithImpl<$Res>
    implements _$ValidationErrorCopyWith<$Res> {
  __$ValidationErrorCopyWithImpl(this._self, this._then);

  final _ValidationError _self;
  final $Res Function(_ValidationError) _then;

  /// Create a copy of DomainFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
    Object? cause = freezed,
  }) {
    return _then(_ValidationError(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      cause: freezed == cause ? _self.cause : cause,
    ));
  }
}

/// @nodoc

class _NotFound implements DomainFailure {
  const _NotFound({required this.message, this.cause});

  @override
  final String message;
  @override
  final Object? cause;

  /// Create a copy of DomainFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NotFoundCopyWith<_NotFound> get copyWith =>
      __$NotFoundCopyWithImpl<_NotFound>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NotFound &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.cause, cause));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(cause));

  @override
  String toString() {
    return 'DomainFailure.notFound(message: $message, cause: $cause)';
  }
}

/// @nodoc
abstract mixin class _$NotFoundCopyWith<$Res>
    implements $DomainFailureCopyWith<$Res> {
  factory _$NotFoundCopyWith(_NotFound value, $Res Function(_NotFound) _then) =
      __$NotFoundCopyWithImpl;
  @override
  @useResult
  $Res call({String message, Object? cause});
}

/// @nodoc
class __$NotFoundCopyWithImpl<$Res> implements _$NotFoundCopyWith<$Res> {
  __$NotFoundCopyWithImpl(this._self, this._then);

  final _NotFound _self;
  final $Res Function(_NotFound) _then;

  /// Create a copy of DomainFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
    Object? cause = freezed,
  }) {
    return _then(_NotFound(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      cause: freezed == cause ? _self.cause : cause,
    ));
  }
}

/// @nodoc

class _Unauthorized implements DomainFailure {
  const _Unauthorized({required this.message, this.cause});

  @override
  final String message;
  @override
  final Object? cause;

  /// Create a copy of DomainFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UnauthorizedCopyWith<_Unauthorized> get copyWith =>
      __$UnauthorizedCopyWithImpl<_Unauthorized>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Unauthorized &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.cause, cause));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(cause));

  @override
  String toString() {
    return 'DomainFailure.unauthorized(message: $message, cause: $cause)';
  }
}

/// @nodoc
abstract mixin class _$UnauthorizedCopyWith<$Res>
    implements $DomainFailureCopyWith<$Res> {
  factory _$UnauthorizedCopyWith(
          _Unauthorized value, $Res Function(_Unauthorized) _then) =
      __$UnauthorizedCopyWithImpl;
  @override
  @useResult
  $Res call({String message, Object? cause});
}

/// @nodoc
class __$UnauthorizedCopyWithImpl<$Res>
    implements _$UnauthorizedCopyWith<$Res> {
  __$UnauthorizedCopyWithImpl(this._self, this._then);

  final _Unauthorized _self;
  final $Res Function(_Unauthorized) _then;

  /// Create a copy of DomainFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
    Object? cause = freezed,
  }) {
    return _then(_Unauthorized(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      cause: freezed == cause ? _self.cause : cause,
    ));
  }
}

/// @nodoc

class _EvolutionError implements DomainFailure {
  const _EvolutionError({required this.message, this.cause});

  @override
  final String message;
  @override
  final Object? cause;

  /// Create a copy of DomainFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EvolutionErrorCopyWith<_EvolutionError> get copyWith =>
      __$EvolutionErrorCopyWithImpl<_EvolutionError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EvolutionError &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.cause, cause));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(cause));

  @override
  String toString() {
    return 'DomainFailure.evolutionError(message: $message, cause: $cause)';
  }
}

/// @nodoc
abstract mixin class _$EvolutionErrorCopyWith<$Res>
    implements $DomainFailureCopyWith<$Res> {
  factory _$EvolutionErrorCopyWith(
          _EvolutionError value, $Res Function(_EvolutionError) _then) =
      __$EvolutionErrorCopyWithImpl;
  @override
  @useResult
  $Res call({String message, Object? cause});
}

/// @nodoc
class __$EvolutionErrorCopyWithImpl<$Res>
    implements _$EvolutionErrorCopyWith<$Res> {
  __$EvolutionErrorCopyWithImpl(this._self, this._then);

  final _EvolutionError _self;
  final $Res Function(_EvolutionError) _then;

  /// Create a copy of DomainFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
    Object? cause = freezed,
  }) {
    return _then(_EvolutionError(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      cause: freezed == cause ? _self.cause : cause,
    ));
  }
}

/// @nodoc

class _Unexpected implements DomainFailure {
  const _Unexpected({required this.message, this.cause});

  @override
  final String message;
  @override
  final Object? cause;

  /// Create a copy of DomainFailure
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
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.cause, cause));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, message, const DeepCollectionEquality().hash(cause));

  @override
  String toString() {
    return 'DomainFailure.unexpected(message: $message, cause: $cause)';
  }
}

/// @nodoc
abstract mixin class _$UnexpectedCopyWith<$Res>
    implements $DomainFailureCopyWith<$Res> {
  factory _$UnexpectedCopyWith(
          _Unexpected value, $Res Function(_Unexpected) _then) =
      __$UnexpectedCopyWithImpl;
  @override
  @useResult
  $Res call({String message, Object? cause});
}

/// @nodoc
class __$UnexpectedCopyWithImpl<$Res> implements _$UnexpectedCopyWith<$Res> {
  __$UnexpectedCopyWithImpl(this._self, this._then);

  final _Unexpected _self;
  final $Res Function(_Unexpected) _then;

  /// Create a copy of DomainFailure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
    Object? cause = freezed,
  }) {
    return _then(_Unexpected(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      cause: freezed == cause ? _self.cause : cause,
    ));
  }
}

// dart format on
