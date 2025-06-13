import 'package:dio/dio.dart';
import 'package:domain/src/core/result/result.dart';

import '../../core/errors/data_failure.dart';
import '../api/api_client.dart';
import 'model/pokemon_dto.dart';

/// Pokemon に関する API 通信を担当するサービス。
class PokemonService {
  PokemonService(this._apiClient);

  final ApiClient _apiClient;

  /// ポケモン一覧を取得する。
  Future<Result<List<PokemonDto>, DataFailure>> fetchPokemons({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final response = await _apiClient.get<Map<String, dynamic>>(
        '/pokemon',
        queryParameters: {
          'limit': limit,
          'offset': offset,
        },
      );

      final data = response.data;
      if (data == null) {
        return Failure<List<PokemonDto>, DataFailure>(
          const DataFailure.emptyResponse(message: 'No data'),
        );
      }

      final results = data['results'] as List<dynamic>;
      final pokemons = results
          .map((e) => PokemonDto.fromJson(e as Map<String, dynamic>))
          .toList();
      return Success<List<PokemonDto>, DataFailure>(pokemons);
    } on DioException catch (e) {
      return Failure<List<PokemonDto>, DataFailure>(
        DataFailure.network(message: e.message ?? 'Network error'),
      );
    } catch (e) {
      return Failure<List<PokemonDto>, DataFailure>(
        DataFailure.unexpected(message: e.toString()),
      );
    }
  }
}
