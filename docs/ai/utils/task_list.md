承知いたしました。
プロジェクトの仕様書(`docs/specification/`配下)と既存のソースコードを確認し、残りのタスクを洗い出しました。

各タスクは、1 つの Issue（Pull Request）として扱いやすい粒度に分割しています。
洗い出したタスク一覧を、プロジェクトルートに`REMAINING_TASKS.md`として出力します。

```markdown
# 残存タスク一覧

プロジェクトの仕様書と現状の実装を比較し、残っているタスクを洗い出しました。
各タスクは 1 つの Issue（Pull Request）として扱いやすい粒度に分割しています。

---

## フェーズ 1: 基盤整備

アプリケーションの基本的な構造とアーキテクチャを整備します。

### 1. `domain`および`data`パッケージの作成と Riverpod の導入

- **概要:** クリーンアーキテクチャの基盤を整えるため、`domain`と`data`パッケージを作成し、プロジェクト全体で Riverpod を利用できるようにします。
- **主な作業内容:**
  - `packages/`配下に`domain`, `data`ディレクトリを作成し、それぞれの`pubspec.yaml`を設定。
  - ルートの`pubspec.yaml`で`workspace`を有効化。
  - `app`パッケージに`riverpod`を導入し、`main.dart`に`ProviderScope`をラップ。
- **対象ファイル/ディレクトリ:**
  - `pubspec.yaml`
  - `packages/app/lib/main.dart`
  - `packages/domain/` (新規)
  - `packages/data/` (新規)

### 2. ナビゲーションとルーティングの導入 (GoRouter)

- **概要:** `navigation.md`に基づき、ボトムナビゲーションバーと画面遷移を実装します。ルーティングには GoRouter を使用し、タブ間の状態は`StatefulShellRoute`で保持します。
- **主な作業内容:**
  - `go_router`パッケージを`app`に追加。
  - ボトムナビゲーションバーを持つ`Scaffold`を実装。
  - 図鑑画面、パーティ画面などの主要なルートを定義。
- **対象ファイル/ディレクトリ:**
  - `packages/app/pubspec.yaml`
  - `packages/app/lib/main.dart`
  - `packages/app/lib/core/routes/router.dart` (新規)

### 3. ローカル DB (drift) のセットアップ

- **概要:** パーティ情報や育成カウンターの状態を永続化するため、ローカルデータベースを導入します。`data`パッケージに`drift`を設定し、テーブル定義を行います。
- **主な作業内容:**
  - `data`パッケージに`drift`および関連パッケージを追加。
  - ポケモンパーティ用のテーブルを定義。
  - DB のインスタンスを提供する Provider を作成。
- **対象ファイル/ディレクトリ:**
  - `packages/data/pubspec.yaml`
  - `packages/data/lib/src/services/local_storage/` (新規)

### 4. データ層 (PokeAPI) のセットアップ

- **概要:** `data`パッケージに PokeAPI と通信するための`ApiClient`と DTO を実装します。通信には`dio`、モデルクラスには`freezed`を使用します。
- **主な作業内容:**
  - `data`パッケージに`dio`, `freezed`等を追加。
  - `ApiClient`クラスを作成し、GET リクエストの基本ロジックを実装。
  - PokeAPI のレスポンスに対応する DTO クラスを`freezed`で作成。
  - ポケモンデータを取得する`PokemonService`を実装。
- **対象ファイル/ディレクトリ:**
  - `packages/data/lib/src/services/api/api_client.dart` (新規)
  - `packages/data/lib/src/services/pokemon/` (新規)

---

## フェーズ 2: 図鑑機能

図鑑画面の機能を仕様通りに実装します。

### 5. 図鑑画面のポケモンリスト表示と無限スクロール

- **概要:** `domain`層にエンティティとリポジトリ(State)を実装し、`PokedexPage`で API から取得したポケモン一覧を無限スクロールで表示します。
- **主な作業内容:**
  - `domain`層に`Pokemon`エンティティと`PokemonState`リポジトリを作成。
  - `PokedexPage`で`PokemonState`を`watch`し、リストデータを表示。
  - `ListView`のスクロールを検知して次ページのデータを読み込むロジックを実装。
  - ポケモンセルの UI を仕様通りに修正（画像、名前、図鑑番号）。画像表示には`cached_network_image`を使用。
- **対象ファイル/ディレクトリ:**
  - `packages/domain/lib/src/features/pokemon/` (新規)
  - `packages/app/lib/pages/pokedex_page.dart`

### 6. 図鑑画面のローディングおよびエラー表示

- **概要:** データ取得中のローディング（Shimmer エフェクト）と、取得失敗時のエラーメッセージおよびリトライ機能を実装し、UX を向上させます。
- **主な作業内容:**
  - `shimmer`パッケージを導入。
  - データ取得状態に応じて、ローディング表示、エラー表示、データ表示を切り替える。
- **対象ファイル/ディレクトリ:**
  - `packages/design_system/` (Shimmer コンポーネントを追加)
  - `packages/app/lib/pages/pokedex_page.dart`

### 7. 図鑑画面の検索機能

- **概要:** `pokedex_page.md`の仕様に基づき、検索バー UI と、ポケモン名または図鑑番号での検索機能を実装します。
- **主な作業内容:**
  - `PokedexPage`に`TextField`を配置した検索バーを実装。
  - 入力値をもとに`PokemonState`に検索をリクエストし、結果を UI に反映。
- **対象ファイル/ディレクトリ:**
  - `packages/app/lib/pages/pokedex_page.dart`
  - `packages/domain/lib/src/features/pokemon/pokemon_state.dart`

---

## フェーズ 3: パーティ機能

パーティ編成と管理機能を実装します。

### 8. パーティ情報の永続化と表示

- **概要:** `PartyPage`でローカル DB からパーティ情報を読み込み、6 つのスロットに表示します。空スロットと設定済みスロットを出し分け、現状のダミー実装を置き換えます。
- **主な作業内容:**
  - `domain`層にパーティ情報を管理する`PartyState`リポジトリを作成。
  - `PartyPage`で`PartyState`を`watch`し、パーティ情報を表示。
  - スロットが空の場合は「+」アイコンを表示し、タップで図鑑画面へ遷移させる。
- **対象ファイル/ディレクトリ:**
  - `packages/domain/lib/src/features/party/` (新規)
  - `packages/app/lib/pages/party_page.dart`

### 9. パーティへのポケモンの追加・削除

- **概要:** 図鑑画面からパーティにポケモンを追加する機能と、パーティ画面からポケモンを削除する機能を実装します。
- **主な作業内容:**
  - 図鑑画面の各ポケモンに「+」ボタンを配置し、タップでパーティに追加するロジックを実装。パーティが 6 匹の場合はボタンを非活性化。
  - パーティ画面のポケモンを長押しすると削除確認ダイアログを表示し、「はい」で削除するロジックを実装。
- **対象ファイル/ディレクトリ:**
  - `packages/app/lib/pages/pokedex_page.dart`
  - `packages/app/lib/pages/party_page.dart`
  - `packages/domain/lib/src/features/party/party_state.dart`

---

## フェーズ 4: ポケモン育成機能

ポケモンの進化・退化に関する一連の機能を実装します。

### 10. 育成カウンターの実装

- **概要:** `PartyPage`の各ポケモンに進化・退化カウンターを実装します。タップによるカウントアップと DB への保存、進化・退化の可否に応じた UI の出し分けを行います。
- **主な作業内容:**
  - ポケモンカード内にカウンター UI を実装。
  - タップイベントでカウントを更新し、DB に保存するロジックを`PartyState`に実装。
  - ポケモンの進化情報に基づき、カウンターの活性/非活性を制御。
- **対象ファイル/ディレクトリ:**
  - `packages/app/lib/pages/party_page.dart`
  - `packages/domain/lib/src/features/party/party_state.dart`

### 11. 進化・退化確認画面の実装

- **概要:** 育成カウンターが規定回数に達した際に`EvolutionConfirmationPage`へ遷移し、進化前後のポケモン情報を表示します。承認・キャンセル処理も実装します。
- **主な作業内容:**
  - 前画面から渡されたデータを元に、進化前・後のポケモン情報を動的に表示。
  - 「承認」ボタンで進化処理（Use Case）を呼び出し、結果画面へ遷移。
  - 「キャンセル」ボタンでパーティ画面へ戻る。
- **対象ファイル/ディレクトリ:**
  - `packages/domain/lib/src/features/pokemon/evolve_pokemon_use_case.dart` (新規)
  - `packages/app/lib/pages/evolution_confirmation_page.dart`

### 12. 進化・退化結果画面の実装

- **概要:** `EvolutionResultPage`で進化結果を表示し、仕様に沿ったアニメーション演出を実装します。その後、自動またはタップでパーティ画面に戻ります。
- **主な作業内容:**
  - 進化後のポケモン情報を表示。
  - 仕様に基づいたリッチなアニメーション（例: 発光エフェクト、拡大表示）を実装。
  - 一定時間経過または画面タップでパーティ画面へ自動遷移するロジックを実装。
- **対象ファイル/ディレクトリ:**
  - `packages/app/lib/pages/evolution_result_page.dart`

---

## フェーズ 5: 非機能要件

アプリケーション全体の品質を向上させるためのタスクです。

### 13. Flavor 対応

- **概要:** `dev`と`prod`の Flavor を設定し、ビルド構成を分離します。これにより、開発用と本番用で API エンドポイントや設定を切り替えられるようにします。
- **主な作業内容:**
  - `main_dev.dart`, `main_prod.dart`を作成。
  - `build.gradle` (Android) と Xcode プロジェクト (iOS) で Flavor/Scheme 設定を行う。
- **対象ファイル/ディレクトリ:**
  - `packages/app/lib/`
  - `android/app/`
  - `ios/`

### 14. オフライン対応

- **概要:** ネットワーク接続状態を監視し、オフライン時にはその旨をユーザーに通知するダイアログを表示します。
- **主な作業内容:**
  - `connectivity_plus`パッケージを導入。
  - ネットワーク状態を監視する Provider を作成。
  - 状態に応じてアプリ全体でモーダルダイアログを表示。
- **対象ファイル/ディレクトリ:**
  - `packages/app/lib/core/network/` (新規)
  - `packages/app/lib/main.dart`
```
