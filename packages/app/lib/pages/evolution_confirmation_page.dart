import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_breeder_app/widgets/pokemon_info_view.dart';

class EvolutionConfirmationPage extends StatelessWidget {
  const EvolutionConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DsScaffold(
      topBarContent: const DsTopBar(
        content: Text('進化確認'),
      ),
      body: Padding(
        padding: DsPadding.allL,
        child: Column(
          children: [
            const Spacer(),
            const Text(
              'フシギダネは フシギソウ に進化します。\nよろしいですか？',
              style: DsTypography.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: DsSpacing.xl),
            _buildPokemonCompareView(),
            const Spacer(),
            _buildActionButtons(),
            const SizedBox(height: DsSpacing.l),
          ],
        ),
      ),
    );
  }

  Widget _buildPokemonCompareView() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PokemonInfoView(
          name: 'フシギダネ',
          pokedexNumber: 'No.001',
          type1: 'くさ',
          type2: 'どく',
        ),
        SizedBox(width: DsSpacing.l),
        Icon(
          Icons.arrow_forward,
          size: DsDimension.iconSizeL,
        ),
        SizedBox(width: DsSpacing.l),
        PokemonInfoView(
          name: 'フシギソウ',
          pokedexNumber: 'No.002',
          type1: 'くさ',
          type2: 'どく',
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return const Row(
      children: [
        Expanded(
          child: DsButton(
            onPressed: null,
            label: 'キャンセル',
            type: DsButtonType.destructive,
          ),
        ),
        SizedBox(width: DsSpacing.l),
        Expanded(
          child: DsButton(
            onPressed: null,
            label: '承認',
            type: DsButtonType.primary,
          ),
        ),
      ],
    );
  }
}
