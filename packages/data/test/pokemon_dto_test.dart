import 'package:test/test.dart';
import 'package:data/src/services/pokemon/model/pokemon_dto.dart';

void main() {
  test('PokemonDto can be created', () {
    final dto = PokemonDto(
        name: 'pikachu', url: 'https://pokeapi.co/api/v2/pokemon/25/');
    expect(dto.name, 'pikachu');
    expect(dto.url, 'https://pokeapi.co/api/v2/pokemon/25/');
  });

  test('PokemonDto can be serialized from JSON', () {
    final json = {
      'name': 'pikachu',
      'url': 'https://pokeapi.co/api/v2/pokemon/25/',
    };
    final dto = PokemonDto.fromJson(json);
    expect(dto.name, 'pikachu');
    expect(dto.url, 'https://pokeapi.co/api/v2/pokemon/25/');
  });

  test('PokemonDto can be serialized to JSON', () {
    final dto = PokemonDto(
        name: 'pikachu', url: 'https://pokeapi.co/api/v2/pokemon/25/');
    final json = dto.toJson();
    expect(json['name'], 'pikachu');
    expect(json['url'], 'https://pokeapi.co/api/v2/pokemon/25/');
  });
}
