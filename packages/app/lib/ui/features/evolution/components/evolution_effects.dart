/// 進化エフェクト用のアニメーションコンポーネント群。
library;

import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// パーティクルエフェクトに関する定数
class _ParticleConstants {
  /// パーティクルの最小サイズ
  static const double minSize = 2;

  /// パーティクルサイズの変動幅
  static const double maxSizeRange = 6;

  /// パーティクルの最小透明度
  static const double minOpacity = 0.2;

  /// パーティクル透明度の変動幅
  static const double maxOpacityRange = 0.8;

  /// パーティクルの移動速度倍率
  static const double velocityMultiplier = 100;

  /// 画面端のバッファ領域
  static const double screenBuffer = 50;

  /// パーティクルサイズの成長倍率
  static const double sizeGrowthMultiplier = 2;
}

/// 集中線エフェクトに関する定数
class _RadialBurstConstants {
  /// 集中線の開始半径倍率
  static const double startRadiusMultiplier = 50;

  /// 集中線の線幅
  static const double strokeWidth = 2;
}

/// パーティクルエフェクトを表示するウィジェット。
///
/// 光の粒子が画面全体に広がるアニメーションを提供します。
class DsEvolutionParticles extends StatefulWidget {
  /// パーティクルエフェクトを作成します。
  const DsEvolutionParticles({
    required this.child,
    super.key,
    this.particleCount = 50,
    this.duration = const Duration(seconds: 3),
    this.color,
    this.onInitialize,
  });

  /// パーティクルの数
  final int particleCount;

  /// アニメーション時間
  final Duration duration;

  /// パーティクルの色（nullの場合はテーマから取得）
  final Color? color;

  /// 子ウィジェット
  final Widget child;

  /// 初期化時に呼び出されるコールバック（startAnimationメソッドを渡す）
  final void Function(VoidCallback startAnimation)? onInitialize;

  @override
  State<DsEvolutionParticles> createState() => _DsEvolutionParticlesState();
}

