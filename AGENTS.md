# プロジェクトエージェント向け指示（Cursor / 汎用）

このファイルは **Cursor** がリポジトリ根から参照しやすい入口です。  
**詳細な手順・規約の正本（Single Source of Truth）は `.agents/rules/` 以下**です。内容の更新は原則としてそちらで行い、このファイルは索引と最小限の不変制約のみを記します。

## 言語

- ユーザー向けの回答・説明は **日本語** を優先する。

## 絶対制約（全ツール共通）

- **`main` ブランチへの直接 `commit` / `push` は禁止**。作業用ブランチを切り、Pull Request 経由で取り込む。
- Git 操作の前に、現在ブランチが `main` でないことを確認する（例: `git branch --show-current`）。
- 実装完了後は、プロジェクト固有の検証手順を実行し、すべてパスすること。**Android プロジェクトでは [`.agents/rules/04_android.md`](.agents/rules/04_android.md) を参照。**

## 正本ルール一覧（フェーズごとに読む）

| タイミング | ファイル | 内容の概要 |
|------------|-----------|------------|
| タスク着手・ワークフロー全体 | [`.agents/rules/01_workflow.md`](.agents/rules/01_workflow.md) | ロードマップ / Issue / `/save` `/resume` `/cleanup` |
| Git 操作の前 | [`.agents/rules/02_git.md`](.agents/rules/02_git.md) | コミット形式、ブランチ命名、許可コマンド |
| GitHub（Issue / PR）操作の前 | [`.agents/rules/03_github.md`](.agents/rules/03_github.md) | 記述形式、ラベル、許可コマンド |
| Android 実装・検証 | [`.agents/rules/04_android.md`](.agents/rules/04_android.md) | Kotlin / Compose、検証コマンド |
| 自動実行の境界 | [`.agents/rules/auto-commands.yaml`](.agents/rules/auto-commands.yaml) | 許可なく実行してよいコマンド範囲 |

ワークフロー用テンプレの詳細は [`.agents/workflows/`](.agents/workflows/) を参照。

## Antigravity を使う場合

- Antigravity 用の索引・追加プロトコルは [`.antigravityrule`](.antigravityrule) を参照（**上記 `.agents/rules/` と併用**）。

## Cursor 用の補助

- 常時コンテキストとして [`.cursor/rules/project-core.mdc`](.cursor/rules/project-core.mdc) が適用される（要約・参照先の固定）。
