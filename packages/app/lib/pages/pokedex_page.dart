import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class PokedexPage extends StatelessWidget {
  const PokedexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DsScaffold(
      topBarContent: DsTopBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('ポケモン図鑑'),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // TODO(tetsu): 検索処理
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          _buildFilterBar(),
          Expanded(
            child: _buildPokedexGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Padding(
      padding: DsPadding.allS,
      child: Wrap(
        spacing: DsSpacing.s,
        runSpacing: DsSpacing.s,
        children: [
          DsChoiceChip(
            label: 'カントー',
            selected: true,
            onSelected: (selected) {},
          ),
          DsChoiceChip(
            label: 'ジョウト',
            selected: false,
            onSelected: (selected) {},
          ),
          DsChoiceChip(
            label: 'ホウエン',
            selected: false,
            onSelected: (selected) {},
          ),
          // 他の世代も同様に追加
        ],
      ),
    );
  }

  Widget _buildPokedexGrid() {
    return GridView.builder(
      padding: DsPadding.allS,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: DsSpacing.s,
        mainAxisSpacing: DsSpacing.s,
      ),
      // 無限スクロールを模倣するために大きな数を設定
      itemCount: 151,
      itemBuilder: (context, index) {
        final pokedexNumber = (index + 1).toString().padLeft(3, '0');
        return _PokedexCell(
          pokedexNumber: pokedexNumber,
          isDiscovered: index % 5 != 0, // ダミーの発見状態
        );
      },
    );
  }
}

class _PokedexCell extends StatelessWidget {
  const _PokedexCell({
    required this.pokedexNumber,
    required this.isDiscovered,
  });

  final String pokedexNumber;
  final bool isDiscovered;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DsRadius.m),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No.$pokedexNumber',
            style: DsTypography.labelSmall.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: DsSpacing.s),
          Expanded(
            child: Placeholder(
              color: isDiscovered
                  ? Theme.of(context).colorScheme.primary
                  : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
