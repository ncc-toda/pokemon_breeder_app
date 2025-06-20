---
description: Defines Git operation rules for the project.
globs:
  - '*' # or more specific globs if needed, e.g., '.git/**' or related config files
alwaysApply: true
---

# Git運用ルール

このドキュメントでは、本プロジェクトにおける Git 運用のルールを定義します。

## ブランチ戦略

### メインブランチ

- `main`: 本番環境用のブランチ。常に安定した状態を維持する
- `develop`: 開発用のブランチ。機能実装後のマージ先

### 作業ブランチ

- `feature/#[issue番号]_[機能名]`: 新機能開発用
  - 例: `feature/#31_create_specification`

作業ブランチは develop ブランチから派生させ、 マージ時には develop ブランチにマージする

## コミットメッセージのルール

### フォーマット

```txt
[type]: [内容] [emoji]
```

### typeの種類

- `feat`: 新機能
- `fix`: バグ修正
- `docs`: ドキュメント関連
- `style`: コードスタイルの修正（フォーマットなど）
- `refactor`: リファクタリング
- `test`: テスト関連
- `chore`: ビルドプロセスやツール関連
- `build`: ビルド関連の変更
- `ci`: CI関連の変更

### 絵文字の例

- `:sparkles:`: ✨ (新機能)
- `:bug:`: 🐛 (バグ修正)
- `:memo:`: 📝 (ドキュメント)
- `:hammer:`: 🔨 (リファクタリング)
- `:package:`: 📦 (パッケージ関連)
- `:test_tube:`: 🧪 (テスト)
- `:lipstick:`: 💄 (UI/スタイル関連)
- `:rotating_light:`: 🚨 (Lint警告対応)
- `:green_heart:`: 💚 (CI修正)
- `:recycle:`: ♻️ (コードリファクタリング)
- `:technologist:`: 👨‍💻 (開発者ツール関連)

### コミットメッセージの例

```txt
feat: シーズン情報を表すドメインオブジェクトを作成 :hammer:
docs: ゲームコンセプトをざっくり記載 :memo:
build: auto_route を導入 :package:
```

## Issue管理

### Issueテンプレート

Issueを作成する際は、`.github/ISSUE_TEMPLATE/`のテンプレートに従って内容を作成します。

## GitHub MCP を使った Issue 作成

もしユーザーからの指示で Issue の作成を求められた場合は GitHub
MCP を使って作成してください。

### Issue 作成時の注意点

- タイトルは必ず`[type]: [内容]`の形式で記載する
- 本文には十分な情報を含め、必要に応じてスクリーンショットや図を添付する
- 適切なラベルを設定する
- アサインする担当者を指定する（自分自身または他のチームメンバー）

## プルリクエスト（PR）のルール

### PRのテンプレート

PRを作成する際は、`.github/pull_request_template.md` ( @pull_request_template.md
)のテンプレートに従って内容を作成します。

### PRのタイトル

```txt
[type]: #[issue番号] [内容]
```

例: `feat: #21 シーズン情報を表すドメインオブジェクトを作成`

### GitHub MCP を使った Pull Request 作成

もしユーザーからの指示で Pull Request の作成を求められた場合は GitHub
MCP を使って作成してください。

### PR作成時の注意点

- 作業ブランチが最新の`develop`ブランチと同期されていることを確認する
- PRのタイトルは必ず`[type]: #[issue番号] [内容]`の形式で記載する
- テンプレートに従って必要な情報をすべて記入する
- レビュアーを適切に設定する
- 関連するIssueを`Closes #[Issue番号]`の形式で紐づける

## マージのルール

1. **マージ条件**

   - CIチェックがパスしていること
   - 必要なレビューが完了していること

2. **マージ方法**

   - 基本的に「Squash and merge」を使用
   - コミットメッセージは`[type]: #[issue番号] [内容] [emoji]`の形式に統一

3. **マージ後**
   - 作業ブランチは削除する
   - 関連するIssueをクローズする

## リリース管理

1. **バージョニング**

   - セマンティックバージョニング（`MAJOR.MINOR.PATCH`）に従う
   - `pubspec.yaml`のバージョンを更新

2. **リリースブランチ**

   - リリース準備時に`releases/[バージョン]`ブランチを作成
   - `develop`ブランチからマージされたPRがクローズされると、自動的にタグが作成される

3. **タグ付け**
   - タグは`v[バージョン]`の形式（例: `v1.0.0`）
   - リリースノートは自動生成される

## CI/CD

1. **CI**

   - プッシュ時およびPR時に自動的にチェックが実行される
   - Markdown（`.md`）ファイルの変更のみの場合はスキップされる

2. **CD**
   - リリースブランチがマージされた際に自動的にタグ付けとリリースノート生成が行われる

## その他のルール

1. **コードレビュー**

   - PRを出す前に自己レビューを行う
   - コメントには建設的な提案を含める

2. **コンフリクト解決**

   - コンフリクトは作業ブランチ側で解決する
   - 必要に応じて`develop`ブランチを定期的にマージする
