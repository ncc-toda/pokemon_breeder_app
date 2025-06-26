import 'package:flutter/material.dart';

import '../design_tokens/ds_padding.dart';
import '../design_tokens/ds_radius.dart';
import '../design_tokens/ds_spacing.dart';
import '../design_tokens/ds_typography.dart';

/// デザインシステムの検索バーコンポーネント。
class DsSearchBar extends StatelessWidget {
  /// 検索バーコンポーネントを作成する。
  const DsSearchBar({
    super.key,
    this.controller,
    this.hintText = '検索...',
    this.onChanged,
    this.onClear,
    this.autofocus = false,
  });

  /// テキスト入力のコントローラー
  final TextEditingController? controller;

  /// プレースホルダーテキスト
  final String hintText;

  /// テキスト変更時のコールバック
  final ValueChanged<String>? onChanged;

  /// クリアボタン押下時のコールバック
  final VoidCallback? onClear;

  /// 自動フォーカス設定
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final hasValue = controller?.text.isNotEmpty ?? false;

    return Container(
      padding: DsPadding.allS,
      child: TextField(
        controller: controller,
        autofocus: autofocus,
        onChanged: onChanged,
        style: DsTypography.bodyMedium,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: DsTypography.bodyMedium.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          suffixIcon: hasValue
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  onPressed: () {
                    controller?.clear();
                    onClear?.call();
                    onChanged?.call('');
                  },
                )
              : null,
          filled: true,
          fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DsRadius.m),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DsRadius.m),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: DsSpacing.m,
            vertical: DsSpacing.s,
          ),
        ),
      ),
    );
  }
}

/// 検索結果の状態を表示するウィジェット。
class DsSearchResultInfo extends StatelessWidget {
  /// 検索結果情報ウィジェットを作成する。
  const DsSearchResultInfo({
    required this.resultCount,
    super.key,
    this.query = '',
    this.onClear,
  });

  /// 検索クエリ
  final String query;

  /// 検索結果数
  final int resultCount;

  /// クリア操作のコールバック
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    if (query.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DsSpacing.m,
        vertical: DsSpacing.s,
      ),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 16,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: DsSpacing.s),
          Expanded(
            child: Text(
              '"$query" の検索結果: $resultCount件',
              style: DsTypography.bodySmall.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          if (onClear != null)
            TextButton(
              onPressed: onClear,
              child: Text(
                'クリア',
                style: DsTypography.labelSmall.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// 検索結果が空の場合の表示ウィジェット。
class DsSearchEmptyState extends StatelessWidget {
  /// 検索結果が空の場合の表示ウィジェットを作成する。
  const DsSearchEmptyState({
    super.key,
    this.query = '',
    this.onClear,
    this.emptyMessage,
    this.suggestionMessage,
  });

  /// 検索クエリ
  final String query;

  /// クリア操作のコールバック
  final VoidCallback? onClear;

  /// 検索結果が見つからない場合のメッセージ
  final String? emptyMessage;

  /// 検索提案メッセージ
  final String? suggestionMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: DsPadding.allL,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: DsSpacing.m),
            Text(
              emptyMessage ?? '"$query" に一致する項目が見つかりませんでした',
              style: DsTypography.titleMedium.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: DsSpacing.s),
            Text(
              suggestionMessage ?? '別のキーワードで検索してみてください',
              style: DsTypography.bodySmall.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (onClear != null) ...[
              const SizedBox(height: DsSpacing.l),
              ElevatedButton(
                onPressed: onClear,
                child: const Text('検索をクリア'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
