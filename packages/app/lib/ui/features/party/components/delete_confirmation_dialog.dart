import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 削除確認ダイアログの設定
class DeleteConfirmationConfig {
  const DeleteConfirmationConfig({
    required this.pokemon,
    this.onDeleteSuccess,
    this.onDeleteError,
  });

  /// 削除対象のポケモン
  final Pokemon pokemon;

  /// 削除成功時のコールバック
  final void Function(Pokemon pokemon)? onDeleteSuccess;

  /// 削除エラー時のコールバック
  final void Function(DomainFailure failure)? onDeleteError;
}

/// ポケモンをパーティから削除する確認ダイアログ
class DeleteConfirmationDialog extends HookConsumerWidget {
  const DeleteConfirmationDialog({super.key, required this.config});

  /// ダイアログの設定
  final DeleteConfirmationConfig config;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('パーティから外す'),
      content: Text('${config.pokemon.displayName} をパーティから外しますか？'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            await _handleDelete(context, ref);
          },
          child: const Text('外す'),
        ),
      ],
    );
  }

  /// 削除処理を実行する
  Future<void> _handleDelete(BuildContext context, WidgetRef ref) async {
    final result = await ref
        .read(currentPartyStateProvider.notifier)
        .removePokemonFromParty(config.pokemon.id);

    result.when(
      success: (_) {
        // スナックバーで削除完了メッセージを表示
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${config.pokemon.displayName} をパーティから外しました'),
            duration: const Duration(seconds: 2),
            action: SnackBarAction(
              label: '取り消し',
              onPressed: () => _handleUndo(ref),
            ),
          ),
        );
        config.onDeleteSuccess?.call(config.pokemon);
      },
      failure: (failure) {
        // エラーメッセージを表示
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('エラー: ${failure.message}'),
            backgroundColor: Theme.of(context).colorScheme.error,
            duration: const Duration(seconds: 3),
          ),
        );
        config.onDeleteError?.call(failure);
      },
    );
  }

  /// 削除の取り消し処理
  Future<void> _handleUndo(WidgetRef ref) async {
    final addResult = await ref
        .read(currentPartyStateProvider.notifier)
        .addPokemonToParty(config.pokemon.id);
    addResult.when(
      success: (_) => {},
      failure: (failure) {
        debugPrint('Failed to re-add pokemon: ${failure.message}');
      },
    );
  }
}