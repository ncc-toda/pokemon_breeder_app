// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$partyListStateHash() => r'70d6d05a27d597ad807f42f5b0f6863ed6b7cc36';

/// パーティ一覧の状態を管理するクラス。
///
/// Copied from [PartyListState].
@ProviderFor(PartyListState)
final partyListStateProvider = AutoDisposeNotifierProvider<PartyListState,
    AsyncValue<List<Party>>>.internal(
  PartyListState.new,
  name: r'partyListStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$partyListStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PartyListState = AutoDisposeNotifier<AsyncValue<List<Party>>>;
String _$currentPartyStateHash() => r'1c0c1853b638d4e87ffdf810d34c51287b314955';

/// 現在選択中のパーティの状態を管理するクラス。
///
/// Copied from [CurrentPartyState].
@ProviderFor(CurrentPartyState)
final currentPartyStateProvider =
    AutoDisposeNotifierProvider<CurrentPartyState, AsyncValue<Party?>>.internal(
  CurrentPartyState.new,
  name: r'currentPartyStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentPartyStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentPartyState = AutoDisposeNotifier<AsyncValue<Party?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
