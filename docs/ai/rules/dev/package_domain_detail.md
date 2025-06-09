---
description: Defines the domain package structure and responsibilities.
globs:
alwaysApply: true
---

# Domain パッケージ

## 概要

`domain` パッケージは、アプリケーションのビジネスロジック層を担当します。エンティティ、ユースケース、ビジネスルールの実装を含み、UI やデータソースから独立した純粋なビジネスロジックを提供します。

## ディレクトリ構造

```bash
packages/domain/
├── lib/
│   └── src/
│       ├── core/                    # ドメイン層の共通機能
│       │   ├── constants/          # ドメイン層の定数
│       │   ├── converters/         # データ変換ロジック
│       │   ├── errors/             # エラー定義
│       │   ├── extensions/         # 拡張メソッド
│       │   └── result/             # Result型定義
│       └── features/               # 機能別ビジネスロジック
│           └── {feature_name}/     # 各機能のドメインロジック
└── domain.dart                     # パッケージエントリーポイント
```

## 各ディレクトリの詳細

### core/

ドメイン層全体で使用される共通機能を配置します。

#### constants/

- ビジネスルールに関する定数
- 例: 最大ポケモン数、レベル上限値など

#### converters/

- データ形式の変換ロジック
- 例: `json_converter.dart`, `date_converter.dart`

#### errors/

エラーハンドリングのための型定義：

- **domain_exception.dart**: ドメイン層がスローする例外

  ```dart
  class DomainException implements Exception {
    final String message;
    final String? code;
    DomainException(this.message, {this.code});
  }
  ```

- **domain_failure.dart**: Result 型で使用する失敗を表す型
  ```dart
  abstract class DomainFailure {
    final String message;
    DomainFailure(this.message);
  }
  ```

#### extensions/

- ドメインモデルや Dart 標準型の拡張メソッド

#### result/

- **result.dart**: 成功/失敗を表現する Result 型

  ```dart
  sealed class Result<S, F> {
    const Result();
  }

  class Success<S, F> extends Result<S, F> {
    final S value;
    const Success(this.value);
  }

  class Failure<S, F> extends Result<S, F> {
    final F failure;
    const Failure(this.failure);
  }
  ```

### features/

機能や関心事ごとに分割されたビジネスロジックを配置します。

```bash
features/
└── {feature_name}/
    ├── {entity_name}.dart      # エンティティ
    ├── {use_case_name}_use_case.dart  # ユースケース
    └── {state_name}_state.dart # 状態管理（リポジトリ的役割）
```

#### エンティティ

- ビジネスオブジェクトの定義
- 不変（immutable）で実装
- ビジネスルールを含む
- 例: `pokemon.dart`, `trainer.dart`

#### ユースケース

- 単一のビジネス操作を表現
- 1 つのユースケース = 1 つの機能
- 例: `catch_pokemon_use_case.dart`, `evolve_pokemon_use_case.dart`

#### State（リポジトリ的役割）

- データ層のサービスを呼び出し、値を加工して保持
- ドメインモデルへの変換を担当
- 例: `pokemon_state.dart`, `trainer_state.dart`

```dart
// pokemon_state.dart

// PokemonState Provider
@riverpod
class PokemonState extends _$PokemonState {
  @override
  AsyncValue<List<Pokemon>> build() {
    return const AsyncValue.loading();
  }

  Future<void> fetchPokemons() async {
    state = const AsyncValue.loading();

    final pokemonService = ref.watch(pokemonServiceProvider);
    final result = await pokemonService.fetchPokemons();

    result.when(
      success: (pokemonDtos) {
        final pokemons = pokemonDtos.map(_convertToEntity).toList();
        state = AsyncValue.data(pokemons);
      },
      failure: (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
      },
    );
  }

  Pokemon _convertToEntity(PokemonDto dto) {
    return Pokemon(
      id: dto.id,
      name: dto.name,
      level: dto.level,
      types: dto.types.map((t) => PokemonType.fromString(t)).toList(),
      stats: PokemonStats.fromMap(dto.stats),
    );
  }
}
```

## 実装例

### Pokemon 機能の例

```bash
features/
└── pokemon/
    ├── pokemon.dart                 # Pokemonエンティティ
    ├── pokemon_stats.dart          # 統計情報エンティティ
    ├── catch_pokemon_use_case.dart # 捕獲ユースケース
    ├── evolve_pokemon_use_case.dart # 進化ユースケース
    └── pokemon_state.dart          # Pokemon状態管理
```

### エンティティの例

```dart
// pokemon.dart
@freezed
class Pokemon with _$Pokemon {
  const factory Pokemon({
    required String id,
    required String name,
    required int level,
    required List<PokemonType> types,
    required PokemonStats stats,
  }) = _Pokemon;

  const Pokemon._();

  // ビジネスルール
  bool canEvolve() => level >= 16;
  int experienceToNextLevel() => level * 100;
}
```

### ユースケースの例

```dart
// catch_pokemon_use_case.dart

// CatchPokemonUseCase Provider
@riverpod
CatchPokemonUseCase catchPokemonUseCase(Ref ref) {
  final pokemonState = ref.watch(pokemonStateProvider);
  return CatchPokemonUseCase(pokemonState);
}

class CatchPokemonUseCase {
  final PokemonState _pokemonState;

  CatchPokemonUseCase(this._pokemonState);

  Future<Result<Pokemon, DomainFailure>> execute({
    required String pokemonId,
    required String trainerId,
  }) async {
    // ビジネスロジックの実装
  }
}
```

## 実装ガイドライン

### 1. 純粋性の維持

- UI 層やデータ層に依存しない
- ビジネスロジックのみに集中
- 外部ライブラリへの依存を最小限に

### 2. エラーハンドリング

- Result 型を使用して成功/失敗を表現
- 例外は`DomainException`を使用
- 失敗は`DomainFailure`で表現

### 3. 不変性

- エンティティは不変（immutable）で実装
- freezed パッケージの使用を推奨

### 4. 単一責任の原則

- 1 つのユースケース = 1 つの機能
- エンティティは自身に関するビジネスルールのみを持つ

### 5. 命名規則

- エンティティ: `{名前}.dart`
- ユースケース: `{動作}_{対象}_use_case.dart`
- State: `{名前}_state.dart`

## 依存関係

- freezed: イミュータブルクラスの生成
- riverpod_annotation: Riverpod のコード生成
- riverpod: 状態管理
- data: データ層パッケージ（State クラスから使用）

## Provider 実装の追加ガイドライン

### 1. インポート

各ファイルには以下のインポートを含める：

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '{ファイル名}.g.dart';
```

### 2. State Provider のパターン

- 関数ベース、もしくはクラスベースの Provider を使用して状態を管理
  - 副作用を伴う場合はクラスベース、そうでない場合は関数ベースの Provider を使う
- データ層サービスとの連携
- DTO からエンティティへの変換

### 3. UseCase Provider のパターン

- 必要な State やサービスを依存関係として注入
- シンプルなファクトリ関数として実装

### 4. 使用例

```dart
// UIレイヤーでの使用例
class PokemonListPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonsAsync = ref.watch(pokemonStateProvider);
    final catchUseCase = ref.watch(catchPokemonUseCaseProvider);

    return pokemonsAsync.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
      data: (pokemons) => ListView.builder(
        itemCount: pokemons.length,
        itemBuilder: (context, index) {
          final pokemon = pokemons[index];
          return ListTile(
            title: Text(pokemon.name),
            onTap: () => catchUseCase.execute(
              pokemonId: pokemon.id,
              trainerId: 'trainer_id',
            ),
          );
        },
      ),
    );
  }
}
```
