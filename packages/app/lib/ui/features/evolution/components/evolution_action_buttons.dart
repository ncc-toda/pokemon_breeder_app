import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

/// 進化確認アクションボタンの設定
class EvolutionActionButtonsConfig {
  const EvolutionActionButtonsConfig({
    required this.onCancel,
    required this.onConfirm,
    this.isLoading = false,
  });

  /// キャンセルボタンタップ時のコールバック
  final VoidCallback onCancel;

  /// 承認ボタンタップ時のコールバック
  final VoidCallback onConfirm;

  /// ローディング状態かどうか
  final bool isLoading;
}

/// 進化確認画面のアクションボタン用のWidget
class EvolutionActionButtons extends StatelessWidget {
  const EvolutionActionButtons({super.key, required this.config});

  /// アクションボタンの設定
  final EvolutionActionButtonsConfig config;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DsButton(
            onPressed: config.isLoading ? null : config.onCancel,
            label: 'キャンセル',
            type: DsButtonType.destructive,
          ),
        ),
        const SizedBox(width: DsSpacing.l),
        Expanded(
          child: DsButton(
            onPressed: config.isLoading ? null : config.onConfirm,
            label: config.isLoading ? '処理中...' : '承認',
            type: DsButtonType.primary,
          ),
        ),
      ],
    );
  }
}
