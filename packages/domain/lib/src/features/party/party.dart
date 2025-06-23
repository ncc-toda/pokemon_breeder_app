import 'package:freezed_annotation/freezed_annotation.dart';

part 'party.freezed.dart';

/// パーティを表すエンティティ。
@freezed
abstract class Party with _$Party {
  const Party._();

  /// パーティエンティティを作成する。
  const factory Party({
    required int id,
    required String name,
    required List<int> pokemonIds,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Party;

  /// パーティに空きスロットがあるかどうかを返す。
  bool get hasEmptySlot => pokemonIds.length < 6;

  /// パーティの空きスロット数を返す。
  int get emptySlotCount => 6 - pokemonIds.length;

  /// パーティが満席かどうかを返す。
  bool get isFull => pokemonIds.length >= 6;

  /// パーティにポケモンを追加する。
  Party addPokemon(int pokemonId) {
    if (isFull || pokemonIds.contains(pokemonId)) {
      return this;
    }
    return copyWith(
      pokemonIds: [...pokemonIds, pokemonId],
      updatedAt: DateTime.now(),
    );
  }

  /// パーティからポケモンを削除する。
  Party removePokemon(int pokemonId) {
    if (!pokemonIds.contains(pokemonId)) {
      return this;
    }
    return copyWith(
      pokemonIds: pokemonIds.where((id) => id != pokemonId).toList(),
      updatedAt: DateTime.now(),
    );
  }
}

/// パーティの表示用スロット情報。
@freezed
sealed class PartySlot with _$PartySlot {
  const PartySlot._();

  /// 埋まっているスロット（育成カウンター情報を含む）。
  const factory PartySlot.filled({
    required int partyPokemonId,
    required int pokemonId,
    required int position,
    required int breedingCounter,
  }) = _PartySlotFilled;

  /// 空いているスロット。
  const factory PartySlot.empty({
    required int position,
  }) = _PartySlotEmpty;

  /// 進化条件を満たしているかどうかを判定する。
  bool get canEvolve {
    if (this is _PartySlotFilled) {
      final filled = this as _PartySlotFilled;
      return filled.breedingCounter >= 10;
    }
    return false;
  }

  /// 育成進捗を示すパーセンテージ（0-100）を計算する。
  int get progressPercentage {
    if (this is _PartySlotFilled) {
      final filled = this as _PartySlotFilled;
      const maxCounter = 10;
      final percentage = (filled.breedingCounter / maxCounter * 100).round();
      return percentage > 100 ? 100 : percentage;
    }
    return 0;
  }
}