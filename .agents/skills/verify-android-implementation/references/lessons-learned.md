# 教訓集 - Android 検証 (verify-android-implementation)

このドキュメントは、`verify-android-implementation` スキルの実行中に遭遇した技術的な問題とその解決策を記録し、将来の試行錯誤を減らすことを目的としています。

## ビルドと依存関係

### Version Catalog のアクセサ構文 (ハイフンとドット)
- **問題**: `libs.versions.toml` でハイフンを含むキー（例: `androidx-core-ktx`）を定義した場合、Kotlin DSL (`build.gradle.kts`) 内で `libs.androidx-core-ktx` のように記述すると、ハイフンがマイナス演算子と解釈されてコンパイルエラーになります。
- **解決策**: Kotlin DSL では常にドット表記を使用してください。自動生成されるアクセサはハイフンをドットに変換します。
  - `androidx-core-ktx` -> `libs.androidx.core.ktx`
  - `androidx-compose-ui` -> `libs.androidx.compose.ui`

### 推奨バージョンへの更新 (Lint 警告の解消)
- **問題**: `lintDebug` を実行した際、古いバージョンのライブラリが "Obsolete Gradle Dependency" として警告されることがあります。
- **解決策**: 本スキルの「警告ゼロ」基準を満たすため、Lint レポート (`app/build/reports/lint-results-debug.html`) を確認し、推奨されている最新安定版へ `libs.versions.toml` を更新してください。

## 静的解析 (ktlint)

### マルチライン式のラッピングルール
- **問題**: `ktlint` の `standard:multiline-expression-wrapping` ルールにより、マルチラインの DSL ブロック（例: `version = release(36) { ... }`）が警告されることがあります。
- **解決策**: 開始波括弧 (`{`) を改行して配置することで、ルールに適合させることができます。
  ```kotlin
  // 修正例
  version = release(36)
  {
      minorApiLevel = 1
  }
  ```

## スキル実行全般

### 実行順序の厳守
- 修正を行った後は、必ず **手順 1 (assembleDebug)** からやり直してください。一部の修正が他の検証項目（Lint など）に影響を与える可能性があるためです。
- テンプレートからの同期時は、まずテンプレートのバージョンで安定動作を確認し、その後に Lint 警告を解消するために最新版へアップデートする「二段階のアプローチ」がスムーズです。
