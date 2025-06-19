// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pokemonServiceHash() => r'74dc99abe6b1b7ae878e7123efaba417439accff';

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
String _$pokemonStateHash() => r'869465b74c4364f7e7be27bcfd995cdb6fb9e844';

/// Pokemon 一覧の状態を管理するクラス。無限スクロール対応。
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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
