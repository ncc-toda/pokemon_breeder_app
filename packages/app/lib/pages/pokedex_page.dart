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
    final pokemonAsyncValue = ref.watch(pokemonStateProvider);
    final pokemonState = ref.watch(pokemonStateProvider.notifier);
    final scrollController = useScrollController();
    final isLoadingMore = useState(false);

    // 初回読み込み
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        pokemonState.fetchInitialPokemons();
      });
      return null;
    }, []);

    // 無限スクロールの実装
    useEffect(() {
      void onScroll() {
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
    }, [scrollController, pokemonAsyncValue]);

    return DsScaffold(
      topBarContent: DsTopBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('ポケモン図鑑'),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // TODO(tetsu): 検索処理
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          _buildFilterBar(),
          Expanded(
            child: pokemonAsyncValue.when(
              data: (pokemons) => _buildPokemonList(
                pokemons: pokemons,
                scrollController: scrollController,
                isLoadingMore: isLoadingMore.value,
              ),
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
  }) {
    if (pokemons.isEmpty) {
      return const Center(
        child: Text('ポケモンが見つかりませんでした'),
      );
    }

    return ListView.builder(
      controller: scrollController,
      padding: DsPadding.allS,
      itemCount: pokemons.length + (isLoadingMore ? 1 : 0),
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

class _PokemonListItem extends StatelessWidget {
  const _PokemonListItem({required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
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
        trailing: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            // TODO(tetsu): パーティに追加する処理
          },
        ),
        onTap: () {
          // TODO(tetsu): Pokemon詳細画面への遷移
        },
      ),
    );
  }
}