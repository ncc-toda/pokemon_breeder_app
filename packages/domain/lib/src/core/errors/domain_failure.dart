import 'package:freezed_annotation/freezed_annotation.dart';

part 'domain_failure.freezed.dart';

/// Domain層で発生するエラーを表すFailure型。
@freezed
sealed class DomainFailure with _$DomainFailure {
  /// データ取得に失敗した場合のエラー。
  const factory DomainFailure.dataFetchFailed({
    required String message,
    Object? cause,
  }) = _DataFetchFailed;

  /// データ保存に失敗した場合のエラー。
  const factory DomainFailure.dataSaveFailed({
    required String message,
    Object? cause,
  }) = _DataSaveFailed;

  /// データ削除に失敗した場合のエラー。
  const factory DomainFailure.dataDeleteFailed({
    required String message,
    Object? cause,
  }) = _DataDeleteFailed;

  /// ネットワーク関連のエラー。
  const factory DomainFailure.networkError({
    required String message,
    Object? cause,
  }) = _NetworkError;

  /// データベース関連のエラー。
  const factory DomainFailure.databaseError({
    required String message,
    Object? cause,
  }) = _DatabaseError;

  /// バリデーションエラー。
  const factory DomainFailure.validationError({
    required String message,
    Object? cause,
  }) = _ValidationError;

  /// 対象が見つからない場合のエラー。
  const factory DomainFailure.notFound({
    required String message,
    Object? cause,
  }) = _NotFound;

  /// 許可されていない操作の場合のエラー。
  const factory DomainFailure.unauthorized({
    required String message,
    Object? cause,
  }) = _Unauthorized;

  /// 進化・退化処理に関するエラー。
  const factory DomainFailure.evolutionError({
    required String message,
    Object? cause,
  }) = _EvolutionError;

  /// その他の予期しないエラー。
  const factory DomainFailure.unexpected({
    required String message,
    Object? cause,
  }) = _Unexpected;
}

