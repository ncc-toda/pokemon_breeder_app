import 'package:cached_network_image/cached_network_image.dart';
import 'package:design_system/design_system.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PokedexPage extends HookConsumerWidget {
  const PokedexPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // API データ関連の状態
    final pokemonAsyncValue = ref.watch(pokemonStateProvider);
    final pokemonState = ref.watch(pokemonStateProvider.notifier);

    // 検索機能関連の状態
    final searchQuery = ref.watch(searchQueryStateProvider);
    final searchController = useTextEditingController(text: searchQuery);

    // 無限スクロール関連の状態
    final scrollController = useScrollController();
    final isLoadingMore = useState(false);

    // フィルタリングされたポケモンリスト
    final filteredPokemons = useMemoized(() {
      final allPokemons = pokemonAsyncValue.valueOrNull ?? [];
      if (searchQuery.isEmpty) {
        return allPokemons;
      }
      return allPokemons
          .where((pokemon) => pokemon.matchesSearchQuery(searchQuery))
          .toList();
    }, [pokemonAsyncValue, searchQuery]);

    // 初回読み込み
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        pokemonState.fetchInitialPokemons();
      });
      return null;
    }, []);

    // 無限スクロールの実装（検索中は無効化）
    useEffect(() {
      void onScroll() {
        if (searchQuery.isNotEmpty) return; // 検索中は無限スクロール無効

        final pokemons = pokemonAsyncValue.valueOrNull;
        if (pokemons == null || pokemons.isEmpty) return;

        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200) {
          if (!isLoadingMore.value && pokemonAsyncValue.hasValue) {
            isLoadingMore.value = true;
            pokemonState.fetchNextPage().then((_) {
              isLoadingMore.value = false;
            }).catchError((error) {
              isLoadingMore.value = false;
              debugPrint('Error loading more pokemons: $error');
            });
          }
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController, pokemonAsyncValue, searchQuery]);

    return DsScaffold(
      topBarContent: DsTopBar(
        content: const Text('ポケモン図鑑'),
      ),
      body: Column(
        children: [
          // 検索バー
          Padding(
            padding: DsPadding.allS,
            child: DsSearchBar(
              controller: searchController,
              hintText: 'ポケモン名または図鑑番号で検索',
              onChanged: (query) {
                ref.read(searchQueryStateProvider.notifier).updateQuery(query);
              },
              onClear: () {
                searchController.clear();
                ref.read(searchQueryStateProvider.notifier).updateQuery('');
              },
            ),
          ),

          // 検索結果情報
          if (searchQuery.isNotEmpty)
            Padding(
              padding: DsPadding.horizontalS,
              child: DsSearchResultInfo(
                resultCount: filteredPokemons.length,
                query: searchQuery,
              ),
            ),

          // フィルターバー
          _buildFilterBar(),

          // ポケモンリスト
          Expanded(
            child: pokemonAsyncValue.when(
              data: (pokemons) {
                // 検索結果が空の場合の処理
                if (searchQuery.isNotEmpty && filteredPokemons.isEmpty) {
                  return DsSearchEmptyState(query: searchQuery);
                }

                return _buildPokemonList(
                  pokemons:
                      searchQuery.isNotEmpty ? filteredPokemons : pokemons,
                  scrollController: scrollController,
                  isLoadingMore: isLoadingMore.value,
                  showLoadingMore: searchQuery.isEmpty, // 検索中は追加読み込み表示しない
                );
              },
              loading: () => _buildShimmerList(),
              error: (error, stackTrace) => _buildErrorView(
                error: error,
                onRetry: () => pokemonState.retry(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
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

  Widget _buildPokemonList({
    required List<Pokemon> pokemons,
    required ScrollController scrollController,
    required bool isLoadingMore,
    required bool showLoadingMore,
  }) {
    if (pokemons.isEmpty) {
      return const Center(
        child: Text('ポケモンが見つかりませんでした'),
      );
    }

    return ListView.builder(
      controller: scrollController,
      padding: DsPadding.allS,
      itemCount: pokemons.length + (isLoadingMore && showLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= pokemons.length) {
          // ローディングインジケーター
          return const Padding(
            padding: DsPadding.allM,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final pokemon = pokemons[index];
        return _PokemonListItem(pokemon: pokemon);
      },
    );
  }

  /// Shimmerローディング表示を構築する。
  Widget _buildShimmerList() {
    return ListView.builder(
      padding: DsPadding.allS,
      itemCount: 10, // 初期表示用のShimmerアイテム数
      itemBuilder: (context, index) {
        return const DsPokemonListShimmer();
      },
    );
  }

  /// エラー表示を構築する。
  Widget _buildErrorView({
    required Object error,
    required VoidCallback onRetry,
  }) {
    return Builder(
      builder: (context) => Center(
        child: Padding(
          padding: DsPadding.allM,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: DsSpacing.m),
              Text(
                'データの読み込みに失敗しました',
                style: DsTypography.titleMedium.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DsSpacing.s),
              Text(
                error.toString().replaceFirst('Exception: ', ''),
                style: DsTypography.bodySmall.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DsSpacing.l),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('再試行'),
              ),
            ],
          ),
        ),
      ),
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
                  : () {
                      _addToParty(context, ref, pokemon);
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

  /// ポケモンをパーティに追加する。
  void _addToParty(BuildContext context, WidgetRef ref, Pokemon pokemon) {
    ref.read(currentPartyStateProvider.notifier).addPokemonToParty(pokemon.id);

    // スナックバーで成功メッセージを表示
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${pokemon.displayName} をパーティに追加しました'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: '取り消し',
          onPressed: () {
            ref
                .read(currentPartyStateProvider.notifier)
                .removePokemonFromParty(pokemon.id);
          },
        ),
      ),
    );
  }
}
