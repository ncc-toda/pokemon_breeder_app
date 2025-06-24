import 'dart:async';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:domain/domain.dart';

/// ナビゲーション処理を抽象化するインターフェース
abstract class EvolutionNavigationService {
  /// パーティ画面に戻り、状態を更新する
  Future<void> returnToPartyWithRefresh(WidgetRef ref);
}

/// GoRouterを使用したナビゲーション実装
class _GoRouterEvolutionNavigationService implements EvolutionNavigationService {
  const _GoRouterEvolutionNavigationService(this.context);
  
  final BuildContext context;

  @override
  Future<void> returnToPartyWithRefresh(WidgetRef ref) async {
    // パーティ画面の状態を更新
    ref.read(currentPartyStateProvider.notifier).reload();
    
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
    
    return _EvolutionResultContent(
      params: params,
      onReturnToParty: () => navigationService.returnToPartyWithRefresh(ref),
    );
  }
}

/// 進化結果画面のコンテンツ部分。
///
/// アニメーション管理と自動遷移機能を含みます。
class _EvolutionResultContent extends StatefulWidget {
  const _EvolutionResultContent({
    required this.params,
    required this.onReturnToParty,
  });

  final EvolutionResultParams params;
  final Future<void> Function() onReturnToParty;

  @override
  State<_EvolutionResultContent> createState() =>
      _EvolutionResultContentState();
}

class _EvolutionResultContentState extends State<_EvolutionResultContent>
    with TickerProviderStateMixin {
  late AnimationController _messageController;
  late Animation<double> _messageOpacity;
  late Animation<double> _messageScale;

  Timer? _autoTransitionTimer;
  bool _hasUserInteracted = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAutoTransitionTimer();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _autoTransitionTimer?.cancel();
    super.dispose();
  }

  void _initializeAnimations() {
    _messageController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _messageOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _messageController,
      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
    ));

    _messageScale = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _messageController,
      curve: const Interval(0.6, 1.0, curve: Curves.elasticOut),
    ));
  }

  void _startAutoTransitionTimer() {
    // 既存のTimerがあれば確実にキャンセル
    _autoTransitionTimer?.cancel();
    _autoTransitionTimer = Timer(
      const Duration(seconds: EvolutionResultPage.autoTransitionDelay),
      () {
        if (!_hasUserInteracted && mounted) {
          _returnToParty();
        }
      },
    );
  }

  void _onEvolutionAnimationComplete() {
    // 進化アニメーション完了後にメッセージを表示
    _messageController.forward();
  }

  void _onUserTap() {
    _hasUserInteracted = true;
    _autoTransitionTimer?.cancel();
    _returnToParty();
  }

  void _returnToParty() {
    widget.onReturnToParty();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _onUserTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.2,
              colors: [
                theme.colorScheme.primary.withValues(alpha: 0.1),
                Colors.black,
              ],
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                // メイン進化アニメーション
                Center(
                  child: DsEvolutionSequence(
                    beforePokemon: DsEvolutionPokemonImage(
                      imageUrl: widget.params.beforePokemon.imageUrl,
                      name: widget.params.beforePokemon.displayName,
                      size: 200,
                    ),
                    afterPokemon: DsEvolutionPokemonImage(
                      imageUrl: widget.params.afterPokemon.imageUrl,
                      name: widget.params.afterPokemon.displayName,
                      size: 200,
                    ),
                    duration: const Duration(seconds: 3),
                    onComplete: _onEvolutionAnimationComplete,
                  ),
                ),

                // 祝福メッセージ
                Positioned(
                  top: 80,
                  left: 20,
                  right: 20,
                  child: AnimatedBuilder(
                    animation: _messageController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _messageOpacity.value,
                        child: Transform.scale(
                          scale: _messageScale.value,
                          child: Column(
                            children: [
                              Text(
                                'おめでとう！',
                                style: theme.textTheme.headlineLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: theme.colorScheme.primary,
                                      blurRadius: 20,
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${widget.params.beforePokemon.displayName}は\n${widget.params.afterPokemon.displayName}に進化した！',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  shadows: [
                                    const Shadow(
                                      color: Colors.black54,
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // インタラクションヒント
                Positioned(
                  bottom: 40,
                  left: 20,
                  right: 20,
                  child: AnimatedBuilder(
                    animation: _messageController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _messageOpacity.value * 0.7,
                        child: Text(
                          'タップしてパーティに戻る',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white70,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
