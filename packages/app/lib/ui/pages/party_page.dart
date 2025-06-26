import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:domain/domain.dart';
import 'package:pokemon_breeder_app/ui/features/party/components/pokemon_card.dart';
import 'package:pokemon_breeder_app/ui/features/party/components/empty_slot_card.dart';
import 'package:pokemon_breeder_app/ui/features/party/components/pokemon_options_bottom_sheet.dart';
import 'package:pokemon_breeder_app/ui/features/party/components/delete_confirmation_dialog.dart';

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
                        onPressed: () async {
                          final result = await ref
                              .read(currentPartyStateProvider.notifier)
                              .reload();
                          result.when(
                            success: (_) => {},
                            failure: (failure) {
                              debugPrint(
                                  'Failed to reload party: ${failure.message}');
                            },
                          );
                        },
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

                  return FutureBuilder<Result<List<PartySlot>, DomainFailure>>(
                    future: ref
                        .read(currentPartyStateProvider.notifier)
                        .getPartySlots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final partySlots = snapshot.data?.when(
                            success: (slots) => slots,
                            failure: (failure) {
                              debugPrint(
                                  'Failed to get party slots: ${failure.message}');
                              return <PartySlot>[];
                            },
                          ) ??
                          [];

                      return GridView.builder(
                        padding: DsPadding.allS,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8, // カウンター表示のため縦を少し長く
                          crossAxisSpacing: DsSpacing.s,
                          mainAxisSpacing: DsSpacing.s,
                        ),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          if (index < partySlots.length) {
                            final slot = partySlots[index];
                            if (slot.runtimeType
                                .toString()
                                .contains('Filled')) {
                              final filled = slot as dynamic;
                              final pokemon = allPokemons
                                  .where((p) => p.id == filled.pokemonId)
                                  .firstOrNull;
                              return PokemonCard(
                                config: PokemonCardConfig(
                                  pokemon: pokemon,
                                  partyPokemonId: filled.partyPokemonId,
                                  breedingCounter: filled.breedingCounter,
                                  canEvolve: slot.canEvolve,
                                  progressPercentage: slot.progressPercentage,
                                  onTap: pokemon != null
                                      ? () => showModalBottomSheet<void>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                PokemonOptionsBottomSheet(
                                              config: PokemonOptionsConfig(
                                                pokemon: pokemon,
                                                partyPokemonId:
                                                    filled.partyPokemonId,
                                                canEvolve: slot.canEvolve,
                                                onDeleteConfirm: () => showDialog<void>(
                                                  context: context,
                                                  builder: (BuildContext context) =>
                                                      DeleteConfirmationDialog(
                                                    config: DeleteConfirmationConfig(
                                                      pokemon: pokemon,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                      : null,
                                  onLongPress: pokemon != null
                                      ? () => showDialog<void>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                DeleteConfirmationDialog(
                                              config: DeleteConfirmationConfig(
                                                pokemon: pokemon,
                                              ),
                                            ),
                                          )
                                      : null,
                                  onIncrementCounter: () async {
                                    final result = await ref
                                        .read(currentPartyStateProvider.notifier)
                                        .incrementBreedingCounter(
                                            filled.partyPokemonId);
                                    result.when(
                                      success: (_) => {},
                                      failure: (failure) {
                                        debugPrint(
                                            'Failed to increment breeding counter: ${failure.message}');
                                      },
                                    );
                                  },
                                  onDecrementCounter: () async {
                                    final result = await ref
                                        .read(currentPartyStateProvider.notifier)
                                        .decrementBreedingCounter(
                                            filled.partyPokemonId);
                                    result.when(
                                      success: (_) => {},
                                      failure: (failure) {
                                        debugPrint(
                                            'Failed to decrement breeding counter: ${failure.message}');
                                      },
                                    );
                                  },
                                ),
                              );
                            } else {
                              return EmptySlotCard(
                                onTap: () => context.go('/pokedex'),
                              );
                            }
                          } else {
                            return EmptySlotCard(
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
}

