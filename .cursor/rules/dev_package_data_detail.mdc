---
description: Defines the data package structure and responsibilities.
globs: packages/data/**/*.dart
alwaysApply: false
---

# Data パッケージ

## 概要

`data` パッケージは、アプリケーションのデータ層を担当します。外部データソース（API、データベース、ローカルストレージなど）との通信、データの取得・保存、データモデルの定義を行います。

## ディレクトリ構造

```bash
packages/data/
├── lib/
│   └── src/
│       ├── core/                    # データ層の共通機能
│       │   ├── constants/          # データ層の定数
│       │   └── errors/             # エラー定義
│       │       ├── data_exception.dart
│       │       └── data_failure.dart
│       └── services/               # 各種サービス実装
│           ├── api/                # API関連
│           │   ├── model/          # APIモデル
│           │   └── api_client.dart # APIクライアント
│           └── {service_name}/     # 各サービス
│               ├── model/          # サービス固有モデル
│               └── {service_name}_service.dart
└── data.dart                       # パッケージエントリーポイント
```

## 各ディレクトリの詳細

### core/

データ層全体で使用される共通機能を配置します。

#### constants/

- API 関連の定数（タイムアウト値、リトライ回数など）
- データベース設定値
- キャッシュ設定

#### errors/

エラーハンドリングのための型定義：

- **data_exception.dart**: データ層がスローする例外

  ```dart
  class DataException implements Exception {
    final String message;
    final String? code;
    final int? statusCode;
    final dynamic originalError;

    DataException(
      this.message, {
      this.code,
      this.statusCode,
      this.originalError,
    });
  }
  ```

- **data_failure.dart**: Result 型で使用する失敗を表す型

  ```dart
  abstract class DataFailure {
    final String message;
    DataFailure(this.message);
  }

  class NetworkFailure extends DataFailure {
    NetworkFailure(super.message);
  }

  class CacheFailure extends DataFailure {
    CacheFailure(super.message);
  }
  ```

### services/

各種データソースとの通信を担当するサービスを配置します。

#### api/

REST API との通信を担当します。

- **api_client.dart**: HTTP クライアントのラッパー

  ```dart
  // Provider定義
  @riverpod
  ApiClient apiClient(Ref ref) {
    return ApiClient(baseUrl: 'https://api.example.com');
  }

  class ApiClient {
    final Dio _dio;

    ApiClient({required String baseUrl}) : _dio = Dio()..options.baseUrl = baseUrl;

    Future<T> get<T>(String path, {Map<String, dynamic>? queryParameters}) async {
      // 実装
    }

    Future<T> post<T>(String path, {dynamic data}) async {
      // 実装
    }
  }
  ```

- **model/**: API 通信で使用するデータモデル
  - レスポンス/リクエストの DTO（Data Transfer Object）
  - JSON シリアライズ/デシリアライズ対応

#### 各サービスディレクトリ

機能ごとのデータアクセスロジックを実装します。

```bash
services/
└── pokemon/
    ├── model/
    │   ├── pokemon_dto.dart        # PokemonのDTO
    │   └── pokemon_response.dart   # APIレスポンス
    └── pokemon_service.dart        # Pokemonデータアクセス
```

## 実装例

### Pokemon Service の例

```dart
// pokemon_dto.dart
@freezed
class PokemonDto with _$PokemonDto {
  const factory PokemonDto({
    required String id,
    required String name,
    required int level,
    required List<String> types,
    required Map<String, int> stats,
  }) = _PokemonDto;

  factory PokemonDto.fromJson(Map<String, dynamic> json) =>
      _$PokemonDtoFromJson(json);
}
```

```dart
// pokemon_service.dart

// LocalStorage Provider
@riverpod
LocalStorage localStorage(Ref ref) {
  return LocalStorage();
}

// PokemonService Provider
@riverpod
PokemonService pokemonService(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  final localStorage = ref.watch(localStorageProvider);

  return PokemonService(
    apiClient: apiClient,
    localStorage: localStorage,
  );
}

class PokemonService {
  final ApiClient _apiClient;
  final LocalStorage _localStorage;

  PokemonService({
    required ApiClient apiClient,
    required LocalStorage localStorage,
  }) : _apiClient = apiClient,
       _localStorage = localStorage;

  Future<Result<List<PokemonDto>, DataFailure>> fetchPokemons() async {
    try {
      final response = await _apiClient.get<List<dynamic>>('/pokemons');
      final pokemons = response.map((json) => PokemonDto.fromJson(json)).toList();

      // キャッシュに保存
      await _localStorage.savePokemons(pokemons);

      return Success(pokemons);
    } on DioException catch (e) {
      return Failure(NetworkFailure('Failed to fetch pokemons: ${e.message}'));
    } catch (e) {
      return Failure(DataFailure('Unexpected error: $e'));
    }
  }

  Future<Result<PokemonDto, DataFailure>> getPokemon(String id) async {
    // キャッシュから取得を試みる
    final cached = await _localStorage.getPokemon(id);
    if (cached != null) {
      return Success(cached);
    }

    // APIから取得
    try {
      final response = await _apiClient.get<Map<String, dynamic>>('/pokemons/$id');
      final pokemon = PokemonDto.fromJson(response);

      // キャッシュに保存
      await _localStorage.savePokemon(pokemon);

      return Success(pokemon);
    } on DioException catch (e) {
      return Failure(NetworkFailure('Failed to get pokemon: ${e.message}'));
    }
  }
}
```

## 実装ガイドライン

### 1. 責務の分離

- データの取得・保存のみを担当
- ビジネスロジックは含まない
- ドメイン層への変換はドメイン層で行う

### 2. エラーハンドリング

- ネットワークエラー、パースエラーなどを適切にハンドリング
- Result 型を使用して成功/失敗を表現
- 詳細なエラー情報を保持

### 3. データモデル

- DTO パターンを使用
- freezed によるイミュータブルな実装
- JSON シリアライズ対応

### 4. 命名規則

- サービス: `{名前}_service.dart`
- DTO: `{名前}_dto.dart`
- レスポンス: `{名前}_response.dart`

## 依存関係

- dio: HTTP 通信
- freezed: イミュータブルクラスの生成
- json_annotation: JSON シリアライズ
- riverpod_annotation: Riverpod のコード生成
- riverpod: 状態管理
- shared_preferences: ローカルストレージ
- drift: ローカルデータベース（必要に応じて）

## Provider 実装の追加ガイドライン

### 1. インポート

各ファイルには以下のインポートを含める：

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '{ファイル名}.g.dart';
```

### 2. Provider の配置

- 各サービスクラスの直前に Provider を定義
- 依存関係は`ref.watch()`を使用して注入
- 設定値は適切な ConfigurationProvider から取得

### 3. 使用例

```dart
// UIレイヤーでの使用例
class PokemonListPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonService = ref.watch(pokemonServiceProvider);

    return FutureBuilder(
      future: pokemonService.fetchPokemons(),
      builder: (context, snapshot) {
        // UI実装
      },
    );
  }
}
```

## セキュリティ考慮事項

- API キーの安全な管理
- 機密データの暗号化
- 適切な認証・認可の実装
- HTTPS の使用
