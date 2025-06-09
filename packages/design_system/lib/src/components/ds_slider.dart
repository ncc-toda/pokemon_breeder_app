import 'package:flutter/material.dart';

import '../design_tokens/ds_typography.dart';

/// {@template ds_slider_input}
/// 数値入力用スライダーのコンポーネント。
/// {@endtemplate}
class DsSlider extends StatelessWidget {
  /// {@macro ds_slider_input}
  const DsSlider({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.unit,
    required this.onChanged,
    super.key,
    this.showLabel = false,
  });

  /// 入力フィールドのラベル。
  final String label;

  /// 現在の値。
  final double value;

  /// スライダーの最小値。
  final double min;

  /// スライダーの最大値。
  final double max;

  /// 値の単位。
  final String unit;

  /// 値が変更されたときに呼び出されるコールバック。
  final ValueChanged<double> onChanged;

  /// ラベルを表示するかどうか。
  final bool showLabel;

  // 数値を整数として表示するフォーマッター
  String _formatNumber(double val) {
    final rounded = val.round();
    return rounded.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel)
          Text(
            '$label: ${_formatNumber(value)}$unit',
            style: DsTypography.bodyMedium.copyWith(color: Colors.grey[700]),
          ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: (max - min).toInt(),
          label: _formatNumber(value),
          activeColor: Theme.of(context).colorScheme.secondary,
          inactiveColor: Colors.grey[400],
          onChanged: onChanged,
        ),
      ],
    );
  }
}
