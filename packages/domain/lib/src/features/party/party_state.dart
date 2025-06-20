import 'package:data/src/services/party/party_service.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'party.dart';

part 'party_state.g.dart';

/// パーティ一覧の状態を管理するクラス。
@riverpod
class PartyListState extends _$PartyListState {
  @override
  AsyncValue<List<Party>> build() {
    _loadParties();
    return const AsyncValue.loading();
  }

  /// パーティ一覧を読み込む。
  Future<void> _loadParties() async {
    try {
      final partyService = ref.read(partyServiceProvider);
      final parties = await partyService.getAllParties();
      state = AsyncValue.data(parties);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      debugPrint('Failed to load parties: $error');
    }
  }

  /// パーティ一覧を再読み込みする。
  Future<void> reload() async {
    state = const AsyncValue.loading();
    await _loadParties();
  }

  /// 新しいパーティを作成する。
  Future<void> createParty(String name) async {
    try {
      final partyService = ref.read(partyServiceProvider);
      await partyService.createParty(name);
      await _loadParties();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      debugPrint('Failed to create party: $error');
    }
  }

  /// パーティを削除する。
  Future<void> deleteParty(int partyId) async {
    try {
      final partyService = ref.read(partyServiceProvider);
      await partyService.deleteParty(partyId);
      await _loadParties();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      debugPrint('Failed to delete party: $error');
    }
  }
}

/// 現在選択中のパーティの状態を管理するクラス。
@riverpod
class CurrentPartyState extends _$CurrentPartyState {
  @override
  AsyncValue<Party?> build() {
    _loadCurrentParty();
    return const AsyncValue.loading();
  }

  /// 現在のパーティを読み込む。最初のパーティを選択する。
  Future<void> _loadCurrentParty() async {
    try {
      final partyService = ref.read(partyServiceProvider);
      final parties = await partyService.getAllParties();
      
      if (parties.isNotEmpty) {
        state = AsyncValue.data(parties.first);
      } else {
        // パーティが存在しない場合はデフォルトパーティを作成
        await partyService.createParty('マイパーティ');
        final newParties = await partyService.getAllParties();
        state = AsyncValue.data(newParties.first);
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      debugPrint('Failed to load current party: $error');
    }
  }

  /// パーティを選択する。
  Future<void> selectParty(int partyId) async {
    try {
      final partyService = ref.read(partyServiceProvider);
      final party = await partyService.getPartyById(partyId);
      if (party != null) {
        state = AsyncValue.data(party);
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      debugPrint('Failed to select party: $error');
    }
  }

  /// パーティにポケモンを追加する。
  Future<void> addPokemonToParty(int pokemonId) async {
    final currentParty = state.valueOrNull;
    if (currentParty == null) return;

    try {
      final partyService = ref.read(partyServiceProvider);
      final updatedParty = currentParty.addPokemon(pokemonId);
      await partyService.updateParty(updatedParty);
      state = AsyncValue.data(updatedParty);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      debugPrint('Failed to add pokemon to party: $error');
    }
  }

  /// パーティからポケモンを削除する。
  Future<void> removePokemonFromParty(int pokemonId) async {
    final currentParty = state.valueOrNull;
    if (currentParty == null) return;

    try {
      final partyService = ref.read(partyServiceProvider);
      final updatedParty = currentParty.removePokemon(pokemonId);
      await partyService.updateParty(updatedParty);
      state = AsyncValue.data(updatedParty);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      debugPrint('Failed to remove pokemon from party: $error');
    }
  }

  /// パーティの6スロット情報を取得する。
  List<PartySlot> getPartySlots() {
    final currentParty = state.valueOrNull;
    if (currentParty == null) {
      return List.generate(6, (index) => PartySlot.empty(position: index));
    }

    final slots = <PartySlot>[];
    
    // 埋まっているスロット
    for (int i = 0; i < currentParty.pokemonIds.length; i++) {
      slots.add(PartySlot.filled(
        pokemonId: currentParty.pokemonIds[i],
        position: i,
      ));
    }
    
    // 空のスロット
    for (int i = currentParty.pokemonIds.length; i < 6; i++) {
      slots.add(PartySlot.empty(position: i));
    }
    
    return slots;
  }

  /// 現在のパーティを再読み込みする。
  Future<void> reload() async {
    state = const AsyncValue.loading();
    await _loadCurrentParty();
  }
}