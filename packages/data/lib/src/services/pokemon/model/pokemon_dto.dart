import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_dto.freezed.dart';
part 'pokemon_dto.g.dart';

/// PokeAPI の /pokemon エンドポイントのレスポンス要素を表す DTO。
@freezed
abstract class PokemonDto with _$PokemonDto {
  const PokemonDto._(); // Add private constructor

  const factory PokemonDto({
    required String name,
    required String url,
  }) = _PokemonDto;

  factory PokemonDto.fromJson(Map<String, dynamic> json) =>
      _$PokemonDtoFromJson(json);
}
