import 'dart:ui';

import 'ds_primitive_colors.dart';

/// 意味を持つ色を定義する [DsSemanticColors] クラス。
///
/// これらの色は UI 要素の役割や状態に基づいて定義され、[DsPrimitiveColors] を参照する。
class DsSemanticColors {
  // このクラスは原則としてインスタンス化されることを意図していない。
  const DsSemanticColors._();

  // * --- Core Semantic Colors --- * //
  /// アプリケーションの主要な色。アクションボタンや強調表示に使用されます。
  static const Color primary = DsPrimitiveColors.orange500;

  /// アプリケーションの第二の主要な色。アクセントや補足的なアクションに使用されます。
  static const Color secondary = DsPrimitiveColors.blue500;

  // * --- Background Colors --- * //
  /// 画面や主要コンテンツエリアのデフォルト背景色。
  /// (元 DsPrimitiveColors.neutral0 の想定。白の代替として最も明るいグレーを使用)
  static const Color backgroundPrimary = DsPrimitiveColors.black100;

  /// グループ化されたコンテンツやサイドバーなどの第二の背景色。
  /// (元 DsPrimitiveColors.neutral50 の想定)
  static const Color backgroundSecondary =
      DsPrimitiveColors.black200; // black100より少し濃い色

  /// あまり目立たない領域の第三の背景色。
  /// (元 DsPrimitiveColors.neutral100 の想定)
  static const Color backgroundTertiary =
      DsPrimitiveColors.black300; // black200より少し濃い色

  /// 無効状態の要素の背景色。
  /// (元 DsPrimitiveColors.neutral200 の想定)
  static const Color backgroundDisabled = DsPrimitiveColors.black200;

  /// ダークテーマや反転表示時の背景色。
  /// (元 DsPrimitiveColors.neutral900 の想定)
  static const Color backgroundInverse = DsPrimitiveColors.black800;

  /// ブランドを強調する要素の背景色 (primary を使用)。
  static const Color backgroundBrand = primary;

  /// アクセント要素の背景色 (secondary を使用)。
  static const Color backgroundAccent = secondary;

  /// エラー状態を示す背景色。
  static const Color backgroundError = DsPrimitiveColors.red100;

  /// 警告状態を示す背景色。
  static const Color backgroundWarning = DsPrimitiveColors.yellow200;

  /// 成功状態を示す背景色。
  static const Color backgroundSuccess = DsPrimitiveColors.green100;

  /// 情報提供を示す背景色。
  static const Color backgroundInfo = DsPrimitiveColors.blue100;

  // * --- Text Colors --- * //
  /// 主要コンテンツのテキスト色。
  /// (元 DsPrimitiveColors.neutral900 の想定)
  static const Color textPrimary = DsPrimitiveColors.black800;

  /// 副次的な情報や補助テキストのテキスト色。
  /// (元 DsPrimitiveColors.neutral500 の想定)
  static const Color textSecondary = DsPrimitiveColors.black500;

  /// ヒントや注釈など、さらに重要度の低いテキスト色。
  /// (元 DsPrimitiveColors.neutral400 の想定)
  static const Color textTertiary = DsPrimitiveColors.black300;

  /// 入力フィールドのプレースホルダーテキストの色。
  /// (元 DsPrimitiveColors.neutral300 の想定)
  static const Color textPlaceholder = DsPrimitiveColors.black300;

  /// 無効状態のテキスト色。
  /// (元 DsPrimitiveColors.disabled の想定)
  static const Color textDisabled = DsPrimitiveColors.black200; // やや薄いグレー

  /// リンクのテキスト色 (primary を使用)。
  static const Color textLink = primary;

  /// エラーメッセージやエラー状態のテキスト色。
  static const Color textError = DsPrimitiveColors.red800;

  /// 警告メッセージや警告状態のテキスト色。
  static const Color textWarning = DsPrimitiveColors.orange800;

  /// 成功メッセージや成功状態のテキスト色。
  static const Color textSuccess = DsPrimitiveColors.green800;

  /// 情報提供メッセージや情報状態のテキスト色。
  static const Color textInfo = DsPrimitiveColors.blue800;

  /// プライマリカラー背景上のテキスト色。
  /// (元 DsPrimitiveColors.neutral0 の想定。白の代替として最も明るいグレーを使用)
  static const Color textOnPrimary =
      DsPrimitiveColors.black100; // オレンジ背景には白が理想だが、black100で代用

  /// セカンダリカラー背景上のテキスト色。
  /// (元 DsPrimitiveColors.neutral0 の想定。白の代替として最も明るいグレーを使用)
  static const Color textOnSecondary =
      DsPrimitiveColors.black100; // 青背景には白が理想だが、black100で代用

  /// ブランドカラー背景上のテキスト色 (textOnPrimary と同じ)。
  static const Color textOnBrand = textOnPrimary;

