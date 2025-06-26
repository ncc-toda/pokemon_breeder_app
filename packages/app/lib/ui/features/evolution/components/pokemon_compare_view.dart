import 'package:design_system/design_system.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_breeder_app/ui/features/pokemon/components/pokemon_info_view.dart';

/// 進化前後のポケモン比較表示の設定
class PokemonCompareConfig {
  const PokemonCompareConfig({
    required this.beforePokemon,
    required this.afterPokemon,
  });

  /// 進化前のポケモン
  final Pokemon beforePokemon;

  /// 進化後のポケモン
  final Pokemon afterPokemon;
}

/// 進化前後のポケモン比較表示用のWidget
class PokemonCompareView extends StatelessWidget {
  const PokemonCompareView({super.key, required this.config});

  /// 比較表示の設定
  final PokemonCompareConfig config;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PokemonInfoView(
          name: config.beforePokemon.displayName,
          pokedexNumber: config.beforePokemon.formattedPokedexNumber,
          type1: '？', // TODO: 実際のタイプ情報を取得
          type2: null,
        ),
        const SizedBox(width: DsSpacing.l),
        const Icon(
          Icons.arrow_forward,
          size: DsDimension.iconSizeL,
        ),
        const SizedBox(width: DsSpacing.l),
        PokemonInfoView(
          name: config.afterPokemon.displayName,
          pokedexNumber: config.afterPokemon.formattedPokedexNumber,
          type1: '？', // TODO: 実際のタイプ情報を取得
          type2: null,
        ),
      ],
    );
  }
}