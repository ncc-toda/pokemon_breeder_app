import 'package:flutter/material.dart';

import '../../design_system.dart' as ds;

/// ボタンの大きさを定義する列挙型。
enum DsButtonSize {
  /// スモールサイズ。
  small,

  /// ミディアムサイズ。
  medium,

  /// ラージサイズ。
  large;

  /// ボタンのサイズに応じた [TextStyle] を返す。
  TextStyle get fontStyle {
    switch (this) {
      case DsButtonSize.small:
        return ds.DsTypography.labelSmall;
      case DsButtonSize.medium:
        return ds.DsTypography.labelLarge;
      case DsButtonSize.large:
        return ds.DsTypography.labelLarge;
    }
  }

  /// ボタンのサイズに応じたアイコンサイズを返す。
  double get iconSize {
    switch (this) {
      case DsButtonSize.small:
        return 16;
      case DsButtonSize.medium:
        return 20;
      case DsButtonSize.large:
        return 24;
    }
  }

  /// アイコンのみのボタンのパディングを返す。
  EdgeInsetsGeometry get paddingForIconOnly {
    switch (this) {
      case DsButtonSize.small:
        return const EdgeInsets.all(8);
      case DsButtonSize.medium:
        return const EdgeInsets.all(10);
      case DsButtonSize.large:
        return const EdgeInsets.all(14);
    }
  }

  /// テキストまたはアイコンとテキストのボタンのパディングを返す。
  EdgeInsetsGeometry get paddingForTextOrIconText {
    switch (this) {
      case DsButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case DsButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 10);
      case DsButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 14);
    }
  }

  /// アイコンとテキストの間の間隔を返す。
  double get gap {
    switch (this) {
      case DsButtonSize.small:
        return 4;
      case DsButtonSize.medium:
        return 6;
      case DsButtonSize.large:
        return 8;
    }
  }

  /// ボタンの角丸の半径を返す。
  double get borderRadius {
    switch (this) {
      case DsButtonSize.small:
        return 6;
      case DsButtonSize.medium:
        return 8;
      case DsButtonSize.large:
        return 12;
    }
  }
}

/// ボタンのカラースキームや用途を定義する列挙型。
enum DsButtonType {
  /// 主色のボタン。
  primary,

  /// セカンダリ色のボタン。
  secondary,

  /// 三色目のボタン。
  tertiary,

  /// 破壊的なボタン。
  destructive;
}

/// アプリ内で使用する汎用的なボタン。
/// サイズと色のパターンを指定可能。
class DsButton extends StatelessWidget {
  /// AppButton のメインコンストラクタ。
  ///
  /// [icon] または [label] の少なくとも一方は指定する必要がる。
  const DsButton({
    required this.onPressed,
    super.key,
    this.size = DsButtonSize.medium,
    this.type = DsButtonType.primary,
    this.icon,
    this.label,
    this.isIconFirst = true,
    this.isExpanded = false,
  }) : assert(
          icon != null || label != null,
          'AppButton requires either an icon or a label.',
        );

  /// テキストのみを表示するボタン。
  factory DsButton.text({
    required String text,
    required VoidCallback? onPressed,
    Key? key,
    DsButtonSize size = DsButtonSize.medium,
    DsButtonType type = DsButtonType.primary,
    bool isExpanded = false,
  }) {
    return DsButton(
      key: key,
      onPressed: onPressed,
      label: text,
      size: size,
      type: type,
      isExpanded: isExpanded,
    );
  }

  /// アイコンのみを表示するボタン。
  factory DsButton.icon({
    required IconData icon,
    required VoidCallback? onPressed,
    Key? key,
    DsButtonSize size = DsButtonSize.medium,
    DsButtonType type = DsButtonType.primary,
    bool isExpanded = false,
  }) {
    return DsButton(
      key: key,
      onPressed: onPressed,
      icon: icon,
      size: size,
      type: type,
      isExpanded: isExpanded,
    );
  }

