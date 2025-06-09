import 'package:flutter/material.dart';

import '../../design_system.dart';

/// セグメント化されたボタンコンポーネント。
///
/// {@template ds_segmented_button}
/// Flutter 標準の [SegmentedButton] をラップし、
/// アプリケーション全体で一貫したルックアンドフィールを提供する。
/// {@endtemplate}
class DsSegmentedButton<T extends Object> extends StatelessWidget {
  /// {@macro ds_segmented_button}
  const DsSegmentedButton({
    required this.segments,
    required this.selected,
    required this.onSelectionChanged,
    super.key,
    this.showSelectedIcon = false,
    this.style,
    this.multiSelectionEnabled = false,
    this.emptySelectionAllowed = false,
  });

  /// 表示するセグメントのリスト。
  final List<ButtonSegment<T>> segments;

  /// 現在選択されているセグメントのセット。
  final Set<T> selected;

  /// 選択が変更されたときに呼び出されるコールバック。
  final void Function(Set<T>)? onSelectionChanged;

  /// 選択されたアイコンを表示するかどうか。デフォルトは false.
  final bool showSelectedIcon;

  /// ボタンのスタイル。指定しない場合はデフォルトのスタイルが適用される。
  final ButtonStyle? style;

  /// 複数選択を許可するかどうか。デフォルトは false.
  final bool multiSelectionEnabled;

  /// 空の選択を許可するかどうか。デフォルトは false.
  final bool emptySelectionAllowed;

  @override
  Widget build(BuildContext context) {
    final defaultStyle = SegmentedButton.styleFrom(
      backgroundColor: Colors.grey[800]?.withValues(alpha: 0.7),
      foregroundColor: Colors.white,
      selectedForegroundColor: Colors.black,
      selectedBackgroundColor: Colors.white.withValues(alpha: 0.9),
      textStyle: DsTypography.labelLarge,
    );

    return SegmentedButton<T>(
      segments: segments,
      selected: selected,
      onSelectionChanged: onSelectionChanged,
      showSelectedIcon: showSelectedIcon,
      style: style ?? defaultStyle,
      multiSelectionEnabled: multiSelectionEnabled,
      emptySelectionAllowed: emptySelectionAllowed,
    );
  }
}
