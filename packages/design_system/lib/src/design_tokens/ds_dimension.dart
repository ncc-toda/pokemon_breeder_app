/// アプリケーション全体で使用する寸法（サイズ、高さ、幅など）の値を定義するクラス。
///
/// UI要素のサイズ、コンポーネントの高さや幅、アイコンの大きさなどに使用する。
class DsDimension {
  // このクラスはインスタンス化されることを意図していない。
  const DsDimension._();

  // * --- Base Scale --- * //
  // フィボナッチ数列 (Fn) * 8 をコアとし、補完的に8の倍数、および2,4の倍数を使用。

  /// 2.0 (8 * 0.25).
  static const double scale_0_25x = 2;

  /// 4.0 (8 * 0.5).
  static const double scale_0_5x = 4;

  /// 6.0 (8 * 0.75).
  static const double scale_0_75x = 6;

  /// 8.0 (8 * 1).
  static const double scale_1x = 8;

  /// 10.0 (8 * 1.25).
  static const double scale_1_25x = 10;

  /// 12.0 (8 * 1.5).
  static const double scale_1_5x = 12;

  /// 14.0 (8 * 1.75).
  static const double scale_1_75x = 14;

  /// 16.0 (8 * 2).
  static const double scale_2x = 16;

  /// 20.0 (8 * 2.5).
  static const double scale_2_5x = 20;

  /// 24.0 (8 * 3).
  static const double scale_3x = 24;

  /// 32.0 (8 * 4).
  static const double scale_4x = 32;

  /// 40.0 (8 * 5).
  static const double scale_5x = 40;

  /// 48.0 (8 * 6).
  static const double scale_6x = 48;

  /// 64.0 (8 * 8).
  static const double scale_8x = 64;

  /// 80.0 (8 * 10).
  static const double scale_10x = 80;

  /// 104.0. (8 * 13)
  static const double scale_13x = 104;

  /// 120.0. (8 * 15)
  static const double scale_15x = 120;

  /// 168.0. (8 * 21)
  static const double scale_21x = 168;

  // * --- アイコンサイズ --- * //

  /// アイコンサイズ XS (Extra Small).
  static const double iconSizeXs = scale_1_5x;

  /// アイコンサイズ S (Small).
  static const double iconSizeS = scale_2x;

  /// アイコンサイズ M (Medium).
  static const double iconSizeM = scale_2_5x;

  /// アイコンサイズ L (Large).
  static const double iconSizeL = scale_3x;

  /// アイコンサイズ XL (Extra Large).
  static const double iconSizeXl = scale_4x;

  /// アイコンサイズ XXL (Extra Extra Large).
  static const double iconSizeXxl = scale_5x;

  // * --- ボタン関連 --- * //

  /// 小さいボタンの高さ。
  static const double buttonHeightSmall = scale_4x;

  /// 中くらいのボタンの高さ。
  static const double buttonHeightMedium = scale_5x;

  /// 大きいボタンの高さ。
  static const double buttonHeightLarge = scale_6x;

  /// 小さいボタンの横幅。
  static const double buttonWidthSmall = scale_8x;

  /// 中くらいのボタンの横幅。
  static const double buttonWidthMedium = scale_10x;

  /// 大きいボタンの横幅。
  static const double buttonWidthLarge = scale_13x;

  // * --- コンポーネントの標準的な高さ/幅 --- * //

  /// 小さいリストアイテムの高さ。
  static const double listItemHeightSmall = scale_5x;

  /// 中くらいのリストアイテムの高さ。
  static const double listItemHeightMedium = scale_6x;

  /// 大きいリストアイテムの高さ。
  static const double listItemHeightLarge = scale_8x;

  // * --- 境界線/区切り線 --- * //

  /// 極細の境界線の太さ。
  static const double borderWidthHairline = 1;

  /// 細い境界線の太さ。
  static const double borderWidthThin = scale_0_25x;

  /// 太い境界線の太さ。
  static const double borderWidthThick = scale_0_5x;

  /// 標準的な区切り線の太さ。
  static const double dividerThickness = 1;

  // * --- タップターゲット --- * //

  /// 最小タップターゲットサイズ。
  static const double minTapTargetSize = scale_6x;

  // * --- レイアウト関連 --- * //

  /// アプリ最上部に表示する TopBar の高さ。
  static const double appBarHeight = scale_6x;

  /// アプリ最下部に表示する BottomBar の高さ。
  static const double bottomBarHeight = scale_6x;
}
