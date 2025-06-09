import 'package:flutter/material.dart';

/// アプリ上部にヘッダーとして配置される Widget.
class DsTopBar extends StatelessWidget {
  /// コンストラクタ。
  const DsTopBar({
    required this.content,
    super.key,
  });

  /// コンテンツとして表示する [Widget].
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: content,
      ),
    );
  }
}
