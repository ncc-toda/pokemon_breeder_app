import 'package:data/src/services/local_storage/local_database_provider.dart';
import 'package:data/src/services/party/party_service.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'party.dart';
import 'party_pokemon.dart';

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

  /// パーティの6スロット情報を取得する（育成カウンター情報を含む）。
  Future<List<PartySlot>> getPartySlots() async {
    final currentParty = state.valueOrNull;
    if (currentParty == null) {
      return List.generate(6, (index) => PartySlot.empty(position: index));
    }

    try {
      final database = ref.read(localDatabaseProvider);
      final partyPokemons = await database.getPartyPokemons(currentParty.id);
      
      final slots = <PartySlot>[];
      
      // パーティポケモンをposition順にソート
      partyPokemons.sort((a, b) => a.position.compareTo(b.position));
      
      // 埋まっているスロット
      for (final partyPokemon in partyPokemons) {
        slots.add(PartySlot.filled(
          partyPokemonId: partyPokemon.id,
          pokemonId: partyPokemon.pokemonId,
          position: partyPokemon.position,
          breedingCounter: partyPokemon.breedingCounter,
        ));
      }
      
      // 空のスロット
      for (int i = partyPokemons.length; i < 6; i++) {
        slots.add(PartySlot.empty(position: i));
      }
      
      return slots;
    } catch (error) {
      debugPrint('Failed to get party slots: $error');
      return List.generate(6, (index) => PartySlot.empty(position: index));
    }
  }

  /// 育成カウンターを増加させる。
  Future<void> incrementBreedingCounter(int partyPokemonId) async {
    try {
      final database = ref.read(localDatabaseProvider);
      final partyPokemon = (await database.select(database.partyPokemons)
            ..where((tbl) => tbl.id.equals(partyPokemonId)))
          .getSingleOrNull();
      
      if (partyPokemon != null) {
        await database.updateBreedingCounter(
          partyPokemonId,
          partyPokemon.breedingCounter + 1,
        );
      }
    } catch (error, stackTrace) {
      debugPrint('Failed to increment breeding counter: $error');
    }
  }

  /// 育成カウンターを減少させる。
  Future<void> decrementBreedingCounter(int partyPokemonId) async {
    try {
      final database = ref.read(localDatabaseProvider);
      final partyPokemon = (await database.select(database.partyPokemons)
            ..where((tbl) => tbl.id.equals(partyPokemonId)))
          .getSingleOrNull();
      
      if (partyPokemon != null && partyPokemon.breedingCounter > 0) {
        await database.updateBreedingCounter(
          partyPokemonId,
          partyPokemon.breedingCounter - 1,
        );
      }
    } catch (error, stackTrace) {
      debugPrint('Failed to decrement breeding counter: $error');
    }
  }

  /// 育成カウンターをリセットする。
  Future<void> resetBreedingCounter(int partyPokemonId) async {
    try {
      final database = ref.read(localDatabaseProvider);
      await database.updateBreedingCounter(partyPokemonId, 0);
    } catch (error, stackTrace) {
      debugPrint('Failed to reset breeding counter: $error');
    }
  }

  /// 育成カウンターを指定値に設定する。
  Future<void> setBreedingCounter(int partyPokemonId, int value) async {
    try {
      final database = ref.read(localDatabaseProvider);
      await database.updateBreedingCounter(partyPokemonId, value < 0 ? 0 : value);
    } catch (error, stackTrace) {
      debugPrint('Failed to set breeding counter: $error');
    }
  }

  /// 現在のパーティを再読み込みする。
  Future<void> reload() async {
    state = const AsyncValue.loading();
    await _loadCurrentParty();
  }
}