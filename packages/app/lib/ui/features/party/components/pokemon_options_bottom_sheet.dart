import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokemon_breeder_app/ui/pages/evolution_confirmation_page.dart';

/// ポケモンオプションボトムシートの設定
class PokemonOptionsConfig {
  const PokemonOptionsConfig({
    required this.pokemon,
    required this.partyPokemonId,
    required this.canEvolve,
    this.onDeleteConfirm,
  });

  /// 対象のポケモン
  final Pokemon pokemon;

  /// パーティポケモンのID
  final int partyPokemonId;

  /// 進化可能かどうか
  final bool canEvolve;

  /// 削除確認ダイアログを表示するコールバック
  final VoidCallback? onDeleteConfirm;
}

/// ポケモンの操作オプションを表示するボトムシート
class PokemonOptionsBottomSheet extends HookConsumerWidget {
  const PokemonOptionsBottomSheet({super.key, required this.config});

  /// ボトムシートの設定
  final PokemonOptionsConfig config;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('詳細を見る'),
            onTap: () {
              Navigator.pop(context);
              // TODO: ポケモン詳細画面への遷移
            },
          ),
          if (config.canEvolve)
            ListTile(
              leading: Icon(
                Icons.auto_awesome,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text(
                '進化する',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                _handleEvolution(context, ref);
              },
            ),
          ListTile(
            leading: const Icon(Icons.remove_circle),
            title: const Text('パーティから外す'),
            onTap: () {
              Navigator.pop(context);
              config.onDeleteConfirm?.call();
            },
          ),
        ],
      ),
    );
  }

  /// 進化処理を実行する
  void _handleEvolution(BuildContext context, WidgetRef ref) {
    // 進化先のポケモンIDを取得
    final evolutionTargetId =
        EvolutionDataHelper.getEvolutionTarget(config.pokemon.id);
    if (evolutionTargetId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('進化先のポケモンが見つかりません'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // 進化先のポケモンデータを取得
    final allPokemonsAsync = ref.read(pokemonStateProvider);
    final allPokemons = allPokemonsAsync.valueOrNull ?? [];
    final afterPokemon =
        allPokemons.where((p) => p.id == evolutionTargetId).firstOrNull;

    if (afterPokemon == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('進化先のポケモンデータが見つかりません'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // 進化確認画面に遷移
    final params = EvolutionConfirmationParams(
      partyPokemonId: config.partyPokemonId,
      beforePokemon: config.pokemon,
      afterPokemon: afterPokemon,
    );

    context.push('/evolution-confirmation', extra: params);
  }
}