class _DsEvolutionParticlesState extends State<DsEvolutionParticles>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Particle> _particles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _initializeParticles();

    // 外部からアニメーション制御できるようにコールバックを渡す
    widget.onInitialize?.call(startAnimation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initializeParticles() {
    final random = math.Random();
    _particles = List.generate(widget.particleCount, (index) {
      return Particle(
        x: random.nextDouble(),
        y: random.nextDouble(),
        velocity: Offset(
          (random.nextDouble() - 0.5) * 2,
          (random.nextDouble() - 0.5) * 2,
        ),
        size: random.nextDouble() * _ParticleConstants.maxSizeRange +
            _ParticleConstants.minSize,
        opacity: random.nextDouble() * _ParticleConstants.maxOpacityRange +
            _ParticleConstants.minOpacity,
      );
    });
  }

  /// アニメーションを開始する
  void startAnimation() {
    _controller.forward();
  }

  /// アニメーションをリセットする
  void resetAnimation() {
    _controller.reset();
    _initializeParticles();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final particleColor = widget.color ?? theme.colorScheme.primary;

    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: ParticlesPainter(
                  particles: _particles,
                  progress: _controller.value,
                  color: particleColor,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// 集中線エフェクトを表示するウィジェット。
///
/// 中心から放射状に広がる光線のアニメーションを提供します。
class DsRadialBurst extends StatefulWidget {
  /// 集中線エフェクトを作成します。
  const DsRadialBurst({
    required this.child,
    super.key,
    this.lineCount = 16,
    this.duration = const Duration(milliseconds: 800),
    this.color,
    this.onInitialize,
  });

  /// 放射線の本数
  final int lineCount;

  /// アニメーション時間
  final Duration duration;

  /// 線の色（nullの場合はテーマから取得）
  final Color? color;

  /// 子ウィジェット
  final Widget child;

  /// 初期化時に呼び出されるコールバック（startAnimationメソッドを渡す）
  final void Function(VoidCallback startAnimation)? onInitialize;

  @override
  State<DsRadialBurst> createState() => _DsRadialBurstState();
}

class _DsRadialBurstState extends State<DsRadialBurst>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0,
      end: 1.5,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _opacityAnimation = Tween<double>(
      begin: 0.8,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    // 外部からアニメーション制御できるようにコールバックを渡す
    widget.onInitialize?.call(startAnimation);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// アニメーションを開始する
  void startAnimation() {
    _controller.forward();
  }

  /// アニメーションをリセットする
  void resetAnimation() {
    _controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lineColor = widget.color ?? theme.colorScheme.primary;

    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: RadialBurstPainter(
                  lineCount: widget.lineCount,
                  scale: _scaleAnimation.value,
                  opacity: _opacityAnimation.value,
                  color: lineColor,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// パーティクル情報を保持するクラス
@immutable
class Particle {
  /// パーティクルを作成します。
  const Particle({
    required this.x,
    required this.y,
    required this.velocity,
    required this.size,
    required this.opacity,
  });

  /// X座標（0.0-1.0の正規化された値）
  final double x;

  /// Y座標（0.0-1.0の正規化された値）
  final double y;

  /// 移動速度ベクトル
  final Offset velocity;

  /// パーティクルのサイズ
  final double size;

  /// パーティクルの透明度
  final double opacity;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Particle &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y &&
          velocity == other.velocity &&
          size == other.size &&
          opacity == other.opacity;

  @override
  int get hashCode =>
      x.hashCode ^
      y.hashCode ^
      velocity.hashCode ^
      size.hashCode ^
      opacity.hashCode;
}

/// パーティクルエフェクトを描画するPainter
class ParticlesPainter extends CustomPainter {
  /// パーティクル描画器を作成します。
  ParticlesPainter({
    required this.particles,
    required this.progress,
    required this.color,
  });

  /// 描画するパーティクルのリスト
  final List<Particle> particles;

  /// アニメーション進行状況（0.0-1.0）
  final double progress;

  /// パーティクルの色
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.7)
      ..style = PaintingStyle.fill;

    for (final particle in particles) {
      // パーティクルの現在位置を計算
      final currentX = particle.x * size.width +
          particle.velocity.dx *
              progress *
              _ParticleConstants.velocityMultiplier;
      final currentY = particle.y * size.height +
          particle.velocity.dy *
              progress *
              _ParticleConstants.velocityMultiplier;

      // 画面外のパーティクルはスキップ
      if (currentX < -_ParticleConstants.screenBuffer ||
          currentX > size.width + _ParticleConstants.screenBuffer ||
          currentY < -_ParticleConstants.screenBuffer ||
          currentY > size.height + _ParticleConstants.screenBuffer) {
        continue;
      }

      // パーティクルの透明度を計算（時間とともに減少）
      final opacity = particle.opacity * (1.0 - progress) * (1.0 - progress);
      paint.color = color.withValues(alpha: opacity);

      // パーティクルのサイズを計算（時間とともに変化）
      final currentSize = particle.size *
          (1.0 + progress * _ParticleConstants.sizeGrowthMultiplier);

      // パーティクルを描画
      canvas.drawCircle(
        Offset(currentX, currentY),
        currentSize,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant ParticlesPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        !listEquals(oldDelegate.particles, particles);
  }
}

/// 集中線エフェクトを描画するPainter
class RadialBurstPainter extends CustomPainter {
  /// 集中線描画器を作成します。
  RadialBurstPainter({
    required this.lineCount,
    required this.scale,
    required this.opacity,
    required this.color,
  });

  /// 描画する線の本数
  final int lineCount;

  /// 線のスケール
  final double scale;

  /// 線の透明度
  final double opacity;

  /// 線の色
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = math.max(size.width, size.height) * scale;

    final paint = Paint()
      ..color = color.withValues(alpha: opacity)
      ..strokeWidth = _RadialBurstConstants.strokeWidth
      ..style = PaintingStyle.stroke;

    // 集中線を描画
    for (var i = 0; i < lineCount; i++) {
      final angle = (i / lineCount) * 2 * math.pi;
      final startRadius = _RadialBurstConstants.startRadiusMultiplier * scale;
      final endRadius = maxRadius;

      final startX = center.dx + math.cos(angle) * startRadius;
      final startY = center.dy + math.sin(angle) * startRadius;
      final endX = center.dx + math.cos(angle) * endRadius;
      final endY = center.dy + math.sin(angle) * endRadius;

      canvas.drawLine(
        Offset(startX, startY),
        Offset(endX, endY),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant RadialBurstPainter oldDelegate) {
    return oldDelegate.scale != scale ||
        oldDelegate.opacity != opacity ||
        oldDelegate.color != color;
  }
}

/// 進化に使用するポケモン画像コンポーネント。
class DsEvolutionPokemonImage extends StatelessWidget {
  /// 進化用ポケモン画像を作成します。
  const DsEvolutionPokemonImage({
    required this.imageUrl,
    required this.name,
    super.key,
    this.size = 150,
  });

  /// ポケモンの画像URL
  final String imageUrl;

  /// ポケモンの名前
  final String name;

  /// 画像のサイズ
  final double size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          child: ClipOval(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  child: Icon(
                    Icons.catching_pokemon,
                    size: size * 0.5,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
