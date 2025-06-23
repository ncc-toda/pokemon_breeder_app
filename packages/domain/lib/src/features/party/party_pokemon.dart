import 'package:freezed_annotation/freezed_annotation.dart';

part 'party_pokemon.freezed.dart';

/// パーティ内のポケモンを表すエンティティ（育成カウンター情報を含む）。
@freezed
abstract class PartyPokemon with _$PartyPokemon {
  const PartyPokemon._();

  /// パーティ内ポケモンエンティティを作成する。
  const factory PartyPokemon({
    required int id,
    required int partyId,
    required int pokemonId,
    required int position,
    required int breedingCounter,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PartyPokemon;

  /// 育成カウンターを増加させる。
  PartyPokemon incrementCounter() {
    return copyWith(
      breedingCounter: breedingCounter + 1,
      updatedAt: DateTime.now(),
    );
  }

  /// 育成カウンターを減少させる（0未満にはならない）。
  PartyPokemon decrementCounter() {
    return copyWith(
      breedingCounter: breedingCounter > 0 ? breedingCounter - 1 : 0,
      updatedAt: DateTime.now(),
    );
  }

  /// 育成カウンターをリセットする。
  PartyPokemon resetCounter() {
    return copyWith(
      breedingCounter: 0,
      updatedAt: DateTime.now(),
    );
  }

  /// 育成カウンターを指定値に設定する。
  PartyPokemon setCounter(int value) {
    return copyWith(
      breedingCounter: value < 0 ? 0 : value,
      updatedAt: DateTime.now(),
    );
  }

  /// 進化条件を満たしているかどうかを判定する。
  /// 現在は仮実装として、カウンターが10以上の場合に進化可能とする。
  bool get canEvolve => breedingCounter >= 10;

  /// 育成進捗を示すパーセンテージ（0-100）を計算する。
  /// 進化条件（カウンター10）を100%として計算。
  int get progressPercentage {
    const maxCounter = 10;
    final percentage = (breedingCounter / maxCounter * 100).round();
    return percentage > 100 ? 100 : percentage;
  }
}
