import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'pokemon.dart';

part 'pokemon_state.g.dart';

/// Pokemon 一覧の状態を管理するクラス。検索機能とフィルタリング対応。
@riverpod
class PokemonState extends _$PokemonState {
  @override
  List<Pokemon> build() {
    return _generateDummyPokemons();
  }

  /// 検索クエリに基づいてPokemonリストをフィルタリングする。
  List<Pokemon> getFilteredPokemons(String searchQuery) {
    final allPokemons = state;
    
    if (searchQuery.isEmpty) {
      return allPokemons;
    }
    
    return allPokemons.where((pokemon) => pokemon.matchesSearchQuery(searchQuery)).toList();
  }

  /// ダミーのPokemonデータを生成する。
  /// 実際の実装では、データレイヤーから取得する。
  List<Pokemon> _generateDummyPokemons() {
    return List.generate(151, (index) {
      final id = index + 1;
      return Pokemon(
        id: id,
        name: _getPokemonName(id),
        pokedexNumber: id,
        imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
      );
    });
  }

  /// ID に基づいてPokemon名を返す（ダミーデータ）。
  String _getPokemonName(int id) {
    // 有名なポケモンのサンプル名
    const pokemonNames = {
      1: 'bulbasaur',
      2: 'ivysaur', 
      3: 'venusaur',
      4: 'charmander',
      5: 'charmeleon',
      6: 'charizard',
      7: 'squirtle',
      8: 'wartortle',
      9: 'blastoise',
      10: 'caterpie',
      25: 'pikachu',
      26: 'raichu',
      39: 'jigglypuff',
      52: 'meowth',
      104: 'cubone',
      150: 'mewtwo',
      151: 'mew',
    };

    return pokemonNames[id] ?? 'pokemon-$id';
  }
}

/// 検索クエリの状態を管理するProvider。
@riverpod
class SearchQueryState extends _$SearchQueryState {
  @override
  String build() {
    return '';
  }

  /// 検索クエリを更新する。
  void updateQuery(String query) {
    state = query.trim();
  }

  /// 検索クエリをクリアする。
  void clearQuery() {
    state = '';
  }
}

/// フィルタリングされたPokemonリストを提供するProvider。
@riverpod
List<Pokemon> filteredPokemons(ref) {
  final pokemonState = ref.watch(pokemonStateProvider.notifier);
  final searchQuery = ref.watch(searchQueryStateProvider);
  
  return pokemonState.getFilteredPokemons(searchQuery);
}