import 'package:cached_network_image/cached_network_image.dart';
import 'package:design_system/design_system.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// ポケモンリスト表示の設定を保持するクラス
class PokemonListViewConfig {
  const PokemonListViewConfig({
    required this.pokemons,
    required this.scrollController,
    required this.isLoadingMore,
    required this.showLoadingMore,
  });

  /// 表示するポケモンのリスト
  final List<Pokemon> pokemons;

  /// スクロール制御用のコントローラー
  final ScrollController scrollController;

  /// 追加読み込み中かどうか
  final bool isLoadingMore;

  /// 追加読み込みインジケーターを表示するかどうか
  final bool showLoadingMore;
}

/// ポケモンリスト表示用のWidget
class PokemonListView extends StatelessWidget {
  const PokemonListView({super.key, required this.config});

  /// リスト表示の設定
  final PokemonListViewConfig config;

  @override
  Widget build(BuildContext context) {
    if (config.pokemons.isEmpty) {
      return const Center(
        child: Text('ポケモンが見つかりませんでした'),
      );
    }

    return ListView.builder(
      controller: config.scrollController,
      padding: DsPadding.allS,
      itemCount: config.pokemons.length +
          (config.isLoadingMore && config.showLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= config.pokemons.length) {
          // ローディングインジケーター
          return const Padding(
            padding: DsPadding.allM,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final pokemon = config.pokemons[index];
        return _PokemonListItem(pokemon: pokemon);
      },
    );
  }
}

class _PokemonListItem extends ConsumerWidget {
  const _PokemonListItem({required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: DsSpacing.s),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DsRadius.m),
      ),
      child: ListTile(
        leading: SizedBox(
          width: 64,
          height: 64,
          child: CachedNetworkImage(
            imageUrl: pokemon.imageUrl,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Container(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Icon(
                Icons.image_not_supported,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
          pokemon.displayName,
          style: DsTypography.titleMedium,
        ),
        subtitle: Text(
          pokemon.formattedPokedexNumber,
          style: DsTypography.bodySmall.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        trailing: Consumer(
          builder: (context, ref, child) {
            final currentPartyAsync = ref.watch(currentPartyStateProvider);
            final currentParty = currentPartyAsync.valueOrNull;

            // パーティが満席かどうか、または既に追加済みかをチェック
            final isAlreadyAdded =
                currentParty?.pokemonIds.contains(pokemon.id) ?? false;
            final isPartyFull = currentParty?.isFull ?? false;

            return IconButton(
              icon: Icon(
                isAlreadyAdded ? Icons.check : Icons.add,
                color: isAlreadyAdded
                    ? Theme.of(context).colorScheme.primary
                    : null,
              ),
              onPressed: (isAlreadyAdded || isPartyFull)
                  ? null
                  : () async {
                      final result = await ref
                          .read(currentPartyStateProvider.notifier)
                          .addPokemonToParty(pokemon.id);

                      result.when(
                        success: (updatedParty) {
                          // スナックバーで成功メッセージを表示
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('${pokemon.displayName} をパーティに追加しました'),
                              duration: const Duration(seconds: 2),
                              action: SnackBarAction(
                                label: '取り消し',
                                onPressed: () async {
                                  final removeResult = await ref
                                      .read(currentPartyStateProvider.notifier)
                                      .removePokemonFromParty(pokemon.id);
                                  removeResult.when(
                                    success: (_) => {},
                                    failure: (failure) {
                                      debugPrint(
                                          'Failed to remove pokemon: ${failure.message}');
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        },
                        failure: (failure) {
                          // エラーメッセージを表示
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('エラー: ${failure.message}'),
                              backgroundColor:
                                  Theme.of(context).colorScheme.error,
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        },
                      );
                    },
              tooltip: isAlreadyAdded
                  ? 'パーティに追加済み'
                  : isPartyFull
                      ? 'パーティが満席です'
                      : 'パーティに追加',
            );
          },
        ),
        onTap: () {
          // TODO(tetsu): Pokemon詳細画面への遷移
        },
      ),
    );
  }
}
