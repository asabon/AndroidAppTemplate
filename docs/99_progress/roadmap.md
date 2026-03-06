# プロジェクト進捗管理

## フェーズ 1: 基盤整備 [x]
- [x] 現状のワークフローとリポジトリ構造の調査
- [x] 実施計画の作成 (implementation_plan.md)
- [x] 進捗管理用ファイルの作成 (docs/progress/task.md)
- [x] Antigravity 基本ワークフローの作成 (`/init`, `/save`, `/resume`)
- [x] README.md の更新 (リポジトリテンプレートおよび AI 連携の説明)
- [x] AGENT.md のモジュール化と日本語化 (.agent/rules/ への分割)
- [x] 検証ルールの詳細化 (ビルド確認と ktlintFormat の義務化)

## フェーズ 2: CI/CD ワークフローの改善 [x]
- [x] 不要なキャッシュ操作の削除（重複の整理）
- [x] トリガー条件の個別最適化 (paths の詳細設定)
- [x] GitHub Actions の共通処理を Composite Action へ集約 (Checkout 位置のエラー修正を含む)
- [x] 各 Action の `actions/cache` バージョンを v4 へアップデート (Composite Action 内で対応)
- [x] (削除) 自動リリースワークフロー (`release.yml`) の追加
- [x] (削除) Lint 自動修正またはチェック強化の検討

## 決定事項・メモ
- **トークン節約**: `AGENT.md` をインデックス化し、必要なときのみ `rules/*.md` を読み込む構成を採用。
- **検証フロー**: 作業完了報告前に `./gradlew assembleDebug` と `./gradlew ktlintFormat` を実行することを必須ルールとし、`coding.md` に集約。
- **タスク・Issue ライフサイクル**:
    - 要望受領時の `task.md` 更新、Issue 起票、`gh issue develop` によるブランチ作成、`git fetch/checkout` の順序を厳守。
    - 完了時はユーザーによる `push` 確認を経て、エージェントが PR を作成し、ユーザーがマージするフローを確立。
    - エージェントは「ナビゲーター」として、常にユーザーに次のステップを指示する。
- **Git 操作**: 破壊的操作（commit, push）はエージェントには禁止し、読み取り操作のみを許可。
- **CI/CD トリガー**: 
    - `paths` によるホワイトリスト形式を採用。
    - パス指定を（1.ワークフロー 2.ソースコード 3.Gradle関連）の順で論理的にグループ化。
    - `ktlint` のトリガーには実在する `.editorconfig` を含め、`androidLint` からは存在しない `lint.xml` を除外。
- **GitHub 連携ワークフロー**:
    - `/issue_new` (Issue 起票), `/issue_comment` (コメント追記・本文更新) を導入し、テンプレート (`.github/ISSUE_TEMPLATE/task.md`) を活用した Issue 駆動開発を強化。
- **ディレクトリ権限**:
    - `.agent/rules/` は書き込み制限があるが、`.agent/workflows/` はエージェントによる直接編集が可能であることを確認。

## フェーズ 3: 仕上げと検証 [x]
- [x] 全ワークフローの動作確認（ユーザーによる最終検証完了）
- [x] Release Drafter の導入
- [x] バージョン同期 (version.properties) の導入
- [x] テンプレートとしての最終調整

## フェーズ 4: カスタマイズ性の向上 [x]
- [x] パッケージ名を標準プレースホルダー (com.example) へ変更
- [x] プロジェクト名・パッケージ名一括置換スクリプトの作成 (.sh, .ps1)
- [x] README.md へのカスタマイズ手順の追記

## フェーズ 5: ルールのブラッシュアップ [x]
- [x] Git 操作ルールの見直し（読み取り専用コマンドの自動実行許可）[#74](https://github.com/asabon/AndroidAppTemplate/issues/74)
- [x] GitHub 操作ルールの導入とワークフローの強化（テンプレート活用）
- [x] 検証ルールの `coding.md` への統合と視認性向上
- [x] フィードバックサイクルの最適化
- [x] Git/GitHub 操作ルールの更新（読み取り専用コマンドの自動実行許可） [#86](https://github.com/asabon/AndroidAppTemplate/issues/86)

## フェーズ 6: 運用支援ツールの拡充 [x]
- [x] Release Drafter 用 GitHub Labels セットアップスクリプトの作成 (.sh, .ps1) [#80](https://github.com/asabon/AndroidAppTemplate/issues/80)
- [x] セッション完了フロー（task.md更新タイミング、ブランチ削除）の最適化 [#82](https://github.com/asabon/AndroidAppTemplate/issues/82)
- [x] `/save` ワークフローへの「栞（Checkpoint）」機能の導入 [#84](https://github.com/asabon/AndroidAppTemplate/issues/84)

- **Checkpoint: 2025-12-28 (完了)**
    - 状況: Issue #86 (Git/GitHub操作ルールの更新) を完了し、PR #87 をマージしました。タスク進捗ファイル (`task.md`) 上の全フェーズは完了状態です。
    - 具体的次の一手: 新しい改善要望または機能開発の指示待ち。

## フェーズ 7: ユーザビリティ向上 [/]
- [x] テンプレート説明用 README の分離 (README.md -> docs/TEMPLATE_USAGE.md)

## フェーズ 8: ルール厳格化 [/]
- [x] ブランチ命名規則の強化 (日本語禁止の明文化とAlert化)


