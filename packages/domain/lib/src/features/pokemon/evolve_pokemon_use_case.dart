import 'package:data/src/services/local_storage/local_database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../core/core.dart';
import 'evolution_data.dart';

part 'evolve_pokemon_use_case.g.dart';

/// ポケモンの進化・退化処理の成功データ。
class EvolutionData {
  const EvolutionData({
    required this.beforePokemonId,
    required this.afterPokemonId,
    required this.partyPokemonId,
    required this.message,
  });

  /// 進化前のポケモンID。
  final int beforePokemonId;

  /// 進化後のポケモンID。
  final int afterPokemonId;

  /// パーティポケモンのID。
  final int partyPokemonId;

  /// 処理結果のメッセージ。
  final String message;
}

/// ポケモンの進化処理を実行するUseCase。
@riverpod
class EvolvePokemonUseCase extends _$EvolvePokemonUseCase {
  @override
  void build() {
    // このUseCaseは状態を持たない
  }

  /// 指定されたパーティポケモンを進化させる。
  ///
  /// [partyPokemonId] 進化させるパーティポケモンのID
  /// 戻り値: 進化処理の結果
  Future<Result<EvolutionData, DomainFailure>> evolve(int partyPokemonId) async {
    try {
      debugPrint(
          'EvolvePokemonUseCase.evolve: Starting evolution for partyPokemonId=$partyPokemonId');

      final database = ref.read(localDatabaseProvider);

      // パーティポケモンの情報を取得
      final partyPokemon = await (database.select(database.partyPokemons)
            ..where((tbl) => tbl.id.equals(partyPokemonId)))
          .getSingleOrNull();

      if (partyPokemon == null) {
        debugPrint('EvolvePokemonUseCase.evolve: PartyPokemon not found');
        final failure = DomainFailure.notFound(
          message: '指定されたパーティポケモンが見つかりません。',
        );
        return Failure(failure);
      }

      // 育成カウンターの確認
      if (partyPokemon.breedingCounter < 10) {
        debugPrint(
            'EvolvePokemonUseCase.evolve: Breeding counter insufficient (${partyPokemon.breedingCounter})');
        final failure = DomainFailure.evolutionError(
          message: '育成カウンターが不足しています。（現在: ${partyPokemon.breedingCounter}/10）',
        );
        return Failure(failure);
      }

      // 進化先の確認
      final evolutionTargetId =
          EvolutionDataHelper.getEvolutionTarget(partyPokemon.pokemonId);
      if (evolutionTargetId == null) {
        debugPrint(
            'EvolvePokemonUseCase.evolve: No evolution target for pokemonId=${partyPokemon.pokemonId}');
        final failure = DomainFailure.evolutionError(
          message: 'このポケモンは進化できません。',
        );
        return Failure(failure);
      }

      debugPrint(
          'EvolvePokemonUseCase.evolve: Evolution ${partyPokemon.pokemonId} -> $evolutionTargetId');

      // データベースの更新（ポケモンIDの変更と育成カウンターのリセット）
      await database.update(database.partyPokemons).replace(
            partyPokemon.copyWith(
              pokemonId: evolutionTargetId,
              breedingCounter: 0,
              updatedAt: DateTime.now(),
            ),
          );

      debugPrint(
          'EvolvePokemonUseCase.evolve: Evolution completed successfully');

      final evolutionData = EvolutionData(
        beforePokemonId: partyPokemon.pokemonId,
        afterPokemonId: evolutionTargetId,
        partyPokemonId: partyPokemonId,
        message: '進化が成功しました！',
      );
      return Success(evolutionData);
    } catch (error, stackTrace) {
      debugPrint('EvolvePokemonUseCase.evolve: Error occurred: $error');
      debugPrint('StackTrace: $stackTrace');
      final failure = DomainFailure.unexpected(
        message: '進化処理中にエラーが発生しました。',
        cause: error,
      );
      return Failure(failure);
    }
  }

  /// 指定されたパーティポケモンを退化させる。
  ///
  /// [partyPokemonId] 退化させるパーティポケモンのID
  /// 戻り値: 退化処理の結果
  Future<Result<EvolutionData, DomainFailure>> devolve(int partyPokemonId) async {
    try {
      debugPrint(
          'EvolvePokemonUseCase.devolve: Starting devolution for partyPokemonId=$partyPokemonId');

      final database = ref.read(localDatabaseProvider);

      // パーティポケモンの情報を取得
      final partyPokemon = await (database.select(database.partyPokemons)
            ..where((tbl) => tbl.id.equals(partyPokemonId)))
          .getSingleOrNull();

      if (partyPokemon == null) {
        debugPrint('EvolvePokemonUseCase.devolve: PartyPokemon not found');
        final failure = DomainFailure.notFound(
          message: '指定されたパーティポケモンが見つかりません。',
        );
        return Failure(failure);
      }

      // 退化先の確認
      final devolutionTargetId =
          EvolutionDataHelper.getDevolutionTarget(partyPokemon.pokemonId);
      if (devolutionTargetId == null) {
        debugPrint(
            'EvolvePokemonUseCase.devolve: No devolution target for pokemonId=${partyPokemon.pokemonId}');
        final failure = DomainFailure.evolutionError(
          message: 'このポケモンは退化できません。',
        );
        return Failure(failure);
      }

      debugPrint(
          'EvolvePokemonUseCase.devolve: Devolution ${partyPokemon.pokemonId} -> $devolutionTargetId');

      // データベースの更新（ポケモンIDの変更と育成カウンターのリセット）
      await database.update(database.partyPokemons).replace(
            partyPokemon.copyWith(
              pokemonId: devolutionTargetId,
              breedingCounter: 0,
              updatedAt: DateTime.now(),
            ),
          );

      debugPrint(
          'EvolvePokemonUseCase.devolve: Devolution completed successfully');

      final evolutionData = EvolutionData(
        beforePokemonId: partyPokemon.pokemonId,
        afterPokemonId: devolutionTargetId,
        partyPokemonId: partyPokemonId,
        message: '退化が成功しました！',
      );
      return Success(evolutionData);
    } catch (error, stackTrace) {
      debugPrint('EvolvePokemonUseCase.devolve: Error occurred: $error');
      debugPrint('StackTrace: $stackTrace');
      final failure = DomainFailure.unexpected(
        message: '退化処理中にエラーが発生しました。',
        cause: error,
      );
      return Failure(failure);
    }
  }

  /// 指定されたポケモンが進化可能かどうかを確認する。
  ///
  /// [pokemonId] 確認対象のポケモンID
  /// [breedingCounter] 現在の育成カウンター
  /// 戻り値: 進化可能な場合のターゲットID、そうでなければnull
  static int? checkEvolutionPossibility(int pokemonId, int breedingCounter) {
    // 育成カウンターの確認
    if (breedingCounter < 10) {
      return null;
    }

    // 進化データの確認
    return EvolutionDataHelper.getEvolutionTarget(pokemonId);
  }

  /// 指定されたポケモンが退化可能かどうかを確認する。
  ///
  /// [pokemonId] 確認対象のポケモンID
  /// 戻り値: 退化可能な場合のターゲットID、そうでなければnull
  static int? checkDevolutionPossibility(int pokemonId) {
    return EvolutionDataHelper.getDevolutionTarget(pokemonId);
  }
}
