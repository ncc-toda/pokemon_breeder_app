# Web Database Setup Guide

## 概要
このプロジェクトではdriftパッケージを使用してクロスプラットフォーム対応のデータベースを実装しています。
ネイティブ環境ではSQLite、Web環境ではIndexedDBを使用します。

## 実装詳細

### プラットフォーム分離
データベース接続は以下のファイルで分離されています：

- `packages/data/lib/src/services/local_storage/database_connection.dart` - 基底インターフェース
- `packages/data/lib/src/services/local_storage/database_connection_native.dart` - ネイティブ実装
- `packages/data/lib/src/services/local_storage/database_connection_web.dart` - Web実装

### Web環境での必要事項

#### 1. sql.jsライブラリの追加
`packages/app/web/index.html`にsql.jsライブラリのCDN linkを追加：

```html
<!-- SQL.js library for drift web database -->
<script src="https://cdn.jsdelivr.net/npm/sql.js@1.10.2/dist/sql-wasm.js"></script>
```

#### 2. 依存関係の設定
`packages/data/pubspec.yaml`にFlutter依存関係を追加：

```yaml
dependencies:
  flutter:
    sdk: flutter
```

### トラブルシューティング

#### FFI関連エラー
Web環境でFFI関連エラーが発生する場合：
- conditional importが正しく設定されているか確認
- `dart:ffi`を直接インポートしているファイルがないか確認

#### sql.js関連エラー
Web環境で「Could not access the sql.js javascript library」エラーが発生する場合：
- index.htmlにsql.jsライブラリが含まれているか確認
- CDNからライブラリが正常に読み込まれているか確認

#### WebAssemblyエラー
Web環境で「WebAssembly.instantiate(): expected magic word 00 61 73 6d, found 3c 21 44 4f」エラーが発生する場合：
- WASMファイルの代わりにHTMLが読み込まれている問題
- `initSqlJs`の`locateFile`関数で正しいWASMファイルパスを指定する必要がある
- 正しい設定例：
```javascript
initSqlJs({
  locateFile: function(file) {
    if (file === 'sql-wasm.wasm') {
      return 'https://cdn.jsdelivr.net/npm/sql.js@1.10.2/dist/sql-wasm.wasm';
    }
    return file;
  }
})
```

### データベースの動作確認方法

#### ネイティブ環境
```bash
fvm flutter run -d macos  # または ios, android
```

#### Web環境  
```bash
fvm flutter run -d chrome
```

### 制限事項
- Web環境ではファイルシステムへの直接アクセスはできません
- IndexedDBはブラウザの制限に従います（ストレージクォータなど）
- パフォーマンスはネイティブ環境の方が優秀です