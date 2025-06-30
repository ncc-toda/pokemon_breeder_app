import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:domain/domain.dart';
import 'package:pokemon_breeder_app/ui/features/evolution/components/pokemon_compare_view.dart';
import 'package:pokemon_breeder_app/ui/features/evolution/components/evolution_action_buttons.dart';

/// 進化・退化確認画面のパラメータ。
class EvolutionConfirmationParams {
  const EvolutionConfirmationParams({
    required this.partyPokemonId,
    required this.beforePokemon,
    required this.afterPokemon,
    this.isEvolution = true,
  });

  /// パーティポケモンのID
  final int partyPokemonId;

  /// 変化前のポケモン
  final Pokemon beforePokemon;

  /// 変化後のポケモン
  final Pokemon afterPokemon;

  /// 進化かどうか（true: 進化、false: 退化）
  final bool isEvolution;
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
      topBarContent: DsTopBar(
        content: Text(params.isEvolution ? '進化確認' : '退化確認'),
      ),
      body: Padding(
        padding: DsPadding.allL,
        child: Column(
          children: [
            const Spacer(),
            Text(
              params.isEvolution
                  ? '${params.beforePokemon.displayName}は ${params.afterPokemon.displayName} に進化します。\nよろしいですか？'
                  : '${params.beforePokemon.displayName}は ${params.afterPokemon.displayName} に退化します。\nよろしいですか？',
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

                    // 進化・退化処理を実行
                    final evolutionUseCase =
                        ref.read(evolvePokemonUseCaseProvider);
                    final result = params.isEvolution
                        ? await evolutionUseCase.evolve(params.partyPokemonId)
                        : await evolutionUseCase.devolve(params.partyPokemonId);

                    // ローディングを閉じる
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }

                    result.when(
                      success: (evolutionData) {
                        // 処理成功：結果画面に遷移
                        if (context.mounted) {
                          context.pushReplacement('/evolution-result', extra: {
                            'beforePokemon': params.beforePokemon,
                            'afterPokemon': params.afterPokemon,
                            'message': evolutionData.message,
                            'isEvolution': params.isEvolution,
                          });
                        }
                      },
                      failure: (failure) {
                        // 処理失敗：エラーメッセージを表示
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
                          content: Text('処理中にエラーが発生しました: $error'),
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
