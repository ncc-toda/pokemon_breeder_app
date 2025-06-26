import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:domain/domain.dart';
import 'package:pokemon_breeder_app/ui/features/evolution/components/evolution_result_content.dart';

/// ナビゲーション処理を抽象化するインターフェース
abstract class EvolutionNavigationService {
  /// パーティ画面に戻り、状態を更新する
  Future<void> returnToPartyWithRefresh(WidgetRef ref);
}

/// GoRouterを使用したナビゲーション実装
class _GoRouterEvolutionNavigationService
    implements EvolutionNavigationService {
  const _GoRouterEvolutionNavigationService(this.context);

  final BuildContext context;

  @override
  Future<void> returnToPartyWithRefresh(WidgetRef ref) async {
    // パーティ画面の状態を更新
    final result = await ref.read(currentPartyStateProvider.notifier).reload();
    result.when(
      success: (_) => {},
      failure: (failure) {
        debugPrint(
            'Failed to reload party after evolution: ${failure.message}');
      },
    );

    // パーティ画面に戻る
    if (context.mounted) {
      context.go('/party');
    }
  }
}

/// 進化結果画面のパラメータ。
class EvolutionResultParams {
  const EvolutionResultParams({
    required this.beforePokemon,
    required this.afterPokemon,
    required this.message,
  });

  /// 進化前のポケモン
  final Pokemon beforePokemon;

  /// 進化後のポケモン
  final Pokemon afterPokemon;

  /// 結果メッセージ
  final String message;
}

class EvolutionResultPage extends HookConsumerWidget {
  const EvolutionResultPage({
    super.key,
    required this.params,
  });

  final EvolutionResultParams params;

  /// 自動遷移までの時間（秒）
  static const int autoTransitionDelay = 4;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationService = _GoRouterEvolutionNavigationService(context);

    return EvolutionResultContent(
      config: EvolutionResultContentConfig(
        beforePokemon: params.beforePokemon,
        afterPokemon: params.afterPokemon,
        message: params.message,
        onReturnToParty: () => navigationService.returnToPartyWithRefresh(ref),
        autoTransitionDelay: autoTransitionDelay,
      ),
    );
  }
}

