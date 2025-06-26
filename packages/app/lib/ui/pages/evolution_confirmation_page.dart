import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:domain/domain.dart';
import 'package:pokemon_breeder_app/ui/features/evolution/components/pokemon_compare_view.dart';
import 'package:pokemon_breeder_app/ui/features/evolution/components/evolution_action_buttons.dart';

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
            PokemonCompareView(
              config: PokemonCompareConfig(
                beforePokemon: params.beforePokemon,
                afterPokemon: params.afterPokemon,
              ),
            ),
            const Spacer(),
            EvolutionActionButtons(
              config: EvolutionActionButtonsConfig(
                onCancel: () => context.pop(),
                onConfirm: () async {
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
                  final evolutionUseCase =
                      ref.read(evolvePokemonUseCaseProvider.notifier);
                  final result =
                      await evolutionUseCase.evolve(params.partyPokemonId);

                  // ローディングを閉じる
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }

                  result.when(
                    success: (evolutionData) {
                      // 進化成功：進化結果画面に遷移
                      if (context.mounted) {
                        context.pushReplacement('/evolution-result', extra: {
                          'beforePokemon': params.beforePokemon,
                          'afterPokemon': params.afterPokemon,
                          'message': evolutionData.message,
                        });
                      }
                    },
                    failure: (failure) {
                      // 進化失敗：エラーメッセージを表示
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(failure.message),
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                          ),
                        );
                      }
                    },
                  );
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
                },
              ),
            ),
            const SizedBox(height: DsSpacing.l),
          ],
        ),
      ),
    );
  }
}

