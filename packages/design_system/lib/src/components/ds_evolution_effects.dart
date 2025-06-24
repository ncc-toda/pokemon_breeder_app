/// 進化エフェクト用のアニメーションコンポーネント群。
library;

import 'dart:math' as math;
import 'package:flutter/material.dart';

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
        size: random.nextDouble() * 6 + 2,
        opacity: random.nextDouble() * 0.8 + 0.2,
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
class Particle {
  /// パーティクルを作成します。
  Particle({
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
      final currentX =
          particle.x * size.width + particle.velocity.dx * progress * 100;
      final currentY =
          particle.y * size.height + particle.velocity.dy * progress * 100;

      // 画面外のパーティクルはスキップ
      if (currentX < -50 ||
          currentX > size.width + 50 ||
          currentY < -50 ||
          currentY > size.height + 50) {
        continue;
      }

      // パーティクルの透明度を計算（時間とともに減少）
      final opacity = particle.opacity * (1.0 - progress) * (1.0 - progress);
      paint.color = color.withValues(alpha: opacity);

      // パーティクルのサイズを計算（時間とともに変化）
      final currentSize = particle.size * (1.0 + progress * 2);

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
    return oldDelegate.progress != progress || oldDelegate.color != color;
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
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    // 集中線を描画
    for (var i = 0; i < lineCount; i++) {
      final angle = (i / lineCount) * 2 * math.pi;
      final startRadius = 50.0 * scale;
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
