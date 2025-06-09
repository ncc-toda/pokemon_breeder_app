.PHONY: pub_get
pub_get:
	fvm dart pub get

.PHONY: clean
clean:
	cd packages/app && fvm flutter clean

.PHONY: clean_pub_get
clean_pub_get:
	make clean
	make pub_get

# * テスト
.PHONY: test_app
test_app:
	cd packages/app && fvm flutter test

.PHONY: test_common
test_common:
	cd packages/common && fvm dart test

.PHONY: test_data
test_data:
	cd packages/data && fvm dart test

.PHONY: test_domain
test_domain:
	cd packages/domain && fvm dart test

.PHONY: test
test:
	make test_app
	make test_common
	make test_data
	make test_domain

# * 静的解析
.PHONY: analyze
analyze:
	cd packages/app && fvm flutter analyze .
	cd packages/common && fvm flutter analyze .
	cd packages/data && fvm flutter analyze .
	cd packages/domain && fvm flutter analyze .

.PHONY: format
format:
	dart format .

# * コード生成
.PHONY: generate_app
generate_app:
	cd packages/app && fvm dart run build_runner build --delete-conflicting-outputs

.PHONY: generate_design_system
generate_design_system:
	cd packages/design_system && fvm dart run build_runner build --delete-conflicting-outputs

.PHONY: generate_data
generate_data:
	cd packages/data && fvm dart run build_runner build --delete-conflicting-outputs

.PHONY: generate_domain
generate_domain:
	cd packages/domain && fvm dart run build_runner build --delete-conflicting-outputs

.PHONY: generate
generate:
	make generate_app
	make generate_design_system
	make generate_data
	make generate_domain

# * ルールファイル生成
.PHONY: build_rules
build_rules:
	@echo "Building rules..."
	@bash ./scripts/build_mdc_rules.sh
	@echo "Build rules complete."

# * repomix
.PHONY: repomix_all
repomix_all:
	npx repomix --ignore "**/ios/**,**/web/**,**/dart_defines/**,**/*.freezed.dart,**/*.g.dart"

.PHONY: repomix_ai_rules
repomix_ai_rules:
	cd docs/ai/rules && npx repomix

.PHONY: repomix_app
repomix_app:
	cd packages/app && npx repomix --ignore ".dart_tool/**,**/ios/**,**/web/**,**/dart_defines/**,**/*.freezed.dart,**/*.g.dart"

.PHONY: repomix_design_system
repomix_design_system:
	cd packages/design_system && npx repomix --ignore ".dart_tool/**,**/*.freezed.dart,**/*.g.dart"

.PHONY: repomix_domain
repomix_domain:
	cd packages/domain && npx repomix --ignore ".dart_tool/**,**/*.freezed.dart,**/*.g.dart"

.PHONY: repomix_data
repomix_data:
	cd packages/data && npx repomix --ignore ".dart_tool/**,**/*.freezed.dart,**/*.g.dart"
