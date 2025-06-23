import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:domain/domain.dart';
import 'package:pokemon_breeder_app/widgets/pokemon_info_view.dart';

/// 進化結果画面のパラメータ。
class EvolutionResultParams {
  const EvolutionResultParams({
    required this.beforePokemon,
    required this.afterPokemon,
    required this.message,
  });

  /// 進化前のポケモン
  final Pokemon beforePokemon;

  /// 進化後のポケモン
  final Pokemon afterPokemon;

  /// 結果メッセージ
  final String message;
}

class EvolutionResultPage extends HookConsumerWidget {
  const EvolutionResultPage({
    super.key,
    required this.params,
  });

  final EvolutionResultParams params;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DsScaffold(
      topBarContent: const DsTopBar(
        content: Text('進化結果'),
      ),
      body: Padding(
        padding: DsPadding.allL,
        child: Column(
          children: [
            const Spacer(),
            Text(
              'おめでとう！\n${params.beforePokemon.displayName}は ${params.afterPokemon.displayName} に進化した！',
              style: DsTypography.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: DsSpacing.xl),
            _buildPokemonInfoView(),
            const Spacer(),
            _buildActionButtons(context, ref),
            const SizedBox(height: DsSpacing.l),
          ],
        ),
      ),
    );
  }

  Widget _buildPokemonInfoView() {
    return PokemonInfoView(
      name: params.afterPokemon.displayName,
      pokedexNumber: params.afterPokemon.formattedPokedexNumber,
      type1: '？', // TODO: 実際のタイプ情報を取得
      type2: null,
    );
  }

  Widget _buildActionButtons(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: DsButton(
        onPressed: () => _onReturnToParty(context, ref),
        label: 'パーティを確認する',
        type: DsButtonType.primary,
      ),
    );
  }

  /// パーティ画面に戻る処理。
  void _onReturnToParty(BuildContext context, WidgetRef ref) {
    // パーティ画面の状態を更新するため、currentPartyStateProviderを更新
    ref.read(currentPartyStateProvider.notifier).reload();

    // パーティ画面に戻る
    context.go('/party');
  }
}
