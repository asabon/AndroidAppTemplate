---
description: Android Studio テンプレート (temp) からの最新構成の取り込みと統合
---

このワークフローは、Android Studio のメジャーアップデート等で最新の構成（`temp` ディレクトリ）が用意された際、その最新構成を本プロジェクトに安全かつ確実に同期するための手順を定義します。

## 実行手順

### 0. 準備状況の確認 (最優先)
作業を開始する前に、必ずテンプレートが配置されているか確認してください。
- `temp` ディレクトリが存在し、中身があることを確認します。
- **重要**: `temp` ディレクトリが存在しない場合は、直ちに作業を中断し、ユーザーに「`temp` ディレクトリに最新のテンプレートを配置してください」と伝えてください。

### 1. 事前調査
テンプレートディレクトリ (`temp`) とプロジェクトルートの差分を確認し、更新が必要な箇所を特定します。
- `gradle/wrapper/gradle-wrapper.properties` (SHA256Sum の有無に注目)
- `gradle/libs.versions.toml` (ライブラリの命名規則の変更に注目)
- `gradle.properties` (JVM 引数などの変更)
- `build.gradle.kts` (ルートおよび app モジュール)

### 2. Gradle インフラの同期
最新の Gradle Wrapper とルート設定を取り込みます。
- **Gradle Wrapper**: `temp` 内の `gradle/wrapper/*` および `gradlew`, `gradlew.bat` を反映します（`distributionSha256Sum` を含めること）。
- **gradle.properties**: 本プロジェクトの **メモリ設定 (org.gradle.jvmargs=-Xmx3072m)** を優先しつつ、新しいフラグや設定があれば取り込みます。

### 3. バージョンカタログ (libs.versions.toml) のマージ
テンプレートで更新されたライブラリバージョンとプラグイン設定を取り込みます。
- **原則**: いったんテンプレートのバージョンを優先して安定動作を確認します。
- **命名規則**: テンプレートで新しい命名規則（例: `androidx-compose-*`）が採用されている場合は、それに合わせます。
- 本プロジェクト独自のライブラリ (Kover 等) が削除されないよう注意してください。

### 4. パッケージ名とプロジェクト名の正規化
テンプレートからの同期によりパッケージ名が変更される場合がありますが、本プロジェクトの構成に戻します。
- **パッケージ名**: `com.example.androidapptemplate` に統一。
- **プロジェクト名**: `AndroidAppTemplate` に統一。

### 5. アプリモジュール (build.gradle.kts) の更新
テンプレートで使用されている最新の DSL 構文を適用しつつ、依存関係の参照を更新します。
> [!TIP]
> **Kotlin DSL の注意点**: `libs.versions.toml` でハイフンを含むキー（`androidx-core-ktx`）を定義した場合、Kotlin DSL (`.kts`) ではドット表記（`libs.androidx.core.ktx`）で参照する必要があります。ハイフンのまま記述するとコンパイルエラーになります。

### 6. 検証
ビルドとテストを実行し、整合性を確認します。
- `./gradlew clean assembleDebug testDebug lintDebug` を実行。

---
> [!IMPORTANT]
> **パッケージ名の保持**: 同期作業の最終段階で、必ずパッケージ名が `com.example.androidapptemplate` になっていることを確認してください。
