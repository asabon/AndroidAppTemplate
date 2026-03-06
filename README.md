[![build](https://github.com/asabon/AndroidAppTemplate/actions/workflows/build.yml/badge.svg?branch=main)](https://github.com/asabon/AndroidAppTemplate/actions/workflows/build.yml)

# [Your App Name]

> [!TIP]
> **テンプレートの利用方法について**
> このリポジトリ自体のセットアップ方法や使い方については、[docs/TEMPLATE_USAGE.md](docs/TEMPLATE_USAGE.md) を参照してください。

## 概要

[アプリの簡単な説明をここに記述してください]

## 主な機能

- 機能 1
- 機能 2
- 機能 3

## 開発環境のセットアップ

```bash
# クローン
git clone [repository-url]
cd [repository-name]

# ビルド確認
./gradlew assembleDebug

# Git Hook の登録 (推奨)
# .hooks/ 内のスクリプトを Git Hook として有効化します。
./scripts/setup-hooks.ps1  # Windows
./scripts/setup-hooks.sh   # Mac / Linux
```

## アーキテクチャ

このプロジェクトは Android 推奨の最新アーキテクチャに基づいています。

- **UI**: Jetpack Compose
- **DI**: Hilt
- **Async**: Coroutines / Flow
- **Architecture**: MVVM + Repository Pattern

## ディレクトリ構成

```text
+ app/
  + src/main/java/
    + data/           # Repository, DataSource, API
    + di/             # Hilt Modules
    + domain/         # UseCases, Model (Optional)
    + ui/             # Screens, ViewModels, Components
```

## テスト

```bash
# ユニットテスト
./gradlew testDebugUnitTest

# Lint チェック
./gradlew ktlintCheck
./gradlew lintDebug
```
