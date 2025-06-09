---
description: Defines the app package structure and responsibilities.
globs: packages/app/**/*.dart
alwaysApply: false
---

# App パッケージ

## 概要

`app` パッケージは、アプリケーションの UI 層とエントリーポイントを担当します。ユーザーインターフェースの実装、画面遷移、状態管理のフックなどを含みます。

## ディレクトリ構造

```bash
packages/app/
└── lib/
    ├── core/                    # アプリ全体で使用する共通機能
    │   ├── constants/          # 定数定義
    │   ├── extensions/         # 拡張メソッド
    │   └── routes/            # ルーティング設定
    ├── hooks/                  # 共通カスタムフック
    ├── states/                 # グローバル状態管理
    ├── ui/                     # UI関連
    │   ├── pages/             # 画面Widget
    │   └── features/          # 機能別コンポーネント
    └── main.dart              # エントリーポイント
```

## 各ディレクトリの詳細

### core/

アプリケーション全体で使用される共通機能を配置します。

- **constants/**: アプリ全体で使用する定数
- **extensions/**: Dart 標準クラスの拡張メソッド
- **routes/**: 画面遷移のルーティング定義

### hooks/

複数の Widget で共通して使用するカスタムフックを配置します。

- ファイル命名規則: `{機能名}_hook.dart`
- 例: `use_loading_hook.dart`, `use_pagination_hook.dart`

### states/

グローバルに保持する必要がある状態を管理します。

- **原則**: 状態は可能な限りローカルで管理し、本当に必要な場合のみグローバル化
- ファイル命名規則: `{状態名}_state.dart`
- 例: `auth_state.dart`, `app_settings_state.dart`

### ui/pages/

各画面に相当する Widget を配置します。

- ファイル命名規則: `{画面名}_page.dart`
- 例: `home_page.dart`, `pokemon_detail_page.dart`
- 各ページは独立したルートとして機能

### ui/features/

機能や関心事ごとに分割された UI コンポーネントを配置します。

```bash
features/
└── {feature_name}/
    ├── components/    # その機能専用のコンポーネント
    │   └── {component_name}.dart
    └── hooks/        # その機能専用のカスタムフック
        └── {hook_name}_hook.dart
```

例：

```bash
features/
└── pokemon_list/
    ├── components/
    │   ├── pokemon_card.dart
    │   └── pokemon_filter.dart
    └── hooks/
        └── use_pokemon_list_hook.dart
```

## 実装ガイドライン

### 1. 責務の分離

- UI ロジックのみを扱い、ビジネスロジックは domain パッケージに委譲
- データ取得は domain パッケージの use case や state を通じて行う

### 2. 状態管理

- ローカル状態 ( ephemeral state ) はフックで管理
- グローバル状態 ( global state ) は Riverpod を使用して管理
  - 極力グローバル状態を使用しないようにする
- ViewModel や Controller は使用せず、各 Widget 内で状態管理やビジネスロジックの呼び出しを行う

### 3. コンポーネント設計

- 再利用可能なコンポーネントは design_system パッケージに配置
- 機能固有のコンポーネントは features ディレクトリに配置

### 4. 命名規則

- ページ: `{名前}_page.dart`
- コンポーネント: `{名前}.dart`
- フック: `use_{機能}_hook.dart`
- 状態: `{名前}_state.dart`

## 依存関係

- design_system: UI コンポーネントとデザイントークン
- domain: ビジネスロジックとデータアクセス
- flutter_hooks: フック機能
- hooks_riverpod: 状態管理
