import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:domain/domain.dart';

class PartyPage extends HookConsumerWidget {
  const PartyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DsScaffold(
      topBarContent: const DsTopBar(
        content: Text('パーティ'),
      ),
      body: Stack(
        children: [
          Consumer(
            builder: (context, ref, child) {
              final currentPartyAsync = ref.watch(currentPartyStateProvider);
              final allPokemonsAsync = ref.watch(pokemonStateProvider);
              
              return currentPartyAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('エラーが発生しました: $error'),
                      ElevatedButton(
                        onPressed: () => ref.read(currentPartyStateProvider.notifier).reload(),
                        child: const Text('再試行'),
                      ),
                    ],
                  ),
                ),
                data: (party) {
                  if (party == null) {
                    return const Center(child: Text('パーティが見つかりません'));
                  }
                  
                  final allPokemons = allPokemonsAsync.valueOrNull ?? [];
                  
                  return FutureBuilder<List<PartySlot>>(
                    future: ref.read(currentPartyStateProvider.notifier).getPartySlots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      
                      final partySlots = snapshot.data ?? [];
                      
                      return GridView.builder(
                        padding: DsPadding.allS,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8, // カウンター表示のため縦を少し長く
                          crossAxisSpacing: DsSpacing.s,
                          mainAxisSpacing: DsSpacing.s,
                        ),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          if (index < partySlots.length) {
                            final slot = partySlots[index];
                            if (slot.runtimeType.toString().contains('Filled')) {
                              final filled = slot as dynamic;
                              final pokemon = allPokemons.where((p) => p.id == filled.pokemonId).firstOrNull;
                              return _PokemonCard(
                                pokemon: pokemon,
                                partyPokemonId: filled.partyPokemonId,
                                breedingCounter: filled.breedingCounter,
                                canEvolve: slot.canEvolve,
                                progressPercentage: slot.progressPercentage,
                                onTap: pokemon != null ? () => _showPokemonOptions(context, ref, pokemon) : null,
                                onLongPress: pokemon != null ? () => _showDeleteDialog(context, ref, pokemon) : null,
                                onIncrementCounter: () => _incrementCounter(ref, filled.partyPokemonId),
                                onDecrementCounter: () => _decrementCounter(ref, filled.partyPokemonId),
                              );
                            } else {
                              return _EmptySlotCard(
                                onTap: () => context.go('/pokedex'),
                              );
                            }
                          } else {
                            return _EmptySlotCard(
                              onTap: () => context.go('/pokedex'),
                            );
                          }
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
          Positioned(
            right: DsSpacing.l,
            bottom: DsSpacing.l,
            child: FloatingActionButton(
              onPressed: () => context.go('/pokedex'),
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  /// 育成カウンターを増加させる。
  void _incrementCounter(WidgetRef ref, int partyPokemonId) {
    ref.read(currentPartyStateProvider.notifier).incrementBreedingCounter(partyPokemonId);
  }

  /// 育成カウンターを減少させる。
  void _decrementCounter(WidgetRef ref, int partyPokemonId) {
    ref.read(currentPartyStateProvider.notifier).decrementBreedingCounter(partyPokemonId);
  }

  /// ポケモンの操作オプションを表示する。
  void _showPokemonOptions(BuildContext context, WidgetRef ref, Pokemon pokemon) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('詳細を見る'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: ポケモン詳細画面への遷移
                },
              ),
              ListTile(
                leading: const Icon(Icons.remove_circle),
                title: const Text('パーティから外す'),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteDialog(context, ref, pokemon);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// ポケモンをパーティから削除する確認ダイアログを表示する。
  void _showDeleteDialog(BuildContext context, WidgetRef ref, Pokemon pokemon) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('パーティから外す'),
          content: Text('${pokemon.displayName} をパーティから外しますか？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('キャンセル'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ref.read(currentPartyStateProvider.notifier).removePokemonFromParty(pokemon.id);
                
                // スナックバーで削除完了メッセージを表示
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${pokemon.displayName} をパーティから外しました'),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                      label: '取り消し',
                      onPressed: () {
                        ref.read(currentPartyStateProvider.notifier).addPokemonToParty(pokemon.id);
                      },
                    ),
                  ),
                );
              },
              child: const Text('外す'),
            ),
          ],
        );
      },
    );
  }
}

class _PokemonCard extends StatelessWidget {
  const _PokemonCard({
    required this.pokemon,
    this.partyPokemonId,
    this.breedingCounter = 0,
    this.canEvolve = false,
    this.progressPercentage = 0,
    this.onTap,
    this.onLongPress,
    this.onIncrementCounter,
    this.onDecrementCounter,
  });

  final Pokemon? pokemon;
  final int? partyPokemonId;
  final int breedingCounter;
  final bool canEvolve;
  final int progressPercentage;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onIncrementCounter;
  final VoidCallback? onDecrementCounter;

  @override
  Widget build(BuildContext context) {
    if (pokemon == null) {
      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DsRadius.xl),
        ),
        child: const Padding(
          padding: DsPadding.allS,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, size: DsDimension.iconSizeXxl),
              SizedBox(height: DsSpacing.s),
              Text('データなし', style: DsTypography.titleSmall),
            ],
          ),
        ),
      );
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DsRadius.xl),
        side: canEvolve 
          ? BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)
          : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(DsRadius.xl),
        child: Padding(
          padding: DsPadding.allS,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ポケモン画像とプログレスバー
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(DsRadius.m),
                        child: Image.network(
                          pokemon!.imageUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(DsRadius.m),
                              ),
                              child: Icon(
                                Icons.catching_pokemon,
                                size: DsDimension.iconSizeL,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: DsSpacing.xs),
                    // プログレスバー
                    LinearProgressIndicator(
                      value: progressPercentage / 100.0,
                      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        canEvolve 
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
              
              // ポケモン名
              Padding(
                padding: const EdgeInsets.symmetric(vertical: DsSpacing.xs),
                child: Text(
                  pokemon!.displayName,
                  style: DsTypography.bodySmall,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              
              // 育成カウンター操作部分
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // マイナスボタン
                    SizedBox(
                      width: 28,
                      height: 28,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: breedingCounter > 0 ? onDecrementCounter : null,
                        icon: const Icon(Icons.remove, size: 16),
                        style: IconButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.surface,
                          foregroundColor: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                    
                    // カウンター表示
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$breedingCounter',
                          style: DsTypography.titleMedium.copyWith(
                            color: canEvolve 
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (canEvolve)
                          Icon(
                            Icons.star,
                            size: 12,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                      ],
                    ),
                    
                    // プラスボタン
                    SizedBox(
                      width: 28,
                      height: 28,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: onIncrementCounter,
                        icon: const Icon(Icons.add, size: 16),
                        style: IconButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.surface,
                          foregroundColor: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptySlotCard extends StatelessWidget {
  const _EmptySlotCard({
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DsRadius.xl),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(DsRadius.xl),
        child: Padding(
          padding: DsPadding.allS,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_circle_outline,
                size: DsDimension.iconSizeXxl,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: DsSpacing.s),
              Text(
                'ポケモンを追加',
                style: DsTypography.titleSmall.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}