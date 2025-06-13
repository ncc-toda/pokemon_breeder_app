import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_breeder_app/pages/party_page.dart';
// Pages
import 'package:pokemon_breeder_app/pages/pokedex_page.dart';

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
