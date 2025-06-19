import 'package:design_system/design_system.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PokedexPage extends HookConsumerWidget {
  const PokedexPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(searchQueryStateProvider);
    final searchController = useTextEditingController(text: searchQuery);
    final filteredPokemons = ref.watch(filteredPokemonsProvider);

    return DsScaffold(
      topBarContent: DsTopBar(
        content: const Text('ポケモン図鑑'),
      ),
      body: Column(
        children: [
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
          if (searchQuery.isNotEmpty)
            Padding(
              padding: DsPadding.horizontalS,
              child: DsSearchResultInfo(
                resultCount: filteredPokemons.length,
                query: searchQuery,
              ),
            ),
          _buildFilterBar(),
          Expanded(
            child: searchQuery.isNotEmpty && filteredPokemons.isEmpty
                ? DsSearchEmptyState(query: searchQuery)
                : _buildPokedexGrid(filteredPokemons),
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
            onSelected: (selected) {},
          ),
          DsChoiceChip(
            label: 'ジョウト',
            selected: false,
            onSelected: (selected) {},
          ),
          DsChoiceChip(
            label: 'ホウエン',
            selected: false,
            onSelected: (selected) {},
          ),
          // 他の世代も同様に追加
        ],
      ),
    );
  }

  Widget _buildPokedexGrid(List<Pokemon> pokemons) {
    return GridView.builder(
      padding: DsPadding.allS,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: DsSpacing.s,
        mainAxisSpacing: DsSpacing.s,
      ),
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        final pokemon = pokemons[index];
        final pokedexNumber = pokemon.pokedexNumber.toString().padLeft(3, '0');
        return _PokedexCell(
          pokemon: pokemon,
          pokedexNumber: pokedexNumber,
          isDiscovered: index % 5 != 0, // ダミーの発見状態
        );
      },
    );
  }
}

class _PokedexCell extends StatelessWidget {
  const _PokedexCell({
    required this.pokemon,
    required this.pokedexNumber,
    required this.isDiscovered,
  });

  final Pokemon pokemon;
  final String pokedexNumber;
  final bool isDiscovered;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DsRadius.m),
      ),
      child: Padding(
        padding: DsPadding.allXs,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No.$pokedexNumber',
              style: DsTypography.labelSmall.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: DsSpacing.xs),
            Expanded(
              child: Placeholder(
                color: isDiscovered
                    ? Theme.of(context).colorScheme.primary
                    : Colors.black,
              ),
            ),
            const SizedBox(height: DsSpacing.xs),
            Text(
              pokemon.name,
              style: DsTypography.labelSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
