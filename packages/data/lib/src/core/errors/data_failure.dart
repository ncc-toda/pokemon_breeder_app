import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_failure.freezed.dart';

///  データ層で発生しうる失敗を表す型。
@freezed
sealed class DataFailure with _$DataFailure {
  /// ネットワーク関連の失敗。
  const factory DataFailure.network({required String message}) = _Network;

  /// JSON などのパース失敗。
  const factory DataFailure.parsing({required String message}) = _Parsing;

  /// API から空レスポンスが返った場合の失敗。
  const factory DataFailure.emptyResponse({String? message}) = _EmptyResponse;

  /// その他の予期しない失敗。
  const factory DataFailure.unexpected({required String message}) = _Unexpected;
}
