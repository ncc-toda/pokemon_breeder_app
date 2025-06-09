import 'package:flutter/material.dart';

/// アプリケーション全体で使用するタイポグラフィスタイルを定義するクラス。
///
/// 主要なテキストスタイル（見出し、本文、キャプションなど）を定義し、
/// UI の一貫性を保ち、テーマの変更にも対応しやすくする。
class DsTypography {
  // このクラスはインスタンス化されることを意図していない。
  const DsTypography._();

  /// ベースとなるフォントファミリー。
  static const String _baseFontFamily = 'MochiyPopOne';

  /// Title Extra Large - かなり大きなタイトル。(例: TopPage のアプリタイトルなど)
  /// アプリケーションの顔となるような、非常に目立たせたいタイトルに使用する。
  static const TextStyle titleExtraLarge = TextStyle(
    fontFamily: _baseFontFamily,
    fontSize: 36,
    fontWeight: FontWeight.w400,
  );

  /// Title Large - 大きなタイトル。 (例: AppBarのタイトル)
  /// AppBar のタイトルや、それに準じる重要度のタイトルに使用する。
  static const TextStyle titleLarge = TextStyle(
    fontFamily: _baseFontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w500,
  );

  /// Title Medium - 中程度のタイトル。 (例: カードのタイトル、ダイアログのタイトル、リストアイテムの主要テキスト)
  /// UI 要素グループのタイトルや、リストの主要な項目名などに使用する。
  static const TextStyle titleMedium = TextStyle(
    fontFamily: _baseFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  /// Title Small - 小さなタイトル。 (例: 設定画面の各設定項目のグループ名など)
  /// やや補助的な情報のグループ名や、小さめの見出しに使用する。
  static const TextStyle titleSmall = TextStyle(
    fontFamily: _baseFontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  /// Body Large - 大きめの本文テキスト。(例: やや強調したい説明文、ダイアログ内の主要メッセージなど)
  /// 通常の本文よりも少し目立たせたいテキストに使用する。
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: _baseFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  /// Body Medium - 標準の本文テキスト。(例: 通常の説明文、リストアイテムのサブテキストなど)
  /// アプリケーション内の基本的なテキストコンテンツに使用する。
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: _baseFontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

  /// Body Small - 小さめの本文テキスト、キャプションなど。(例: TextField のヒント、注釈、リストアイテムの補助情報)
  /// 補足情報や、細かな説明テキストに使用する。
  static const TextStyle bodySmall = TextStyle(
    fontFamily: _baseFontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  );

  /// Label Large - ボタンやタブなどの大きめのラベル。
  /// 主要なアクションボタンのテキストや、タブのラベルに使用する。
  static const TextStyle labelLarge = TextStyle(
    fontFamily: _baseFontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  /// Label Small - 小さめのラベル、Chip 内のテキストなどの小さめのラベル。
  /// 補助的なボタンや、 Chip ウィジェット内のテキストに使用する。
  static const TextStyle labelSmall = TextStyle(
    fontFamily: _baseFontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );
}
