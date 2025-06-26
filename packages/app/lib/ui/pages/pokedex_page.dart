import 'package:design_system/design_system.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pokemon_breeder_app/ui/features/pokedex/components/pokemon_filter_bar.dart';
import 'package:pokemon_breeder_app/ui/features/pokedex/components/pokemon_list_view.dart';

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
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final result = await pokemonState.fetchInitialPokemons();
        result.when(
          success: (_) => {}, // 成功時は特に何もしない
          failure: (failure) {
            debugPrint('Initial pokemon fetch failed: ${failure.message}');
          },
        );
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
            pokemonState.fetchNextPage().then((result) {
              isLoadingMore.value = false;
              result.when(
                success: (_) => {}, // 成功時は特に何もしない
                failure: (failure) {
                  debugPrint('Error loading more pokemons: ${failure.message}');
                },
              );
            }).catchError((error) {
              isLoadingMore.value = false;
              debugPrint('Unexpected error during fetch next page: $error');
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
          const PokemonFilterBar(),

          // ポケモンリスト
          Expanded(
            child: pokemonAsyncValue.when(
              data: (pokemons) {
                // 検索結果が空の場合の処理
                if (searchQuery.isNotEmpty && filteredPokemons.isEmpty) {
                  return DsSearchEmptyState(
                    query: searchQuery,
                    emptyMessage: '"$searchQuery" に一致するポケモンが見つかりませんでした',
                  );
                }

                return PokemonListView(
                  config: PokemonListViewConfig(
                    pokemons:
                        searchQuery.isNotEmpty ? filteredPokemons : pokemons,
                    scrollController: scrollController,
                    isLoadingMore: isLoadingMore.value,
                    showLoadingMore: searchQuery.isEmpty, // 検索中は追加読み込み表示しない
                  ),
                );
              },
              loading: () => const _PokemonListShimmer(),
              error: (error, stackTrace) => _PokemonListErrorView(
                error: error,
                onRetry: () async {
                  final result = await pokemonState.retry();
                  result.when(
                    success: (_) => {}, // 成功時は特に何もしない
                    failure: (failure) {
                      debugPrint('Retry failed: ${failure.message}');
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Shimmerローディング表示用のWidgetクラス
class _PokemonListShimmer extends StatelessWidget {
  const _PokemonListShimmer();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: DsPadding.allS,
      itemCount: 10, // 初期表示用のShimmerアイテム数
      itemBuilder: (context, index) {
        return const DsListItemShimmer();
      },
    );
  }
}

/// エラー表示用のWidgetクラス
class _PokemonListErrorView extends StatelessWidget {
  const _PokemonListErrorView({
    required this.error,
    required this.onRetry,
  });

  /// 表示するエラー
  final Object error;

  /// 再試行ボタンタップ時のコールバック
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}
