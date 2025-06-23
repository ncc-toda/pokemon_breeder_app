import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_breeder_app/pages/party_page.dart';
// Pages
import 'package:pokemon_breeder_app/pages/pokedex_page.dart';
import 'package:pokemon_breeder_app/pages/evolution_confirmation_page.dart';
import 'package:pokemon_breeder_app/pages/evolution_result_page.dart';

/// アプリ全体で使用する [GoRouter] インスタンス。
///
/// - ルート構成は [StatefulShellRoute.indexedStack] を利用し、
///   ボトムナビゲーションバーでタブを切り替えても各タブの状態を保持する。
/// - 主要タブは以下の 2 つ。
///   1. 図鑑 (`/pokedex`)
///   2. パーティ (`/party`)
final goRouter = GoRouter(
  initialLocation: '/pokedex',
  navigatorKey: _rootNavigatorKey,
  routes: [
    // 進化確認画面（フルスクリーンモーダル）
    GoRoute(
      path: '/evolution-confirmation',
      name: 'evolution-confirmation',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        final params = state.extra as EvolutionConfirmationParams;
        return MaterialPage(
          child: EvolutionConfirmationPage(params: params),
        );
      },
    ),
    // 進化結果画面（フルスクリーンモーダル）
    GoRoute(
      path: '/evolution-result',
      name: 'evolution-result',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final params = EvolutionResultParams(
          beforePokemon: extra['beforePokemon'],
          afterPokemon: extra['afterPokemon'],
          message: extra['message'],
        );
        return MaterialPage(
          child: EvolutionResultPage(params: params),
        );
      },
    ),
    // ボトムナビゲーション & タブ保持用の ShellRoute
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: NavigationBar(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: navigationShell.goBranch,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.search),
                label: '図鑑',
              ),
              NavigationDestination(
                icon: Icon(Icons.pets),
                label: 'パーティ',
              ),
            ],
          ),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/pokedex',
              name: 'pokedex',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: PokedexPage(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/party',
              name: 'party',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: PartyPage(),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);

final _rootNavigatorKey = GlobalKey<NavigatorState>();
