import 'package:data/src/services/api/api_client.dart';
import 'package:data/src/services/pokemon/pokemon_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/result/result.dart';
import 'pokemon.dart';

part 'pokemon_state.g.dart';

/// Pokemon 一覧の状態を管理するクラス。無限スクロール対応。
@riverpod
class PokemonState extends _$PokemonState {
  static const int _pageSize = 20;

  @override
  List<Pokemon> build() {
    return [];
  }

  /// Pokemon 一覧を初期読み込みする。
  Future<void> fetchInitialPokemons() async {
    state = [];
    await _fetchPokemons(offset: 0);
  }

  /// 次のページの Pokemon 一覧を読み込む。
  Future<void> fetchNextPage() async {
    final currentOffset = state.length;
    await _fetchPokemons(offset: currentOffset);
  }

  /// 指定されたオフセットから Pokemon 一覧を取得する。
  Future<void> _fetchPokemons({required int offset}) async {
    final pokemonService = ref.read(pokemonServiceProvider);
    
    final result = await pokemonService.fetchPokemons(
      limit: _pageSize,
      offset: offset,
    );

    result.when(
      success: (pokemonDtos) {
        final newPokemons = pokemonDtos.map(_convertToEntity).toList();
        state = [...state, ...newPokemons];
      },
      failure: (failure) {
        // エラーハンドリングは上位層に委譲
        throw Exception('Failed to fetch pokemons: ${failure.toString()}');
      },
    );
  }

  /// PokemonDTO を Pokemon エンティティに変換する。
  Pokemon _convertToEntity(pokemonDto) {
    // URLから ID を抽出（例: "https://pokeapi.co/api/v2/pokemon/25/" -> 25）
    final urlParts = pokemonDto.url.split('/');
    final idString = urlParts[urlParts.length - 2]; // 最後の '/' を除いた要素
    final id = int.tryParse(idString) ?? 0;
    
    // スプライト画像URLを生成
    final imageUrl = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
    
    return Pokemon(
      id: id,
      name: pokemonDto.name,
      pokedexNumber: id, // 通常、ID と図鑑番号は同じ
      imageUrl: imageUrl,
    );
  }
}

/// PokemonService の Provider を定義。
@riverpod
PokemonService pokemonService(PokemonServiceRef ref) {
  final apiClient = ApiClient();
  return PokemonService(apiClient);
}