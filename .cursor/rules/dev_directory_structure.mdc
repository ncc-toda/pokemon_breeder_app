---
description: Defines directory structure for the project.
globs:
alwaysApply: true
---

# ディレクトリ構成

以下のディレクトリ構造に従って実装を行ってください：

```bash
packages/
├── app/             * UI 層やアプリとしてのエントリーポイントの役割を担うパッケージ
│   └── lib/
│       ├── core/
│       │   ├── constants/
│       │   ├── extensions/
│       │   └── routes/
│       ├── hooks/         * 複数の Widget で使う共通のカスタムフック
│       │   └── xx_hook.dart
│       ├── states/        * グローバルとして保持する状態（極力ローカルで保持するようにする）
│       │   └── xx_state.dart
│       ├── ui/
│       │   ├── pages/     * 各画面に相当する Widget
│       │   │   ├── xx_page.dart
│       │   │   └── yy_page.dart
│       │   └── features/    * 関心単位で分割する
│       │       └── {feature_name}/
│       │           ├── components/ * コンポーネント
│       │           │   └── xx.dart
│       │           └── hooks/     * カスタムフック
│       │               └── xx_hook.dart
│       └── main.dart      * アプリケーションのエントリーポイント
├── data/            * データ層のパッケージ
│   ├── lib/
│   │   └── src/
│   │       ├── core/
│   │       │   ├── constants/
│   │       │   └── errors/
│   │       │       ├── data_exception.dart * データ層がスローする例外
│   │       │       └── data_failure.dart   * データ層が返す失敗（ Result 型で使う ）
│   │       └── services/
│   │           ├── api/
│   │           │   ├── model/
│   │           │   │   └── {model_name}.dart
│   │           │   └── api_client.dart
│   │           └── {service_name}/
│   │               ├── model/
│   │               │   └── {model_name}.dart
│   │               └── {service_name}_service.dart
│   └── data.dart        * データ層のエントリーポイント
├── design_system/
│   ├── lib/
│   │   └── src/
│   │       ├── components/
│   │       │   └── ds_button.dart
│   │       └── design_tokens/
│   │           ├── ds_dimension.dart
│   │           ├── ds_padding.dart
│   │           ├── ds_primitive_color.dart
│   │           ├── ds_radius.dart
│   │           ├── ds_semantic_color.dart
│   │           ├── ds_spacing.dart
│   │           └── ds_typography.dart
│   └── design_system.dart
└── domain/
    ├── lib/
    │   └── src/
    │       ├── core/
    │       │   ├── constants/
    │       │   ├── converters/ * 例: jsonConverter など
    │       │   ├── errors/
    │       │   │   ├── domain_exception.dart * ドメイン層がスローする例外
    │       │   │   └── domain_failure.dart   * ドメイン層が返す失敗（ Result 型で使う ）
    │       │   ├── extensions/
    │       │   └── result/
    │       │       └── result.dart         * ドメイン層, データ層が返す Result 型
    │       └── features/
    │           └── {feature_name}/       * 関心単位で分割する（原則として各関心事の配下にはディレクトリを作成せずに、直接ファイルを配置する）
    │               ├── {entity_name}.dart  * エンティティ
    │               ├── xx_use_case.dart    * ユースケース
    │               └── xx_state.dart       * 実質リポジトリのようなもの（ データ層のサービスを呼び出し、値を加工して保持する ）
    └── domain.dart
```
