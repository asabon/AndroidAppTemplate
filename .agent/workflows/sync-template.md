---
description: Android Studio テンプレート (new_template) からの最新構成の取り込みと統合
---

このワークフローは、Android Studio のメジャーアップデート等で `new_template` が更新された際、その最新構成を本プロジェクトに安全かつ確実に同期するための手順を定義します。

## 実行手順

### 0. 準備状況の確認 (最優先)
作業を開始する前に、必ず `new_template` ディレクトリが存在し、中身が配置されているか確認してください。
- `ls new_template` を実行し、ファイルが存在することを確認します。
- **重要**: `new_template` が存在しない場合、または中身が空の場合は、直ちに作業を中断し、ユーザーに「`new_template` ディレクトリに最新のテンプレートを配置してください」と伝えてください。

### 1. 事前調査
`new_template` ディレクトリとプロジェクトルートの差分を確認し、更新が必要な箇所を特定します。特に以下のファイルに注目してください。
- `gradle/wrapper/gradle-wrapper.properties`
- `gradle/libs.versions.toml`
- `gradle.properties` (JVM 引数などの変更)
- `build.gradle.kts` (ルートおよび app モジュール)

### 2. Gradle インフラの同期
最新の Gradle Wrapper とルート設定を取り込みます。
- **Gradle Wrapper**: `new_template` の `gradle/wrapper/*` および `gradlew`, `gradlew.bat` を上書きします。
- **gradle.properties**: 本プロジェクトの **メモリ設定 (org.gradle.jvmargs=-Xmx3072m)** を優先しつつ、新しいフラグや設定があれば取り込みます。

### 3. バージョンカタログ (libs.versions.toml) のマージ
`new_template` で更新されたライブラリバージョンとプラグイン設定を取り込みます。
- `kotlin`: 最新安定版を維持。
- `androidx`, `compose`, `material` 等: テンプレートのバージョンを優先。
- 本プロジェクト独自のライブラリ (Kover 等) が削除されないよう注意してください。

### 4. パッケージ名とプロジェクト名の正規化
テンプレートからの同期によりパッケージ名が `net.asabon.androidapptemplate2` 等に変更される場合がありますが、本プロジェクトの構成に引き戻します。
- **パッケージ名**: `com.example.androidapptemplate` に統一します。
- **プロジェクト名**: `AndroidAppTemplate` に統一します。
- `AndroidManifest.xml` や `themes.xml`, `strings.xml` の整合性を確認してください。

### 5. アプリモジュール (build.gradle.kts) の更新
テンプレートで使用されている最新の DSL 構文（例: `compileSdk { version = release(XX) }`）を適用し、パッケージ名を修正します。

### 6. 検証と CI 調整
ビルドとテストを実行し、CI 環境との整合性を確認します。
- `./gradlew clean assembleDebug testDebug lintDebug` を実行。
- **CI 失敗対策**: `github-dev-flow` に基づき CI の失敗（メモリ不足等）を確認し、必要に応じて環境設定を調整します。

---
> [!IMPORTANT]
> **パッケージ名の保持**: 同期作業の最終段階で、必ずパッケージ名が `com.example.androidapptemplate` になっていることを確認してください。
