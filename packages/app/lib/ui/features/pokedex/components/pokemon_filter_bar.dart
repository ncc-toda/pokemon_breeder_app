import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// フィルターバー表示用のWidget
class PokemonFilterBar extends StatelessWidget {
  const PokemonFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: DsPadding.allS,
      child: Wrap(
        spacing: DsSpacing.s,
        runSpacing: DsSpacing.s,
        children: [
          DsChoiceChip(
            label: 'カントー',
            selected: true,
            onSelected: (selected) {
              // TODO(tetsu): フィルター機能
            },
          ),
          DsChoiceChip(
            label: 'ジョウト',
            selected: false,
            onSelected: (selected) {
              // TODO(tetsu): フィルター機能
            },
          ),
          DsChoiceChip(
            label: 'ホウエン',
            selected: false,
            onSelected: (selected) {
              // TODO(tetsu): フィルター機能
            },
          ),
        ],
      ),
    );
  }
}
