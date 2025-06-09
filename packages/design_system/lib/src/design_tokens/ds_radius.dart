import 'ds_dimension.dart';

/// アプリケーション全体で使用する角丸 (Radius) の値を定義するクラス。
///
/// UI 要素の角の丸みに使用する。
class DsRadius {
  // このクラスはインスタンス化されることを意図していない。
  const DsRadius._();

  /// 角丸なし。
  static const double none = 0;

  /// とても小さい角丸。
  static const double xs = DsDimension.scale_0_5x;

  /// 小さい角丸。
  /// 例: 小さいボタンなど。
  static const double s = DsDimension.scale_0_75x;

  /// 標準的な角丸。
  /// 例: 中くらいのボタン、カードコンポーネントなど。
  static const double m = DsDimension.scale_1x;

  /// やや大きめの角丸。
  /// 例: 大きいボタンなど。
  static const double l = DsDimension.scale_1_5x;

  /// 大きめの角丸。
  static const double xl = DsDimension.scale_2x;

  /// とても大きな角丸。
  static const double xxl = DsDimension.scale_3x;

  /// 円形またはピル形状にするための非常に大きな値。
  /// Widget の高さ/幅がこれより小さい場合、実質的に角が完全に丸くなる。
  static const double full = 9999;
}
