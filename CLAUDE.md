# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

### Essential Commands
- **Dependencies**: `make pub_get` - Install dependencies for all packages
- **Testing**: `make test` - Run all tests across packages  
- **Build Analysis**: `make analyze` - Run static analysis on all packages
- **Formatting**: `make format` - Format all Dart code
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

### Package Structure
This is a multi-package Flutter monorepo following Clean Architecture principles:

- **`packages/app/`** - UI layer, routing, and application entry point
- **`packages/design_system/`** - Reusable UI components and design tokens
- **`packages/data/`** - Data sources, APIs, and local storage
- **`packages/domain/`** - Business logic, entities, and use cases

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

### Development Rules
- **Type Safety**: Explicit type annotations required, avoid `dynamic`
- **Null Safety**: Proper use of nullable/non-nullable types
- **Immutability**: Use `freezed` for data classes, prefer `final`
- **Error Handling**: Use Result types instead of exceptions
- **Comments**: Japanese language, document public APIs with `///`
- **Code Generation**: Commit generated `.g.dart` and `.freezed.dart` files

### Current Implementation Status
- ✅ Bottom navigation with Pokedex and Party pages
- ✅ Design system with consistent styling and Shimmer components
- ✅ Pokemon list display with infinite scroll
- ✅ Loading states with Shimmer effects
- ✅ Error handling with retry functionality
- ✅ Real PokeAPI data integration
- ❌ Evolution pages not routed
- ❌ Search functionality incomplete

### Local Database
- **Storage**: SQLite with drift
- **Provider**: Uses Riverpod for dependency injection
- **Location**: `packages/data/src/services/local_storage/`

### Design System Usage
All UI components should use the design system package:
- Prefix components with `Ds` (e.g., `DsButton`, `DsScaffold`)
- Use semantic colors and typography tokens
- Follow established spacing and dimension guidelines

### Testing Strategy
- **Unit Tests**: Test business logic in domain layer
- **Widget Tests**: Test UI components and pages
- **Integration Tests**: Test complete user flows
- **Database Tests**: Test local storage functionality