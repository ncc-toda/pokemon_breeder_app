import 'package:flutter/painting.dart';

import 'ds_spacing.dart';

/// アプリケーション全体で使用するパディング値を定義するクラス。
///
/// UI 要素の内側の余白 (`padding`) に使用する。
/// 値は [DsSpacing] を参照して定義される。
class DsPadding {
  // このクラスはインスタンス化されることを意図していない。
  const DsPadding._();

  // * --- All --- * //

  /// 全方向のかなり小さいパディング。
  static const EdgeInsets allXs = EdgeInsets.all(DsSpacing.xs);

  /// 全方向の小さいパディング。
  static const EdgeInsets allS = EdgeInsets.all(DsSpacing.s);

  /// 全方向の標準的なパディング。
  static const EdgeInsets allM = EdgeInsets.all(DsSpacing.m);

  /// 全方向の大きいパディング。
  static const EdgeInsets allL = EdgeInsets.all(DsSpacing.l);

  /// 全方向のかなり大きいパディング。
  static const EdgeInsets allXl = EdgeInsets.all(DsSpacing.xl);

  // * --- Symmetric: Horizontal --- * //

  /// 横方向（左右）のかなり小さいパディング。
  static const EdgeInsets horizontalXs =
      EdgeInsets.symmetric(horizontal: DsSpacing.xs);

  /// 横方向（左右）の小さいパディング。
  static const EdgeInsets horizontalS =
      EdgeInsets.symmetric(horizontal: DsSpacing.s);

  /// 横方向（左右）の標準的なパディング。
  static const EdgeInsets horizontalM =
      EdgeInsets.symmetric(horizontal: DsSpacing.m);

  /// 横方向（左右）の大きいパディング。
  static const EdgeInsets horizontalL =
      EdgeInsets.symmetric(horizontal: DsSpacing.l);

  /// 横方向（左右）のかなり大きいパディング。
  static const EdgeInsets horizontalXl =
      EdgeInsets.symmetric(horizontal: DsSpacing.xl);

  // * --- Symmetric: Vertical --- * //

  /// 縦方向（上下）のかなり小さいパディング。
  static const EdgeInsets verticalXs =
      EdgeInsets.symmetric(vertical: DsSpacing.xs);

  /// 縦方向（上下）の小さいパディング。
  static const EdgeInsets verticalS =
      EdgeInsets.symmetric(vertical: DsSpacing.s);

  /// 縦方向（上下）の標準的なパディング。
  static const EdgeInsets verticalM =
      EdgeInsets.symmetric(vertical: DsSpacing.m);

  /// 縦方向（上下）の大きいパディング。
  static const EdgeInsets verticalL =
      EdgeInsets.symmetric(vertical: DsSpacing.l);

  /// 縦方向（上下）のかなり大きいパディング。
  static const EdgeInsets verticalXl =
      EdgeInsets.symmetric(vertical: DsSpacing.xl);

  // * --- 画面全体の標準的なパディング --- * //
}
