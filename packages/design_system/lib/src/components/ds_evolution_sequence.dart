import 'package:flutter/material.dart';
import 'ds_evolution_effects.dart';

/// アニメーションの段階
enum EvolutionPhase {
  /// 初期状態
  initial,
  /// シルエット表示
  silhouette,
  /// チャージ中
  charging,
  /// バースト
  burst,
  /// 出現
  reveal,
  /// 完了
  complete,
}

/// 進化アニメーションシーケンスを管理するウィジェット。
///
/// 進化前ポケモンから進化後ポケモンへの変化を
/// 段階的なアニメーションで表現します。
class DsEvolutionSequence extends StatefulWidget {
  /// 進化アニメーションシーケンスを作成します。
  const DsEvolutionSequence({
    required this.beforePokemon,
    required this.afterPokemon,
    super.key,
    this.duration = const Duration(seconds: 4),
    this.autoStart = true,
    this.onComplete,
  });

  /// 進化前ポケモンのウィジェット
  final Widget beforePokemon;

  /// 進化後ポケモンのウィジェット
  final Widget afterPokemon;

  /// 全体のアニメーション時間
  final Duration duration;

  /// 自動開始するかどうか
  final bool autoStart;

  /// アニメーション完了時のコールバック
  final VoidCallback? onComplete;

  @override
  State<DsEvolutionSequence> createState() => _DsEvolutionSequenceState();
}

class _DsEvolutionSequenceState extends State<DsEvolutionSequence>
    with TickerProviderStateMixin {
  late AnimationController _masterController;
  late Animation<double> _silhouetteOpacity;
  late Animation<double> _glowOpacity;
  late Animation<double> _afterPokemonOpacity;
  late Animation<double> _afterPokemonScale;

  VoidCallback? _startParticles;
  VoidCallback? _startBurst;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();

    if (widget.autoStart) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        startAnimation();
      });
    }
  }

  @override
  void dispose() {
    _masterController.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    _masterController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    // 段階別のアニメーション設定
    // Phase 1: シルエット表示 (0.0 - 0.2)
    _silhouetteOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0, 0.2, curve: Curves.easeIn),
      ),
    );

    // Phase 2: 光のチャージエフェクト (0.2 - 0.5)
    _glowOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.2, 0.5, curve: Curves.easeInOut),
      ),
    );

    // Note: 集中線バーストは個別に制御される

    // Phase 3: 進化後ポケモン出現 (0.7 - 1.0)
    _afterPokemonOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.7, 1, curve: Curves.easeOut),
      ),
    );

    _afterPokemonScale = Tween<double>(
      begin: 0.8,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.7, 1, curve: Curves.elasticOut),
      ),
    );

    // アニメーション進行の監視
    _masterController
      ..addListener(_onAnimationProgress)
      ..addStatusListener(_onAnimationStatus);
  }

  void _onAnimationProgress() {
    final progress = _masterController.value;

    // 段階に応じてエフェクトを開始
    if (progress >= 0.2 && progress < 0.25) {
      // パーティクルエフェクト開始
      _startParticles?.call();
    } else if (progress >= 0.5 && progress < 0.55) {
      // 集中線バースト開始
      _startBurst?.call();
    }
  }

  void _onAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      widget.onComplete?.call();
    }
  }

  /// アニメーションを開始する
  void startAnimation() {
    _masterController.forward();
  }

  /// アニメーションをリセットする
  void resetAnimation() {
    _masterController.reset();
    // Note: パーティクルとバーストのリセットは各コンポーネントの内部で処理される
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: _masterController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              radius: 1,
              colors: [
                theme.colorScheme.primary.withValues(alpha: _glowOpacity.value * 0.3),
                theme.colorScheme.surface,
              ],
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 背景パーティクルエフェクト
              DsEvolutionParticles(
                particleCount: 80,
                duration: Duration(
                    milliseconds:
                        (widget.duration.inMilliseconds * 0.6).round(),),
                color: theme.colorScheme.primary.withValues(alpha: 0.8),
                onInitialize: (startAnimation) {
                  _startParticles = startAnimation;
                },
                child: Container(),
              ),

              // 集中線バースト
              DsRadialBurst(
                lineCount: 20,
                color: theme.colorScheme.primary.withValues(alpha: 0.6),
                onInitialize: (startAnimation) {
                  _startBurst = startAnimation;
                },
                child: Container(),
              ),

              // 進化前ポケモンのシルエット
              if (_silhouetteOpacity.value > 0 &&
                  _afterPokemonOpacity.value < 0.5)
                AnimatedOpacity(
                  opacity: _silhouetteOpacity.value *
                      (1.0 - _afterPokemonOpacity.value * 2),
                  duration: const Duration(milliseconds: 200),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withValues(alpha: 0.8),
                      BlendMode.srcATop,
                    ),
                    child: widget.beforePokemon,
                  ),
                ),

              // 光のグローエフェクト
              if (_glowOpacity.value > 0)
                AnimatedOpacity(
                  opacity: _glowOpacity.value,
                  duration: const Duration(milliseconds: 100),
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary.withValues(alpha: 0.5),
                          blurRadius: 50,
                          spreadRadius: 30,
                        ),
                      ],
                    ),
                  ),
                ),

              // 進化後ポケモン
              if (_afterPokemonOpacity.value > 0)
                AnimatedOpacity(
                  opacity: _afterPokemonOpacity.value,
                  duration: const Duration(milliseconds: 200),
                  child: Transform.scale(
                    scale: _afterPokemonScale.value,
                    child: widget.afterPokemon,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

/// 進化アニメーション用のポケモン画像ウィジェット。
///
/// 一貫したサイズとスタイルでポケモン画像を表示します。
class DsEvolutionPokemonImage extends StatelessWidget {
  /// 進化アニメーション用のポケモン画像を作成します。
  const DsEvolutionPokemonImage({
    required this.imageUrl,
    required this.name,
    super.key,
    this.size = 150.0,
  });

  /// ポケモンの画像URL
  final String imageUrl;

  /// ポケモンの名前（alt text用）
  final String name;

  /// 画像のサイズ
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.network(
        imageUrl,
        fit: BoxFit.contain,
        semanticLabel: name,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.catching_pokemon,
              size: size * 0.6,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      ),
    );
  }
}
