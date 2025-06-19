// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$filteredPokemonsHash() => r'48e961f502fd93833551bedbf766d3ddd27d5022';

/// フィルタリングされたPokemonリストを提供するProvider。
///
/// Copied from [filteredPokemons].
@ProviderFor(filteredPokemons)
final filteredPokemonsProvider = AutoDisposeProvider<List<Pokemon>>.internal(
  filteredPokemons,
  name: r'filteredPokemonsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredPokemonsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredPokemonsRef = AutoDisposeProviderRef<List<Pokemon>>;
String _$pokemonStateHash() => r'4ca2bca44327423093e625f2551bf2d8be2e5391';

/// Pokemon 一覧の状態を管理するクラス。検索機能とフィルタリング対応。
///
/// Copied from [PokemonState].
@ProviderFor(PokemonState)
final pokemonStateProvider =
    AutoDisposeNotifierProvider<PokemonState, List<Pokemon>>.internal(
  PokemonState.new,
  name: r'pokemonStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$pokemonStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PokemonState = AutoDisposeNotifier<List<Pokemon>>;
String _$searchQueryStateHash() => r'ba3fbaddcb960af844979c964d25aa9f53da96b3';

/// 検索クエリの状態を管理するProvider。
///
/// Copied from [SearchQueryState].
@ProviderFor(SearchQueryState)
final searchQueryStateProvider =
    AutoDisposeNotifierProvider<SearchQueryState, String>.internal(
  SearchQueryState.new,
  name: r'searchQueryStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$searchQueryStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SearchQueryState = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
