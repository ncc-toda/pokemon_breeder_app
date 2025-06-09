import 'package:flutter/material.dart';

/// 1つから3つのアクションボタンを表示する Widget.
/// 主に `Scaffold.bottomNavigationBar` での使用を想定している。
class DsBottomBar extends StatelessWidget {
  /// コンストラクタ。
  const DsBottomBar({
    required this.actions,
    super.key,
  }) : assert(
          actions.length >= 1 && actions.length <= 3,
          'AppBottomBar は1から3つのアクションを持つ必要があります。',
        );

  // TODO(me): 型で Button を強制する。
  /// ボタンとして表示する [Widget] のリスト。
  ///
  /// 1つ以上3つ以下のアクションを含む必要がある。
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12).copyWith(bottom: 20),
        child: Row(
          // ボタンが1つの場合は中央揃え、2つ以上の場合は均等配置
          mainAxisAlignment: actions.length == 1
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceBetween,
          children: actions.map((action) => action).toList(),
        ),
      ),
    );
  }
}
