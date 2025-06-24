import 'package:data/src/services/local_storage/database.dart' as db;
import 'package:data/src/services/local_storage/local_database_provider.dart';
import 'package:data/src/services/party/party_service.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/core.dart';
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

  /// パーティ一覧を読み込んでResult型で返す。
  Future<Result<List<Party>, DomainFailure>> _loadPartiesWithResult() async {
    try {
      final partyService = ref.read(partyServiceProvider);
      final parties = await partyService.getAllParties();
      state = AsyncValue.data(parties);
      return Success(parties);
    } catch (error, stackTrace) {
      final failure = DomainFailure.dataFetchFailed(
        message: 'パーティ一覧の取得に失敗しました',
        cause: error,
      );
      state = AsyncValue.error(error, stackTrace);
      debugPrint('Failed to load parties: $error');
      return Failure(failure);
    }
  }

  /// パーティ一覧を再読み込みする。
  Future<Result<List<Party>, DomainFailure>> reload() async {
    state = const AsyncValue.loading();
    return await _loadPartiesWithResult();
  }

  /// 新しいパーティを作成する。
  Future<Result<Party, DomainFailure>> createParty(String name) async {
    try {
      final partyService = ref.read(partyServiceProvider);
      await partyService.createParty(name);
      final result = await _loadPartiesWithResult();
      return result.when(
        success: (parties) {
          final newParty = parties.firstWhere(
            (p) => p.name == name,
            orElse: () => parties.last,
          );
          return Success(newParty);
        },
        failure: (failure) => Failure(failure),
      );
    } catch (error, stackTrace) {
      final failure = DomainFailure.dataSaveFailed(
        message: 'パーティの作成に失敗しました',
        cause: error,
      );
      state = AsyncValue.error(error, stackTrace);
      debugPrint('Failed to create party: $error');
      return Failure(failure);
    }
  }

  /// パーティを削除する。
  Future<Result<void, DomainFailure>> deleteParty(int partyId) async {
    try {
      final partyService = ref.read(partyServiceProvider);
      await partyService.deleteParty(partyId);
      await _loadParties();
      return const Success(null);
    } catch (error, stackTrace) {
      final failure = DomainFailure.dataDeleteFailed(
        message: 'パーティの削除に失敗しました',
        cause: error,
      );
      state = AsyncValue.error(error, stackTrace);
      debugPrint('Failed to delete party: $error');
      return Failure(failure);
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

  /// 現在のパーティを読み込んでResult型で返す。
  Future<Result<Party?, DomainFailure>> _loadCurrentPartyWithResult() async {
    try {
      final partyService = ref.read(partyServiceProvider);
      final parties = await partyService.getAllParties();

      if (parties.isNotEmpty) {
        state = AsyncValue.data(parties.first);
        return Success(parties.first);
      } else {
        // パーティが存在しない場合はデフォルトパーティを作成
        await partyService.createParty('マイパーティ');
        final newParties = await partyService.getAllParties();
        if (newParties.isNotEmpty) {
          state = AsyncValue.data(newParties.first);
          return Success(newParties.first);
        } else {
          final failure = DomainFailure.unexpected(
            message: 'デフォルトパーティの作成に失敗しました',
          );
          return Failure(failure);
        }
      }
    } catch (error, stackTrace) {
      final failure = DomainFailure.dataFetchFailed(
        message: '現在のパーティの取得に失敗しました',
        cause: error,
      );
      state = AsyncValue.error(error, stackTrace);
      debugPrint('Failed to load current party: $error');
      return Failure(failure);
    }
  }

  /// パーティを選択する。
  Future<Result<Party, DomainFailure>> selectParty(int partyId) async {
    try {
      final partyService = ref.read(partyServiceProvider);
      final party = await partyService.getPartyById(partyId);
      if (party != null) {
        state = AsyncValue.data(party);
        return Success(party);
      } else {
        final failure = DomainFailure.notFound(
          message: '指定されたパーティが見つかりません',
        );
        return Failure(failure);
      }
    } catch (error, stackTrace) {
      final failure = DomainFailure.dataFetchFailed(
        message: 'パーティの選択に失敗しました',
        cause: error,
      );
      state = AsyncValue.error(error, stackTrace);
      debugPrint('Failed to select party: $error');
      return Failure(failure);
    }
  }

  /// パーティにポケモンを追加する。
  Future<Result<Party, DomainFailure>> addPokemonToParty(int pokemonId) async {
    final currentParty = state.valueOrNull;
    if (currentParty == null) {
      final failure = DomainFailure.notFound(
        message: '選択されたパーティが見つかりません',
      );
      return Failure(failure);
    }

    try {
      final partyService = ref.read(partyServiceProvider);
      final database = ref.read(localDatabaseProvider);
      
      final updatedParty = currentParty.addPokemon(pokemonId);
      await partyService.updateParty(updatedParty);
      
      // partyPokemonsテーブルにも同期
      final position = updatedParty.pokemonIds.length - 1; // 最後に追加された位置
      
      await database.insertPartyPokemon(
        db.PartyPokemonsCompanion.insert(
          partyId: currentParty.id,
          pokemonId: pokemonId,
          position: position,
          breedingCounter: const Value(0),
        ),
      );
      
      state = AsyncValue.data(updatedParty);
      return Success(updatedParty);
    } catch (error, stackTrace) {
      final failure = DomainFailure.dataSaveFailed(
        message: 'パーティへのポケモン追加に失敗しました',
        cause: error,
      );
      state = AsyncValue.error(error, stackTrace);
      debugPrint('Failed to add pokemon to party: $error');
      return Failure(failure);
    }
  }

  /// パーティからポケモンを削除する。
  Future<Result<Party, DomainFailure>> removePokemonFromParty(int pokemonId) async {
    final currentParty = state.valueOrNull;
    if (currentParty == null) {
      final failure = DomainFailure.notFound(
        message: '選択されたパーティが見つかりません',
      );
      return Failure(failure);
    }

    try {
      final partyService = ref.read(partyServiceProvider);
      final database = ref.read(localDatabaseProvider);
      
      final updatedParty = currentParty.removePokemon(pokemonId);
      await partyService.updateParty(updatedParty);
      
      // partyPokemonsテーブルからも削除
      final partyPokemon = await (database.select(database.partyPokemons)
        ..where((tbl) => tbl.partyId.equals(currentParty.id) & tbl.pokemonId.equals(pokemonId)))
        .getSingleOrNull();
      
      if (partyPokemon != null) {
        await database.deletePartyPokemon(partyPokemon.id);
      }
      
      state = AsyncValue.data(updatedParty);
      return Success(updatedParty);
    } catch (error, stackTrace) {
      final failure = DomainFailure.dataDeleteFailed(
        message: 'パーティからのポケモン削除に失敗しました',
        cause: error,
      );
      state = AsyncValue.error(error, stackTrace);
      debugPrint('Failed to remove pokemon from party: $error');
      return Failure(failure);
    }
  }

  /// パーティの6スロット情報を取得する（育成カウンター情報を含む）。
  Future<Result<List<PartySlot>, DomainFailure>> getPartySlots() async {
    final currentParty = state.valueOrNull;
    if (currentParty == null) {
      final failure = DomainFailure.notFound(
        message: '選択されたパーティが見つかりません',
      );
      return Failure(failure);
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

      return Success(slots);
    } catch (error) {
      final failure = DomainFailure.dataFetchFailed(
        message: 'パーティスロット情報の取得に失敗しました',
        cause: error,
      );
      debugPrint('Failed to get party slots: $error');
      return Failure(failure);
    }
  }

  /// 育成カウンターを増加させる。
  Future<Result<void, DomainFailure>> incrementBreedingCounter(int partyPokemonId) async {
    try {
      final database = ref.read(localDatabaseProvider);
      final partyPokemon = await (database.select(database.partyPokemons)
            ..where((tbl) => tbl.id.equals(partyPokemonId)))
          .getSingleOrNull();

      if (partyPokemon != null) {
        await database.updateBreedingCounter(
          partyPokemonId,
          partyPokemon.breedingCounter + 1,
        );
        return const Success(null);
      } else {
        final failure = DomainFailure.notFound(
          message: '指定されたパーティポケモンが見つかりません',
        );
        return Failure(failure);
      }
    } catch (error, _) {
      final failure = DomainFailure.dataSaveFailed(
        message: '育成カウンターの増加に失敗しました',
        cause: error,
      );
      debugPrint('Failed to increment breeding counter: $error');
      return Failure(failure);
    }
  }

  /// 育成カウンターを減少させる。
  Future<Result<void, DomainFailure>> decrementBreedingCounter(int partyPokemonId) async {
    try {
      final database = ref.read(localDatabaseProvider);
      final partyPokemon = await (database.select(database.partyPokemons)
            ..where((tbl) => tbl.id.equals(partyPokemonId)))
          .getSingleOrNull();

      if (partyPokemon != null && partyPokemon.breedingCounter > 0) {
        await database.updateBreedingCounter(
          partyPokemonId,
          partyPokemon.breedingCounter - 1,
        );
        return const Success(null);
      } else if (partyPokemon != null) {
        final failure = DomainFailure.validationError(
          message: '育成カウンターは0以下には設定できません',
        );
        return Failure(failure);
      } else {
        final failure = DomainFailure.notFound(
          message: '指定されたパーティポケモンが見つかりません',
        );
        return Failure(failure);
      }
    } catch (error, _) {
      final failure = DomainFailure.dataSaveFailed(
        message: '育成カウンターの減少に失敗しました',
        cause: error,
      );
      debugPrint('Failed to decrement breeding counter: $error');
      return Failure(failure);
    }
  }

  /// 育成カウンターをリセットする。
  Future<Result<void, DomainFailure>> resetBreedingCounter(int partyPokemonId) async {
    try {
      final database = ref.read(localDatabaseProvider);
      await database.updateBreedingCounter(partyPokemonId, 0);
      return const Success(null);
    } catch (error, _) {
      final failure = DomainFailure.dataSaveFailed(
        message: '育成カウンターのリセットに失敗しました',
        cause: error,
      );
      debugPrint('Failed to reset breeding counter: $error');
      return Failure(failure);
    }
  }

  /// 育成カウンターを指定値に設定する。
  Future<Result<void, DomainFailure>> setBreedingCounter(int partyPokemonId, int value) async {
    if (value < 0) {
      final failure = DomainFailure.validationError(
        message: '育成カウンターには0以上の値を設定してください',
      );
      return Failure(failure);
    }

    try {
      final database = ref.read(localDatabaseProvider);
      await database.updateBreedingCounter(partyPokemonId, value);
      return const Success(null);
    } catch (error, _) {
      final failure = DomainFailure.dataSaveFailed(
        message: '育成カウンターの設定に失敗しました',
        cause: error,
      );
      debugPrint('Failed to set breeding counter: $error');
      return Failure(failure);
    }
  }

  /// 現在のパーティを再読み込みする。
  Future<Result<Party?, DomainFailure>> reload() async {
    state = const AsyncValue.loading();
    return await _loadCurrentPartyWithResult();
  }
}
