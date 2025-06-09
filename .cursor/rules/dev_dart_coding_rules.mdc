---
description:
  Defines Dart coding conventions, focusing on type safety and commenting rules.
globs:
alwaysApply: true
---

# Dart コーディング規約

このルールは、プロジェクト内で Dart コードを記述する際の規約を定義します。コードの一貫性、可読性、保守性、特に型安全性を高めることを目的とします。

## 1. 基本方針

- **Effective Dart 準拠:** 基本的に
  [Effective Dart](https://dart.dev/effective-dart)
  のスタイルガイドラインに従ってください。このドキュメントは、プロジェクト固有のルールや特に強調したい点を補足するものです。
- **可読性:**
  常に他の開発者が理解しやすいコードを心がけてください。適切な命名、一貫したフォーマット、必要に応じたコメントが重要です。
- **シンプルさ:**
  不必要に複雑なコードは避け、シンプルで直接的な解決策を優先してください (KISS)。

## 2. 型安全性に関する規約

型安全性を最大限に確保するため、以下の規約を厳守してください。

### 2.1 明示的な型アノテーション

- **必須:**
  変数宣言、関数の引数、戻り値には、可能な限り明示的な型アノテーションを使用してください。型推論に頼りすぎず、意図を明確に示してください。
- **`var` の使用:** ローカル変数で型が自明な場合に限り `var`
  の使用を許可しますが、クラスのフィールドやトップレベル変数では明示的な型を使用してください。
- **`dynamic` の禁止:** 原則として `dynamic`
  型の使用は禁止します。型が不明な場合は `Object?`
  を使用し、必要な箇所で型チェックやキャストを行ってください。外部データ（JSONなど）を扱う場合は、型安全なパーサー（例:
  `json_serializable`）を使用してください。
- **ジェネリクス:** コレクション（`List`, `Map`, `Set`）や非同期処理（`Future`,
  `Stream`）など、ジェネリクスが適用可能な場面では必ず型パラメータを指定してください。

### 2.2 null安全性の徹底

- **null許容型 (`Type?`) と非null型 (`Type`) の区別:** 変数やパラメータが `null`
  になり得るかどうかを常に意識し、適切に `?` を付与してください。
- **null チェック:** null許容型を扱う際は、`?.` (null-aware access)、`??`
  (null-aware operator)、`!` (null assertion
  operator) を適切に使用してください。`!` の使用は、その時点で絶対に `null`
  でないことが保証される場合に限定し、可能な限り避けてください。フロー解析 (`if (variable != null)`) やローカル変数への代入によるプロモーションを活用してください。
- **`late` キーワード:** `late`
  キーワードの使用は、非null変数の初期化を宣言箇所で行えないが、使用前に必ず初期化されることが保証される場合に限定してください。安易な使用はランタイムエラーの原因となるため避けてください。

### 2.3 シールドクラスの活用

- **状態や結果の表現:**
  状態マシン、APIレスポンスの成功/失敗、エラーの種類など、取りうるケースが限定される場合は
  `sealed class` または `enum` を積極的に活用してください。
- **網羅性の確保:** `sealed class` を `switch` 式や `when`/`map`
  メソッド（`freezed`
  使用時）で扱う際は、全てのサブタイプを網羅するようにしてください。これにより、新しいケースが追加された場合にコンパイルエラーで検出できます。

  ```dart
  // 良い例 (freezed を使用)
  @freezed
  sealed class Result<T, E> with _$Result<T, E> {
    const factory Result.success(T data) = Success<T, E>;
    const factory Result.failure(E error) = Failure<T, E>;
  }

  // 使用例
  result.when(
    success: (data) => print('成功: $data'),
    failure: (error) => print('失敗: $error'),
  );
  ```

### 2.4 Result 型によるエラーハンドリング

- **例外よりも Result 型:**
  関数やメソッドが失敗する可能性がある場合、例外をスローする代わりに `Result`
  型（上記例のような自作または `either_dart`
  パッケージなど）を返すことを原則とします。これにより、エラー処理を強制し、型安全なエラーハンドリングを実現します。
- **レイヤー固有のエラー型:** 各レイヤー（Domain, Data,
  App）で、そのレイヤー固有のエラー/失敗を表す型（例: `DomainFailure`,
  `DataFailure`, `UiError`）を定義し、`Result`
  型の失敗型パラメータとして使用してください。
- **エラー変換:**
  レイヤー間でエラー情報を伝達する際は、下位レイヤーのエラー型を上位レイヤーのエラー型に明示的に変換してください。

  ```dart
  // 良い例 (Data層から Domain層への変換)
  Future<Result<Player, DomainFailure>> getPlayer(String id) async {
    final dataResult = await _dataSource.fetchPlayer(id);
    return dataResult.when(
      success: (dto) => Result.success(dto.toEntity()), // DTOをEntityに変換
      failure: (dataError) {
        // DataErrorをDomainFailureに変換
        final domainFailure = switch (dataError) {
          is NetworkError => DomainFailure.networkError(message: dataError.message),
          is NotFoundError => DomainFailure.notFound(resource: 'Player', id: id),
          _ => DomainFailure.unexpected(error: dataError),
        };
        return Result.failure(domainFailure);
      },
    );
  }
  ```

### 2.5 不変性の重視

- **原則不変:** Entity、Value
  Object、State クラスなどは、可能な限り不変（immutable）に設計してください。`final`
  キーワードを積極的に使用し、後から状態を変更できないようにします。
- **状態変更:** 状態を変更する必要がある場合は、`copyWith` メソッド（`freezed`
  で自動生成可能）を使用して新しいインスタンスを生成してください。
- **コレクション:** 不変なコレクション (`package:collection` の
  `UnmodifiableListView`
  など) や、コピーを返す getter を使用して、内部のコレクションが外部から変更されることを防いでください。

### 2.6 コード生成ツールの活用

- **積極的に活用:** `freezed`、`json_serializable`、`riverpod_generator`
  などのコード生成ツールを積極的に活用し、ボイラープレートコードの削減と型安全性の向上を図ってください。
- **生成ファイルのコミット:** 生成された `*.g.dart` や `*.freezed.dart`
  ファイルは Git にコミットしてください。

## 3. コメント規約

コメントはコードの意図を補完し、可読性を高めるために重要です。以下の規約に従ってください。

### 3.1 基本方針

- [Effective Dart: Documentation](https://dart.dev/effective-dart/documentation)
  の作法に従うことを目指します。
- コメントはコードの意図を補完し、可読性を高めるために使用します。コードを読めばわかる自明な内容の繰り返しは避けます。
- コメントは常に最新の状態に保ち、コードの変更に合わせて更新します。古い、または誤解を招くコメントは削除します。
- コメントは日本語で記述し、例外なく「。」や「.」で終わる完全な文、または体言止めで記述します。
- **コード内に記述するコメントの文体は「だ・である」調に統一します。**
  (このガイドライン自体の説明文は「です・ます」調です)

### 3.2 ドキュメントコメント (`///`)

- **目的:**
  クラス、メソッド、Enum、トップレベル関数、変数など、公開 API の目的、役割、使用方法を説明するために使用します。
- **記述内容:**
  - 何をするのか（What）を簡潔に記述します。
  - 必要に応じて、**引数**、**戻り値**、発生しうる**例外**について、自然な文章で説明します。引数は角括弧
    `[]` で囲んで示すことができます（例: `[userId]`）。
  - 使用例 (`@tool snippet` など) を含めると、より理解しやすくなります。
- **スタイル:**
  - 最初の文は、対象の要素を要約する簡潔な説明にします。
  - Lint ルール (`public_member_api_docs`) での強制はされていませんが、公開 API には記述することを強く推奨します。
- **例 (良い例):**

  ````dart
  /// 指定されたユーザー ID に基づいてユーザー情報を取得する。
  ///
  /// [userId] が存在しない場合は `null` を返す。
  /// ネットワークエラーが発生した場合は `NetworkException` をスローする可能性がある。
  ///
  /// ```dart
  /// final user = await fetchUser(123);
  /// if (user != null) {
  ///   print(user.name);
  /// }
  /// ```
  Future<User?> fetchUser(int userId) async {
    // ... 実装 ...
  }
  ````

### 3.3 通常コメント (`//`)

- **目的:**
  コードブロック内の特定の処理ステップ、複雑なロジック、またはコードだけでは伝わりにくい意図を補足するために使用します。
- **記述内容:**
  - なぜその処理が必要なのか（Why）を説明します。どのように動作するか（How）はコード自体が示すべきです。
  - `NOTE:` や `ignore:` の説明にも使用します。
- **避けるべきコメント:**
  - **自明な処理の説明:**
    コードを読めばすぐに理解できる内容のコメントは不要です。
    - 悪い例: `// i をインクリメントする` (`i++;`)
    - 悪い例: `// ユーザー名を取得する` (`final name = user.name;`)
    - 悪い例: `// .value でアクセス`
  - **一時的なメモ:** `TODO`
    コメントは意図的な未実装箇所を示すために使用できますが、それ以外の個人的なメモや一時的なマーカーは避けます。
    - 悪い例: `// あとで修正`
    - 悪い例: `// ↓↓↓ 修正点 ↓↓↓`
  - **思考プロセス:**
    コードの意図ではなく、開発中の思考過程を記述したコメントは不要です。
    - 悪い例: `// ここで matrix を使うか確認したけどやめた`
  - **コメントアウトされたコード:**
    不要になったコードはコメントアウトせず、バージョン管理システム（Git など）を信頼して削除します。デバッグ目的の一時的なコメントアウトは許容されますが、コミット前に削除します。
- **例 (良い例):**

  ```dart
  // ユーザーが特定の権限を持っているか確認する。
  // 管理者権限がない場合は早期リターンする。
  if (!user.isAdmin) {
    return;
  }

  // NOTE: パフォーマンス向上のため、ここではキャッシュされた値を使用する。
  final cachedData = _cache.getData();
  ```

## 4. その他

- **フォーマット:** `dart format .`
  コマンドでコードフォーマットを統一してください。`.prettierrc`
  は Markdown ファイルなどに適用されます。
- **Lint:** `analysis_options.yaml`
  に定義された Lint ルールに従ってください。`very_good_analysis`
  をベースとしています。
- **命名規則:**
  クラス名 (`UpperCamelCase`)、メソッド名・変数名 (`lowerCamelCase`)、ファイル名 (`snake_case.dart`) など、一般的な Dart の命名規則に従ってください。
