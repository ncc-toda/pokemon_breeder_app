import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../design_tokens/ds_radius.dart';
import '../design_tokens/ds_spacing.dart';

/// デザインシステムのShimmerコンポーネント。
/// ローディング状態を示すためのShimmerエフェクトを提供する。
class DsShimmer extends StatelessWidget {
  /// Shimmerエフェクトを適用するWidgetを作成する。
  const DsShimmer({
    required this.child,
    super.key,
    this.enabled = true,
    this.baseColor,
    this.highlightColor,
  });

  /// Shimmerエフェクトを適用する子Widget
  final Widget child;

  /// Shimmerエフェクトを有効にするかどうか
  final bool enabled;

  /// ベースカラー（デフォルトは薄いグレー）
  final Color? baseColor;

  /// ハイライトカラー（デフォルトは白）
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return child;
    }

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: baseColor ??
          (isDark
              ? theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3)
              : theme.colorScheme.surfaceContainerHighest
                  .withValues(alpha: 0.1)),
      highlightColor: highlightColor ??
          (isDark
              ? theme.colorScheme.surface.withValues(alpha: 0.5)
              : Colors.white.withValues(alpha: 0.8)),
      child: child,
    );
  }
}

/// Pokemon一覧表示用のShimmerアイテム。
class DsPokemonListShimmer extends StatelessWidget {
  /// Pokemon一覧表示用のShimmerアイテムを作成する。
  const DsPokemonListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: DsSpacing.s),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DsRadius.m),
      ),
      child: ListTile(
        leading: DsShimmer(
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(DsRadius.s),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DsShimmer(
              child: Container(
                height: 16,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(DsRadius.xs),
                ),
              ),
            ),
            const SizedBox(height: 4),
            DsShimmer(
              child: Container(
                height: 12,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(DsRadius.xs),
                ),
              ),
            ),
          ],
        ),
        trailing: DsShimmer(
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(DsRadius.xs),
            ),
          ),
        ),
      ),
    );
  }
}

/// 汎用的なローディングShimmer。
class DsLoadingShimmer extends StatelessWidget {
  /// 汎用的なローディングShimmerを作成する。
  const DsLoadingShimmer({
    super.key,
    this.width = double.infinity,
    this.height = 20,
    this.borderRadius,
  });

  /// Shimmerの幅
  final double width;

  /// Shimmerの高さ
  final double height;

  /// Shimmerの角丸設定
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return DsShimmer(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(DsRadius.xs),
        ),
      ),
    );
  }
}