  /// アイコンとテキストを表示するボタン。
  factory DsButton.iconText({
    required IconData icon,
    required String label,
    required VoidCallback? onPressed,
    Key? key,
    DsButtonSize size = DsButtonSize.medium,
    DsButtonType type = DsButtonType.primary,
    bool isIconFirst = true,
    bool isExpanded = false,
  }) {
    return DsButton(
      key: key,
      onPressed: onPressed,
      icon: icon,
      label: label,
      size: size,
      type: type,
      isIconFirst: isIconFirst,
      isExpanded: isExpanded,
    );
  }

  /// ボタンが押されたときのコールバック。`null` の場合はボタンが無効化される。
  final VoidCallback? onPressed;

  /// ボタンのサイズ。デフォルトは [DsButtonSize.medium].
  final DsButtonSize size;

  /// ボタンのタイプ（カラースキーム）。デフォルトは [DsButtonType.primary].
  final DsButtonType type;

  /// ボタンに表示する [IconData].
  final IconData? icon;

  /// ボタンに表示するテキストラベル。
  final String? label;

  /// アイコンとテキストが両方存在する場合に、アイコンを先頭に表示するかどうか。
  ///
  /// デフォルトは `true`.（アイコンが先頭）
  final bool isIconFirst;

  /// ボタンの幅を親ウィジェットいっぱいに広げるかどうか。
  /// デフォルトは `false`（コンテンツに応じた幅）。
  final bool isExpanded;

  EdgeInsetsGeometry _getPadding() {
    if (icon != null && label == null) {
      return size.paddingForIconOnly;
    }
    return size.paddingForTextOrIconText;
  }

  Widget _buildChild() {
    final currentIconSize = size.iconSize;
    final currentGap = size.gap;

    if (icon != null && label != null) {
      final iconWidget = Icon(icon, size: currentIconSize);
      final textWidget = Text(label!);
      final spacer = SizedBox(width: currentGap);
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: isIconFirst
            ? [iconWidget, spacer, textWidget]
            : [textWidget, spacer, iconWidget],
      );
    } else if (label != null) {
      return Text(label!);
    } else {
      return Icon(icon, size: currentIconSize);
    }
  }

  ButtonStyle _buildStyle(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Color? bgColor;
    Color? fgColor;
    Color? overlayColor;
    double elevation = 2;
    BorderSide? side;

    switch (type) {
      case DsButtonType.primary:
        bgColor = colorScheme.primary;
        fgColor = colorScheme.onPrimary;
        overlayColor = colorScheme.onPrimary.withValues(alpha: 0.1);
      case DsButtonType.secondary:
        bgColor = colorScheme.secondary;
        fgColor = colorScheme.onSecondary;
        overlayColor = colorScheme.onSecondary.withValues(alpha: 0.1);
      case DsButtonType.tertiary:
        bgColor = Colors.transparent;
        fgColor = colorScheme.primary;
        overlayColor = colorScheme.primary.withValues(alpha: 0.05);
        elevation = 0;
      case DsButtonType.destructive:
        bgColor = colorScheme.error;
        fgColor = colorScheme.onError;
        overlayColor = colorScheme.onError.withValues(alpha: 0.1);
    }

    final disabledBackgroundColor = theme.disabledColor.withValues(alpha: 0.12);
    final disabledForegroundColor = theme.disabledColor.withValues(alpha: 0.38);

    return ElevatedButton.styleFrom(
      backgroundColor: bgColor,
      foregroundColor: fgColor,
      disabledBackgroundColor: disabledBackgroundColor,
      disabledForegroundColor: disabledForegroundColor,
      textStyle: size.fontStyle,
      padding: _getPadding(),
      elevation: elevation, // 既に double 型
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size.borderRadius),
        side: side ?? BorderSide.none,
      ),
      minimumSize: isExpanded ? const Size(double.infinity, 0) : null,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ).copyWith(
      overlayColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.hovered)) {
            return overlayColor?.withValues(alpha: 0.08);
          }
          if (states.contains(WidgetState.pressed)) {
            return overlayColor?.withValues(alpha: 0.12);
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = _buildStyle(context);
    final themeButtonStyle = Theme.of(context).elevatedButtonTheme.style;

    final finalStyle = themeButtonStyle != null
        ? themeButtonStyle.merge(effectiveStyle)
        : effectiveStyle;

    var child = _buildChild();
    if (isExpanded) {
      child = Center(child: child);
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: finalStyle,
      child: child,
    );
  }
}
