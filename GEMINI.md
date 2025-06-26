# GEMINI.md

This file provides guidance to Gemini when working with code in this repository.

## Development Commands

### Essential Commands
- **Dependencies**: `make pub_get` - Install dependencies for all packages
- **Testing**: `make test` - Run all tests across packages
- **Build Analysis**: `make analyze` - Run static analysis on all packages
- **Formatting**: `make format_all` - Format all Dart code
- **Code Generation**: `make generate` - Run build_runner for all packages
- **Clean Build**: `make clean_pub_get` - Clean and reinstall dependencies

### Flutter Commands (Use fvm)
- **Analyzer**: `fvm flutter analyze` - Run Flutter static analysis
- **Tests**: `fvm flutter test` - Run Flutter tests
- **Build**: `fvm flutter build` - Build Flutter app
- **Run**: `fvm flutter run` - Run Flutter app

### Package-Specific Commands
- **App Tests**: `make test_app` - Test app package only
- **Data Tests**: `make test_data` - Test data package only
- **Domain Tests**: `make test_domain` - Test domain package only

### Development Tools
- **Flutter Version Manager**: Uses `fvm` for Flutter version management
- **repomix**: Available for generating repository snapshots (`make repomix_all`)

## Architecture Overview

### Package Structure (Clean Architecture)
This is a multi-package Flutter monorepo following Clean Architecture principles:
- **`packages/domain/`** - Business logic, entities, and use cases. Pure Dart package.
- **`packages/data/`** - Data sources, repositories, APIs, and local storage.
- **`packages/app/`** - UI layer, routing, and application entry point.
- **`packages/design_system/`** - Reusable UI components and design tokens.

### Detailed Directory Structure
Follow this directory structure when creating new files:
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

### Navigation System
- **Router**: GoRouter with StatefulShellRoute.indexedStack
- **Main Navigation**: Bottom navigation with two tabs (Pokedex, Party)
- **State Preservation**: Tab states maintained when switching
- **Missing**: Evolution flow pages not integrated into routing

### Key Technologies
- **Flutter**: 3.32.2
- **State Management**: flutter_riverpod 2.6.1 with AsyncValue
- **Navigation**: go_router 15.2.0
- **Code Generation**: freezed 3.0.6, build_runner
- **UI Effects**: shimmer 3.0.0 for loading states
- **Data Source**: PokeAPI

## Development Rules & Conventions

### 1. Core Principles
- **Readability**: Write clear, understandable code. Use proper naming and formatting.
- **Reusability**: Extract common logic into reusable functions, classes, or components.
- **Simplicity (KISS)**: Prefer simple, direct solutions. Avoid unnecessary complexity (YAGNI).
- **Maintainability**: Write loosely coupled, highly cohesive code.
- **Communication**: Communicate clearly and politely in Japanese.
- **No Duplication**: Check for existing code before implementing new features.
- **Single Responsibility Principle (SRP)**: Each element should have a single, clear responsibility.

### 2. Git Workflow
- **Branching**:
    - `main`: Production branch.
    - `develop`: Development branch.
    - `feature/#[issue_number]_[feature_name]`: Feature branches based on `develop`.
- **Commit Messages**: `[type]: [message] [emoji]`
    - Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `build`, `ci`.
- **Issues and Pull Requests**:
    - Use templates from `.github/`.
    - Use GitHub MCP for creating issues and PRs when instructed.
    - PR titles: `[type]: #[issue_number] [message]`.
    - Merge using "Squash and merge".

### 3. Dart & Flutter Coding Conventions
- **Official Documentation**: Adhere to [Effective Dart](https://dart.dev/effective-dart) and the [Flutter Style Guide](https://docs.flutter.dev/development/tools/flutter-fix).
- **Type Safety**:
    - **Explicit Types**: Use explicit type annotations.
    - **No `dynamic`**: Avoid `dynamic`. Use `Object?` with type checks.
    - **Generics**: Always specify type parameters.
- **Null Safety**:
    - Use nullable (`Type?`) and non-nullable (`Type`) types correctly.
    - Avoid the null assertion operator (`!`).
    - Use `late` sparingly and only when safe.
- **Immutability**:
    - Design data classes (Entities, DTOs, States) as immutable using `freezed`.
    - Use `copyWith` for modifications.
- **Error Handling**:
    - Use a `Result` type (`Success`/`Failure`) for operations that can fail, instead of exceptions.
    - Define layer-specific `Failure` types (e.g., `DomainFailure`, `DataFailure`).
- **Code Generation**:
    - Actively use `freezed`, `json_serializable`, `riverpod_generator`.
    - Commit all generated files (`.g.dart`, `.freezed.dart`).
- **Formatting & Linting**:
    - Format code with `make format`.
    - Adhere to linting rules in `analysis_options.yaml`.

### 4. Commenting
- **Language**: Japanese, in "だ・である" style.
- **Purpose**: Explain the "why," not the "what." Keep comments updated.
- **Doc Comments (`///`)**: For all public APIs. Describe purpose, params, return values.
- **Implementation Comments (`//`)**: For complex logic, `NOTE:`, or `ignore:`. Avoid commented-out code.

### 5. Widget Development
- **No `buildXX` Methods**: Use separate `StatelessWidget` or `HookWidget` classes instead.
- **Componentization**: Extract complex UI logic (50+ lines) into separate widgets.
- **Naming**: Use `_` prefix for private/page-specific components (e.g., `_PokemonListView`).
- **Dependency Injection**: Use constructor injection for testability.

### 6. Handling Secrets
- Do not directly handle files like `.env`. Ask the user to perform such actions.
- Do not hardcode secrets. Access them via DI from environment variables or a configuration service.



## Local Database
- **Storage**: SQLite with drift (native), IndexedDB with drift (web)
- **Provider**: Uses Riverpod for dependency injection
- **Location**: `packages/data/src/services/local_storage/`
- **Platform Support**:
  - Native: `NativeDatabase` with SQLite files
  - Web: `WebDatabase` with IndexedDB (sql.js library required)

## Design System Usage
All UI components should use the design system package:
- Prefix components with `Ds` (e.g., `DsButton`, `DsScaffold`)
- Use semantic colors and typography tokens
- Follow established spacing and dimension guidelines

## Testing Strategy
- **Unit Tests**: Test business logic in the domain layer.
- **Widget Tests**: Test UI components and pages.
- **Integration Tests**: Test complete user flows.
- **Database Tests**: Test local storage functionality.
