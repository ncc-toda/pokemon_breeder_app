import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class PokemonInfoView extends StatelessWidget {
  const PokemonInfoView({
    super.key,
    required this.name,
    required this.pokedexNumber,
    required this.type1,
    this.type2,
  });

  final String name;
  final String pokedexNumber;
  final String type1;
  final String? type2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TODO(tetsu): 後で画像に差し替える
        const Placeholder(
          fallbackHeight: DsDimension.iconSizeXxl,
          fallbackWidth: DsDimension.iconSizeXxl,
        ),
        const SizedBox(height: DsSpacing.s),
        Text(name, style: DsTypography.titleMedium),
        const SizedBox(height: DsSpacing.xs),
        Text(pokedexNumber, style: DsTypography.bodyMedium),
        const SizedBox(height: DsSpacing.s),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TypeChip(type: type1),
            if (type2 != null) ...[
              const SizedBox(width: DsSpacing.xs),
              TypeChip(type: type2!),
            ],
          ],
        ),
      ],
    );
  }
}

class TypeChip extends StatelessWidget {
  const TypeChip({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DsSpacing.s,
        vertical: DsSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(DsRadius.xl),
      ),
      child: Text(
        type,
        style: DsTypography.labelSmall.copyWith(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
