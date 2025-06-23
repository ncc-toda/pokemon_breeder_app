import 'package:data/src/services/local_storage/local_database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart';

import 'evolution_data.dart';

part 'evolve_pokemon_use_case.g.dart';

/// ポケモンの進化処理を実行するUseCaseの結果。
class EvolutionResult {
  const EvolutionResult({
    required this.success,
    required this.message,
    this.beforePokemonId,
    this.afterPokemonId,
    this.partyPokemonId,
  });

  /// 進化処理が成功したかどうか。
  final bool success;

  /// 処理結果のメッセージ。
  final String message;

  /// 進化前のポケモンID。
  final int? beforePokemonId;

  /// 進化後のポケモンID。
  final int? afterPokemonId;

  /// パーティポケモンのID。
  final int? partyPokemonId;

  /// 成功時の結果を作成する。
  factory EvolutionResult.success({
    required int beforePokemonId,
    required int afterPokemonId,
    required int partyPokemonId,
    required String message,
  }) {
    return EvolutionResult(
      success: true,
      message: message,
      beforePokemonId: beforePokemonId,
      afterPokemonId: afterPokemonId,
      partyPokemonId: partyPokemonId,
    );
  }

  /// 失敗時の結果を作成する。
  factory EvolutionResult.failure(String message) {
    return EvolutionResult(
      success: false,
      message: message,
    );
  }
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
  Future<EvolutionResult> evolve(int partyPokemonId) async {
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
        return EvolutionResult.failure('指定されたパーティポケモンが見つかりません。');
      }

      // 育成カウンターの確認
      if (partyPokemon.breedingCounter < 10) {
        debugPrint(
            'EvolvePokemonUseCase.evolve: Breeding counter insufficient (${partyPokemon.breedingCounter})');
        return EvolutionResult.failure(
            '育成カウンターが不足しています。（現在: ${partyPokemon.breedingCounter}/10）');
      }

      // 進化先の確認
      final evolutionTargetId =
          EvolutionData.getEvolutionTarget(partyPokemon.pokemonId);
      if (evolutionTargetId == null) {
        debugPrint(
            'EvolvePokemonUseCase.evolve: No evolution target for pokemonId=${partyPokemon.pokemonId}');
        return EvolutionResult.failure('このポケモンは進化できません。');
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

      return EvolutionResult.success(
        beforePokemonId: partyPokemon.pokemonId,
        afterPokemonId: evolutionTargetId,
        partyPokemonId: partyPokemonId,
        message: '進化が成功しました！',
      );
    } catch (error, stackTrace) {
      debugPrint('EvolvePokemonUseCase.evolve: Error occurred: $error');
      debugPrint('StackTrace: $stackTrace');
      return EvolutionResult.failure('進化処理中にエラーが発生しました。');
    }
  }

  /// 指定されたパーティポケモンを退化させる。
  ///
  /// [partyPokemonId] 退化させるパーティポケモンのID
  /// 戻り値: 退化処理の結果
  Future<EvolutionResult> devolve(int partyPokemonId) async {
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
        return EvolutionResult.failure('指定されたパーティポケモンが見つかりません。');
      }

      // 退化先の確認
      final devolutionTargetId =
          EvolutionData.getDevolutionTarget(partyPokemon.pokemonId);
      if (devolutionTargetId == null) {
        debugPrint(
            'EvolvePokemonUseCase.devolve: No devolution target for pokemonId=${partyPokemon.pokemonId}');
        return EvolutionResult.failure('このポケモンは退化できません。');
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

      return EvolutionResult.success(
        beforePokemonId: partyPokemon.pokemonId,
        afterPokemonId: devolutionTargetId,
        partyPokemonId: partyPokemonId,
        message: '退化が成功しました！',
      );
    } catch (error, stackTrace) {
      debugPrint('EvolvePokemonUseCase.devolve: Error occurred: $error');
      debugPrint('StackTrace: $stackTrace');
      return EvolutionResult.failure('退化処理中にエラーが発生しました。');
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
    return EvolutionData.getEvolutionTarget(pokemonId);
  }

  /// 指定されたポケモンが退化可能かどうかを確認する。
  ///
  /// [pokemonId] 確認対象のポケモンID
  /// 戻り値: 退化可能な場合のターゲットID、そうでなければnull
  static int? checkDevolutionPossibility(int pokemonId) {
    return EvolutionData.getDevolutionTarget(pokemonId);
  }
}
