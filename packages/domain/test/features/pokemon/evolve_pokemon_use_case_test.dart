import 'package:flutter_test/flutter_test.dart';
import 'package:domain/domain.dart';

void main() {
  group('EvolvePokemonUseCase - Static Methods', () {
    test('checkEvolutionPossibility - 進化可能', () {
      // Arrange
      const pokemonId = 1; // フシギダネ
      const breedingCounter = 10;

      // Act
      final result = EvolvePokemonUseCase.checkEvolutionPossibility(
        pokemonId,
        breedingCounter,
      );

      // Assert
      expect(result, equals(2)); // フシギソウ
    });

    test('checkEvolutionPossibility - 育成カウンター不足', () {
      // Arrange
      const pokemonId = 1; // フシギダネ
      const breedingCounter = 5; // 不足

      // Act
      final result = EvolvePokemonUseCase.checkEvolutionPossibility(
        pokemonId,
        breedingCounter,
      );

      // Assert
      expect(result, isNull);
    });

    test('checkEvolutionPossibility - 進化不可能なポケモン', () {
      // Arrange
      const pokemonId = 999; // 存在しないポケモン
      const breedingCounter = 10;

      // Act
      final result = EvolvePokemonUseCase.checkEvolutionPossibility(
        pokemonId,
        breedingCounter,
      );

      // Assert
      expect(result, isNull);
    });

    test('checkDevolutionPossibility - 退化可能', () {
      // Arrange
      const pokemonId = 2; // フシギソウ

      // Act
      final result = EvolvePokemonUseCase.checkDevolutionPossibility(
        pokemonId,
      );

      // Assert
      expect(result, equals(1)); // フシギダネ
    });

    test('checkDevolutionPossibility - 退化不可能', () {
      // Arrange
      const pokemonId = 1; // フシギダネ（退化不可能）

      // Act
      final result = EvolvePokemonUseCase.checkDevolutionPossibility(
        pokemonId,
      );

      // Assert
      expect(result, isNull);
    });

    test('checkDevolutionPossibility - 存在しないポケモン', () {
      // Arrange
      const pokemonId = 999; // 存在しないポケモン

      // Act
      final result = EvolvePokemonUseCase.checkDevolutionPossibility(
        pokemonId,
      );

      // Assert
      expect(result, isNull);
    });
  });
}
