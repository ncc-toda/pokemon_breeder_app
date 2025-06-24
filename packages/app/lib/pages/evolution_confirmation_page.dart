import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:domain/domain.dart';
import 'package:pokemon_breeder_app/widgets/pokemon_info_view.dart';

/// 進化確認画面のパラメータ。
class EvolutionConfirmationParams {
  const EvolutionConfirmationParams({
    required this.partyPokemonId,
    required this.beforePokemon,
    required this.afterPokemon,
  });

  /// パーティポケモンのID
  final int partyPokemonId;

  /// 進化前のポケモン
  final Pokemon beforePokemon;

  /// 進化後のポケモン
  final Pokemon afterPokemon;
}

class EvolutionConfirmationPage extends HookConsumerWidget {
  const EvolutionConfirmationPage({
    super.key,
    required this.params,
  });

  final EvolutionConfirmationParams params;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DsScaffold(
      topBarContent: const DsTopBar(
        content: Text('進化確認'),
      ),
      body: Padding(
        padding: DsPadding.allL,
        child: Column(
          children: [
            const Spacer(),
            Text(
              '${params.beforePokemon.displayName}は ${params.afterPokemon.displayName} に進化します。\nよろしいですか？',
              style: DsTypography.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: DsSpacing.xl),
            _PokemonCompareView(
              beforePokemon: params.beforePokemon,
              afterPokemon: params.afterPokemon,
            ),
            const Spacer(),
            _EvolutionActionButtons(
              onCancel: () => _onCancel(context),
              onConfirm: () => _onConfirm(context, ref),
            ),
            const SizedBox(height: DsSpacing.l),
          ],
        ),
      ),
    );
  }



  /// キャンセルボタンがタップされた時の処理。
  void _onCancel(BuildContext context) {
    context.pop();
  }

  /// 承認ボタンがタップされた時の処理。
  void _onConfirm(BuildContext context, WidgetRef ref) async {
    try {
      // ローディング表示（必要に応じて）
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      // 進化処理を実行
      final evolutionUseCase = ref.read(evolvePokemonUseCaseProvider.notifier);
      final result = await evolutionUseCase.evolve(params.partyPokemonId);

      // ローディングを閉じる
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      if (result.success) {
        // 進化成功：進化結果画面に遷移
        if (context.mounted) {
          context.pushReplacement('/evolution-result', extra: {
            'beforePokemon': params.beforePokemon,
            'afterPokemon': params.afterPokemon,
            'message': result.message,
          });
        }
      } else {
        // 進化失敗：エラーメッセージを表示
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result.message),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      }
    } catch (error) {
      // ローディングを閉じる
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // エラーメッセージを表示
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('進化処理中にエラーが発生しました: $error'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}

/// 進化前後のポケモン比較表示用のWidgetクラス
class _PokemonCompareView extends StatelessWidget {
  const _PokemonCompareView({
    required this.beforePokemon,
    required this.afterPokemon,
  });

  /// 進化前のポケモン
  final Pokemon beforePokemon;

  /// 進化後のポケモン
  final Pokemon afterPokemon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PokemonInfoView(
          name: beforePokemon.displayName,
          pokedexNumber: beforePokemon.formattedPokedexNumber,
          type1: '？', // TODO: 実際のタイプ情報を取得
          type2: null,
        ),
        const SizedBox(width: DsSpacing.l),
        const Icon(
          Icons.arrow_forward,
          size: DsDimension.iconSizeL,
        ),
        const SizedBox(width: DsSpacing.l),
        PokemonInfoView(
          name: afterPokemon.displayName,
          pokedexNumber: afterPokemon.formattedPokedexNumber,
          type1: '？', // TODO: 実際のタイプ情報を取得
          type2: null,
        ),
      ],
    );
  }
}

/// 進化確認画面のアクションボタン用のWidgetクラス
class _EvolutionActionButtons extends StatelessWidget {
  const _EvolutionActionButtons({
    required this.onCancel,
    required this.onConfirm,
  });

  /// キャンセルボタンタップ時のコールバック
  final VoidCallback onCancel;

  /// 承認ボタンタップ時のコールバック
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DsButton(
            onPressed: onCancel,
            label: 'キャンセル',
            type: DsButtonType.destructive,
          ),
        ),
        const SizedBox(width: DsSpacing.l),
        Expanded(
          child: DsButton(
            onPressed: onConfirm,
            label: '承認',
            type: DsButtonType.primary,
          ),
        ),
      ],
    );
  }
}
