import 'package:flutter/material.dart';

/// デザインシステムに準拠した区切り線コンポーネント。
///
/// {@template ds_divider}
/// Flutter 標準の [Divider] をラップし、
/// アプリケーション全体で一貫したルックアンドフィールを提供する。
/// デフォルトでは、色は `Colors.white30` に設定されている。
/// {@endtemplate}
class DsDivider extends StatelessWidget {
  /// {@macro ds_divider}
  const DsDivider({
    super.key,
    this.color = Colors.white30,
    this.thickness,
    this.indent,
    this.endIndent,
  });

  /// 区切り線の色。デフォルトは `Colors.white30`.
  final Color color;

  /// 区切り線の太さ。
  final double? thickness;

  /// 区切り線の開始前のスペースの量。
  final double? indent;

  /// 区切り線の終了後のスペースの量。
  final double? endIndent;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color,
      height: 24,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
