import 'package:flutter/material.dart';

/// アイコンの種別。
enum DsIconType {
  /// 小さいアイコン。
  small,

  /// 大きいアイコン。
  large;

  /// 種別に応じたアイコンのサイズを返す。
  double get size => switch (this) {
        small => 16,
        large => 24,
      };
}

/// アイコン。
class DsIcon extends StatelessWidget {
  /// 小さいアイコン。
  const DsIcon.small({
    required this.icon,
    required this.color,
    super.key,
  }) : type = DsIconType.small;

  /// 大きいアイコン。
  const DsIcon.large({
    required this.icon,
    required this.color,
    super.key,
  }) : type = DsIconType.large;

  /// 表示するアイコン。
  final IconData icon;

  /// アイコンの色。
  final Color color;

  /// アイコンのサイズ。
  final DsIconType type;

  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: type.size, color: color);
  }
}

/// アイコンボタン。
class DsIconButton extends StatelessWidget {
  /// 小さいアイコンボタン。
  const DsIconButton.small({
    required this.icon,
    required this.onTap,
    required this.color,
    super.key,
  }) : type = DsIconType.small;

  /// 大きいアイコンボタン。
  const DsIconButton.large({
    required this.icon,
    required this.onTap,
    required this.color,
    super.key,
  }) : type = DsIconType.large;

  /// 表示するアイコン。
  final IconData icon;

  /// タップ時のコールバック。
  final VoidCallback? onTap;

  /// アイコンの色。
  final Color color;

  /// アイコンの種別。
  final DsIconType type;

  @override
  Widget build(BuildContext context) {
    final iconWidget = switch (type) {
      DsIconType.small => DsIcon.small(icon: icon, color: color),
      DsIconType.large => DsIcon.large(icon: icon, color: color),
    };

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: iconWidget,
      ),
    );
  }
}
