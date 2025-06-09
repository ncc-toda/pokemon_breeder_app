import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class PartyPage extends StatelessWidget {
  const PartyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DsScaffold(
      topBarContent: const DsTopBar(
        content: Text('パーティ'),
      ),
      bottomBarContent: [
        DsButton.iconText(
          icon: Icons.catching_pokemon,
          label: '図鑑',
          onPressed: () {},
        ),
        DsButton.iconText(
          icon: Icons.people,
          label: 'パーティ',
          onPressed: () {},
        ),
        DsButton.iconText(
          icon: Icons.settings,
          label: '設定',
          onPressed: () {},
        ),
      ],
      body: Stack(
        children: [
          GridView.builder(
            padding: DsPadding.allS,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              crossAxisSpacing: DsSpacing.s,
              mainAxisSpacing: DsSpacing.s,
            ),
            itemCount: 6, // ダミーデータ
            itemBuilder: (context, index) {
              return const _PokemonCard(
                name: 'ピカチュウ',
                level: 50,
                hp: 100,
                maxHp: 100,
              );
            },
          ),
          Positioned(
            right: DsSpacing.l,
            bottom: DsSpacing.l,
            child: FloatingActionButton(
              onPressed: () {
                // TODO(tetsu): ポケモン追加処理
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

class _PokemonCard extends StatelessWidget {
  const _PokemonCard({
    required this.name,
    required this.level,
    required this.hp,
    required this.maxHp,
  });

  final String name;
  final int level;
  final int hp;
  final int maxHp;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DsRadius.xl),
      ),
      child: Padding(
        padding: DsPadding.allS,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Placeholder(
              fallbackHeight: DsDimension.iconSizeXxl,
              fallbackWidth: DsDimension.iconSizeXxl,
            ),
            const SizedBox(height: DsSpacing.s),
            Text('$name Lv.$level', style: DsTypography.titleSmall),
            const SizedBox(height: DsSpacing.s),
            LinearProgressIndicator(
              value: hp / maxHp,
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
