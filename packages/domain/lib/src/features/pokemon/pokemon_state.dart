import 'package:data/src/services/api/api_client.dart';
import 'package:data/src/services/pokemon/pokemon_service.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/core.dart';
import 'pokemon.dart';

part 'pokemon_state.g.dart';

/// Pokemon 一覧の状態を管理するクラス。無限スクロール対応。
@riverpod
class PokemonState extends _$PokemonState {
  static const int _pageSize = 20;

  @override
  AsyncValue<List<Pokemon>> build() {
    return const AsyncValue.data([]);
  }

  /// Pokemon 一覧を初期読み込みする。
  Future<Result<List<Pokemon>, DomainFailure>> fetchInitialPokemons() async {
    state = const AsyncValue.loading();
    return await _fetchPokemons(offset: 0, isInitial: true);
  }

  /// 次のページの Pokemon 一覧を読み込む。
  Future<Result<List<Pokemon>, DomainFailure>> fetchNextPage() async {
    final currentList = state.valueOrNull ?? [];
    if (currentList.isEmpty) {
      return const Success([]);
    }

    return await _fetchPokemons(offset: currentList.length, isInitial: false);
  }

  /// 指定されたオフセットから Pokemon 一覧を取得する。
  Future<Result<List<Pokemon>, DomainFailure>> _fetchPokemons({
    required int offset,
    required bool isInitial,
  }) async {
    try {
      final pokemonService = ref.read(pokemonServiceProvider);

      final result = await pokemonService.fetchPokemons(
        limit: _pageSize,
        offset: offset,
      );

      return await result.when(
        success: (pokemonDtos) async {
          final newPokemons = pokemonDtos.map(_convertToEntity).toList();
          final currentList =
              isInitial ? <Pokemon>[] : (state.valueOrNull ?? []);
          final updatedList = [...currentList, ...newPokemons];
          state = AsyncValue.data(updatedList);
          return Success(updatedList);
        },
        failure: (failure) async {
          final domainFailure = DomainFailure.dataFetchFailed(
            message: 'ポケモンデータの取得に失敗しました',
            cause: failure,
          );
          if (isInitial) {
            state = AsyncValue.error(
              Exception(domainFailure.message),
              StackTrace.current,
            );
          } else {
            debugPrint(
                'Additional pokemon fetch failed: ${domainFailure.message}');
          }
          return Failure(domainFailure);
        },
      );
    } catch (error, stackTrace) {
      final domainFailure = DomainFailure.unexpected(
        message: 'ポケモンデータの取得中に予期しないエラーが発生しました',
        cause: error,
      );
      if (isInitial) {
        state = AsyncValue.error(error, stackTrace);
      } else {
        debugPrint('Unexpected error during pokemon fetch: $error');
      }
      return Failure(domainFailure);
    }
  }

  /// エラー状態からのリトライ。
  Future<Result<List<Pokemon>, DomainFailure>> retry() async {
    return await fetchInitialPokemons();
  }

  /// PokemonDTO を Pokemon エンティティに変換する。
  Pokemon _convertToEntity(pokemonDto) {
    // URLから ID を抽出（例: "https://pokeapi.co/api/v2/pokemon/25/" -> 25）
    final urlParts = pokemonDto.url.split('/');
    final idString = urlParts[urlParts.length - 2]; // 最後の '/' を除いた要素
    final id = int.tryParse(idString) ?? 0;

    // スプライト画像URLを生成
    final imageUrl =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

    return Pokemon(
      id: id,
      name: pokemonDto.name,
      pokedexNumber: id, // 通常、ID と図鑑番号は同じ
      imageUrl: imageUrl,
    );
  }
}

/// 検索クエリの状態を管理するProvider。
@riverpod
class SearchQueryState extends _$SearchQueryState {
  @override
  String build() {
    return '';
  }

  /// 検索クエリを更新する。
  void updateQuery(String query) {
    state = query.trim();
  }

  /// 検索クエリをクリアする。
  void clearQuery() {
    state = '';
  }
}

/// PokemonService の Provider を定義。
@riverpod
PokemonService pokemonService(ref) {
  final apiClient = ApiClient();
  return PokemonService(apiClient);
}
