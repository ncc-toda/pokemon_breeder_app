import 'package:data/src/services/api/api_client.dart';
import 'package:data/src/services/pokemon/pokemon_service.dart';
import 'package:dio/dio.dart';
import 'package:test/test.dart';

void main() {
  group('PokemonService', () {
    late PokemonService service;

    setUp(() {
      final dio = Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2'));
      final apiClient = ApiClient(dio: dio);
      service = PokemonService(apiClient);
    });

    test('fetchPokemons returns list of pokemons', () async {
      final result = await service.fetchPokemons(limit: 1);
      result.when(
        success: (pokemons) {
          expect(pokemons, isNotEmpty);
        },
        failure: (failure) =>
            fail('Expected success, got failure: ${failure.toString()}'),
      );
    });
  });
}
