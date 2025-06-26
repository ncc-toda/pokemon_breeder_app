import 'package:design_system/design_system.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

/// パーティスロットのポケモンカード表示設定
class PokemonCardConfig {
  const PokemonCardConfig({
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

  /// 表示するポケモン（nullの場合はエラー表示）
  final Pokemon? pokemon;

  /// パーティポケモンのID
  final int? partyPokemonId;

  /// 育成カウンター
  final int breedingCounter;

  /// 進化可能かどうか
  final bool canEvolve;

  /// プログレスの進捗率（0-100）
  final int progressPercentage;

  /// カードタップ時のコールバック
  final VoidCallback? onTap;

  /// カード長押し時のコールバック
  final VoidCallback? onLongPress;

  /// カウンターアップボタンタップ時のコールバック
  final VoidCallback? onIncrementCounter;

  /// カウンターダウンボタンタップ時のコールバック
  final VoidCallback? onDecrementCounter;
}

/// パーティスロットのポケモンカード表示用Widget
class PokemonCard extends StatelessWidget {
  const PokemonCard({super.key, required this.config});

  /// カード表示の設定
  final PokemonCardConfig config;

  @override
  Widget build(BuildContext context) {
    if (config.pokemon == null) {
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
        side: config.canEvolve
            ? BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: config.onTap,
        onLongPress: config.onLongPress,
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
                          config.pokemon!.imageUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(DsRadius.m),
                              ),
                              child: Icon(
                                Icons.catching_pokemon,
                                size: DsDimension.iconSizeL,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: DsSpacing.xs),
                    // プログレスバー
                    LinearProgressIndicator(
                      value: config.progressPercentage / 100.0,
                      backgroundColor:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        config.canEvolve
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
                  config.pokemon!.displayName,
                  style: DsTypography.bodySmall,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // 育成カウンター操作部分
              Expanded(
                flex: 1,
                child: BreedingCounter(
                  count: config.breedingCounter,
                  canEvolve: config.canEvolve,
                  onIncrement: config.onIncrementCounter,
                  onDecrement: config.onDecrementCounter,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 育成カウンター操作用Widget
class BreedingCounter extends StatelessWidget {
  const BreedingCounter({
    super.key,
    required this.count,
    required this.canEvolve,
    this.onIncrement,
    this.onDecrement,
  });

  /// カウンター値
  final int count;

  /// 進化可能かどうか
  final bool canEvolve;

  /// カウンターアップボタンタップ時のコールバック
  final VoidCallback? onIncrement;

  /// カウンターダウンボタンタップ時のコールバック
  final VoidCallback? onDecrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // マイナスボタン
        SizedBox(
          width: 28,
          height: 28,
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: count > 0 ? onDecrement : null,
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
              '$count',
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
            onPressed: onIncrement,
            icon: const Icon(Icons.add, size: 16),
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.surface,
              foregroundColor: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}