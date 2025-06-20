// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pokemonServiceHash() => r'e307b4e6755a321231fe0a2aca010bfa846c4510';

/// PokemonService の Provider を定義。
///
/// Copied from [pokemonService].
@ProviderFor(pokemonService)
final pokemonServiceProvider = AutoDisposeProvider<PokemonService>.internal(
  pokemonService,
  name: r'pokemonServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pokemonServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PokemonServiceRef = AutoDisposeProviderRef<PokemonService>;
String _$pokemonStateHash() => r'509d51630b1a7e8a3676fc0c098234e31a756f43';

/// Pokemon 一覧の状態を管理するクラス。無限スクロール対応。
///
/// Copied from [PokemonState].
@ProviderFor(PokemonState)
final pokemonStateProvider = AutoDisposeNotifierProvider<PokemonState,
    AsyncValue<List<Pokemon>>>.internal(
  PokemonState.new,
  name: r'pokemonStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$pokemonStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PokemonState = AutoDisposeNotifier<AsyncValue<List<Pokemon>>>;
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
