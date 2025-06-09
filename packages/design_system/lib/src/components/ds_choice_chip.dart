import 'package:flutter/material.dart';

import '../design_tokens/ds_typography.dart';

/// {@template ds_choice_chip}
/// 選択に使用するコンポーネント。 ( [ChoiceChip] のラッパー。 )
/// {@endtemplate}
class DsChoiceChip extends StatelessWidget {
  /// {@macro ds_choice_chip}
  const DsChoiceChip({
    required this.label,
    required this.selected,
    required this.onSelected,
    super.key,
  });

  /// 選択肢のラベル。
  final String label;

  /// 選択状態。
  final bool selected;

  /// 選択時のコールバック。
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(
        label,
        style: DsTypography.bodyMedium.copyWith(
          color: selected ? Colors.white : Colors.grey[800],
        ),
      ),
      selected: selected,
      selectedColor: Theme.of(context).colorScheme.primary,
      backgroundColor: Colors.grey[200],
      onSelected: onSelected,
    );
  }
}