  /// アクセントカラー背景上のテキスト色 (textOnSecondary と同じ)。
  static const Color textOnAccent = textOnSecondary;

  /// 反転表示背景上のテキスト色。
  /// (元 DsPrimitiveColors.neutral0 の想定。白の代替として最も明るいグレーを使用)
  static const Color textOnInverse =
      DsPrimitiveColors.black100; // 黒背景には白が理想だが、black100で代用

  /// エラーカラー背景上のテキスト色。
  /// (元は neutral0 だったが、薄赤背景(red100)には濃い色が適切)
  static const Color textOnError = DsPrimitiveColors.black800;

  /// 警告カラー背景上のテキスト色。
  static const Color textOnWarning = DsPrimitiveColors.black800; // 黄色背景には黒
  /// 成功カラー背景上のテキスト色。
  static const Color textOnSuccess = DsPrimitiveColors.black800; // 薄緑背景には黒
  /// 情報カラー背景上のテキスト色。
  static const Color textOnInfo = DsPrimitiveColors.black800; // 薄青背景には黒

  // * --- Border Colors --- * //
  /// カードや入力フィールドなどのデフォルトの境界線色。
  /// (元 DsPrimitiveColors.neutral200 の想定)
  static const Color borderDefault = DsPrimitiveColors.black200;

  /// あまり目立たない区切り線や境界線の色。
  /// (元 DsPrimitiveColors.neutral100 の想定)
  static const Color borderMuted = DsPrimitiveColors.black100;

  /// 強調したい場合の境界線色。
  /// (元 DsPrimitiveColors.neutral500 の想定)
  static const Color borderStrong = DsPrimitiveColors.black500;

  /// フォーカス状態の要素の境界線色 (primary を使用)。
  static const Color borderFocus = primary;

  /// エラー状態の境界線色。
  static const Color borderError = DsPrimitiveColors.red500;

  /// 警告状態の境界線色。
  static const Color borderWarning = DsPrimitiveColors.orange500;

  /// 成功状態の境界線色。
  static const Color borderSuccess = DsPrimitiveColors.green500;

  /// 情報提供要素の境界線色。
  static const Color borderInfo = DsPrimitiveColors.blue500;

  // * --- Icon Colors --- * //
  /// 主要なアイコンの色。
  /// (元 DsPrimitiveColors.neutral900 の想定)
  static const Color iconPrimary = DsPrimitiveColors.black800;

  /// 副次的なアイコンの色。
  /// (元 DsPrimitiveColors.neutral500 の想定)
  static const Color iconSecondary = DsPrimitiveColors.black500;

  /// あまり重要でないアイコンの色。
  /// (元 DsPrimitiveColors.neutral400 の想定)
  static const Color iconTertiary = DsPrimitiveColors.black300;

  /// 無効状態のアイコンの色。
  /// (元 DsPrimitiveColors.disabled の想定)
  static const Color iconDisabled = DsPrimitiveColors.black200;

  /// ブランドカラーのアイコン色 (primary を使用)。
  static const Color iconBrand = primary;

  /// アクセントカラーのアイコン色 (secondary を使用)。
  static const Color iconAccent = secondary;

  /// エラー状態を示すアイコンの色。
  static const Color iconError = DsPrimitiveColors.red500;

  /// 警告状態を示すアイコンの色。
  static const Color iconWarning = DsPrimitiveColors.orange500;

  /// 成功状態を示すアイコンの色。
  static const Color iconSuccess = DsPrimitiveColors.green500;

  /// 情報提供を示すアイコンの色。
  static const Color iconInfo = DsPrimitiveColors.blue500;

  /// プライマリカラー背景上のアイコン色。
  /// (元 DsPrimitiveColors.neutral0 の想定。白の代替として最も明るいグレーを使用)
  static const Color iconOnPrimary = DsPrimitiveColors.black100;

  /// 反転表示背景上のアイコン色。
  /// (元 DsPrimitiveColors.neutral0 の想定。白の代替として最も明るいグレーを使用)
  static const Color iconOnInverse = DsPrimitiveColors.black100;

  // * --- Focus / State --- * //
  /// フォーカスインジケータ (例: フォーカスされた入力フィールドの周囲のリング) の色。
  static Color get focusRing => primary.withValues(alpha: 0.5);

  // * --- Feedback Colors --- * //
  /// エラーフィードバック (エラーメッセージ、エラーアイコンなど) のための色。
  static const Color feedbackError = DsPrimitiveColors.red500;

  /// 警告フィードバックのための色。
  static const Color feedbackWarning = DsPrimitiveColors.orange500;

  /// 成功フィードバックのための色。
  static const Color feedbackSuccess = DsPrimitiveColors.green500;

  /// 情報提供フィードバックのための色。
  static const Color feedbackInfo = DsPrimitiveColors.blue500;
}
