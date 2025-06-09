import 'package:flutter/material.dart';

import '../../design_system.dart';

/// 小さな情報ブロックを囲むための汎用的なボックスコンポーネント。
class DsBoxSmall extends StatelessWidget {
  /// コンストラクタ。
  const DsBoxSmall({
    required this.child,
    super.key,
  });

  /// ボックス内に表示する主要なコンテンツ。
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black.withValues(alpha: 0.6),
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: child,
      ),
    );
  }
}

/// 大きめのコンテンツ（縦長のリストなど）を表示するための汎用ボックスコンポーネント。
///
/// 黒背景のカードスタイルで、必須のタイトルと子ウィジェットを表示します。
class DsBoxLarge extends StatelessWidget {
  /// コンストラクタ。
  const DsBoxLarge({
    required this.title,
    required this.child,
    super.key,
  });

  /// ボックスの上に表示されるタイトル。
  final String title;

  /// ボックス内に表示されるメインのコンテンツウィジェット。
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black.withValues(alpha: 0.6),
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              title,
              style: DsTypography.labelLarge.copyWith(color: Colors.white70),
            ),
            const SizedBox(height: DsSpacing.s),
            child,
          ],
        ),
      ),
    );
  }
}
