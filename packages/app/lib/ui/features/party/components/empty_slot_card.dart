import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// 空のパーティスロットを表示するWidget
class EmptySlotCard extends StatelessWidget {
  const EmptySlotCard({super.key, required this.onTap});

  /// カードタップ時のコールバック
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DsRadius.xl),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(DsRadius.xl),
        child: Padding(
          padding: DsPadding.allS,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_circle_outline,
                size: DsDimension.iconSizeXxl,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: DsSpacing.s),
              Text(
                'ポケモンを追加',
                style: DsTypography.titleSmall.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}