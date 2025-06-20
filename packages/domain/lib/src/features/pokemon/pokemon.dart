import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon.freezed.dart';

/// Pokemon エンティティ。図鑑での表示に必要な情報を持つ。
@freezed
abstract class Pokemon with _$Pokemon {
  const Pokemon._();

  const factory Pokemon({
    /// PokeAPI から取得される ID（例: 1, 25, 151）
    required int id,
    
    /// Pokemon 名（英語）
    required String name,
    
    /// 図鑑番号（通常は id と同じ）
    required int pokedexNumber,
    
    /// スプライト画像URL
    required String imageUrl,
  }) = _Pokemon;

  /// 図鑑番号を #001 形式でフォーマットする。
  String get formattedPokedexNumber => '#${pokedexNumber.toString().padLeft(3, '0')}';

  /// Pokemon名の最初の文字を大文字にしたもの。
  String get displayName => name.isNotEmpty 
      ? name[0].toUpperCase() + name.substring(1).toLowerCase()
      : name;

  /// 検索クエリがこのPokemonにマッチするかどうかを判定する。
  /// 
  /// - Pokemon名（大文字小文字を区別しない部分一致）
  /// - 図鑑番号（完全一致または部分一致）
  bool matchesSearchQuery(String query) {
    if (query.isEmpty) return true;

    final normalizedQuery = query.toLowerCase().trim();
    
    // Pokemon名での検索（部分一致）
    if (name.toLowerCase().contains(normalizedQuery)) {
      return true;
    }
    
    // 図鑑番号での検索
    final pokedexStr = pokedexNumber.toString();
    if (pokedexStr.contains(normalizedQuery)) {
      return true;
    }
    
    // #付き図鑑番号での検索
    if (formattedPokedexNumber.toLowerCase().contains(normalizedQuery)) {
      return true;
    }
    
    return false;
  }
}