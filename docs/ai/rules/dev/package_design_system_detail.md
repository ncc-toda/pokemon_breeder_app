---
description: Defines the design_system package structure and responsibilities.
globs: ["packages/design_system/**/*.dart", "packages/app/**/*.dart"]
alwaysApply: false
---

# Design System パッケージ

## 概要

`design_system` パッケージは、アプリケーション全体で使用される共通の UI コンポーネントとデザイントークンを提供します。一貫性のあるデザインとユーザー体験を実現するための基盤となるパッケージです。

## ディレクトリ構造

```bash
packages/design_system/
├── lib/
│   └── src/
│       ├── components/          # 再利用可能なUIコンポーネント
│       │   └── ds_{component_name}.dart
│       └── design_tokens/       # デザイントークン
│           ├── ds_dimension.dart
│           ├── ds_padding.dart
│           ├── ds_primitive_color.dart
│           ├── ds_radius.dart
│           ├── ds_semantic_color.dart
│           ├── ds_spacing.dart
│           └── ds_typography.dart
└── design_system.dart          # パッケージエントリーポイント
```

## 各ディレクトリの詳細

### components/

アプリケーション全体で再利用される共通 UI コンポーネントを配置します。

命名規則：

- すべてのコンポーネントは `ds_` プレフィックスを付ける
- 例: `ds_button.dart`, `ds_card.dart`, `ds_text_field.dart`

コンポーネントの例：

- ボタン（Primary, Secondary, Text）
- カード
- テキストフィールド
- ダイアログ
- スナックバー
- ローディングインジケーター
- アバター
- チップ
- バッジ

### design_tokens/

デザインの基本要素を定義するトークンを配置します。

## コンポーネント実装例

## 実装ガイドライン

### 1. 一貫性の維持

- すべてのコンポーネントでデザイントークンを使用
- 独自の色やサイズを定義しない
- Material Design ガイドラインに準拠

### 2. アクセシビリティ

- 適切なセマンティクスの提供
- キーボードナビゲーション対応
- スクリーンリーダー対応

### 3. カスタマイズ性

- 必要なプロパティを公開
- デフォルト値の提供
- 拡張可能な設計

### 4. パフォーマンス

- const コンストラクタの使用
- 不要な再ビルドの回避
- 効率的なウィジェット構成

### 5. ドキュメント

- 各コンポーネントの使用例を提供
- プロパティの説明を記載
- ベストプラクティスの共有

## 使用例

```dart
import 'package:design_system/design_system.dart';

class ExampleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: DsPadding.md,
        child: Column(
          children: [
            Text(
              'Welcome',
              style: DsTypography.h1.copyWith(
                color: DsSemanticColor.textPrimary,
              ),
            ),
            SizedBox(height: DsSpacing.md),
            DsButton(
              text: 'Get Started',
              onPressed: () {},
              type: DsButtonType.primary,
            ),
          ],
        ),
      ),
    );
  }
}
```

## 依存関係

- flutter: UI フレームワーク
- flutter_svg: SVG アイコンサポート（必要に応じて）

## テーマ対応

- ライトテーマ/ダークテーマの切り替え対応
- カスタムテーマの作成サポート
- システムテーマとの連携
