import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_breeder_app/widgets/pokemon_info_view.dart';

class EvolutionResultPage extends StatelessWidget {
  const EvolutionResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DsScaffold(
      topBarContent: const DsTopBar(
        content: Text('進化結果'),
      ),
      body: Padding(
        padding: DsPadding.allL,
        child: Column(
          children: [
            const Spacer(),
            const Text(
              'おめでとう！\nフシギソウは フシギバナ に進化した！',
              style: DsTypography.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: DsSpacing.xl),
            _buildPokemonInfoView(),
            const Spacer(),
            _buildActionButtons(),
            const SizedBox(height: DsSpacing.l),
          ],
        ),
      ),
    );
  }

  Widget _buildPokemonInfoView() {
    return const PokemonInfoView(
      name: 'フシギバナ',
      pokedexNumber: 'No.003',
      type1: 'くさ',
      type2: 'どく',
    );
  }

  Widget _buildActionButtons() {
    return const SizedBox(
      width: double.infinity,
      child: DsButton(
        onPressed: null,
        label: 'パーティを確認する',
        type: DsButtonType.primary,
      ),
    );
  }
}
