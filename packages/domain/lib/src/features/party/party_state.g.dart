// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$partyListStateHash() => r'bce0d8bbc2ec3c66cc9a246f3d6d27caf32ff2ed';

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
String _$currentPartyStateHash() => r'02d05053e60dd3b60e6c924d53bd69eedda06e61';

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
