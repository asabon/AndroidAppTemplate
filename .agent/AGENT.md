# Agent Rules (Index)

## 開発フロー
- **GitHub 開発フロー**:
  - 本プロジェクトでは、`github-dev-flow` スキルを主軸として開発を進めます。
  - パス: `.agent/skills/github-dev-flow/SKILL.md`
  - Issue 起票、ブランチ作成、PR 作成といった一連の流れについては、必ず上記スキルの手順を遵守してください。

## Core Rules
- **Language**:
  - You MUST strictly use **Japanese** for all responses (thoughts, messages, artifacts).

## Rule Modules
必要に応じて、以下の詳細ファイルを `view_file` で読み込み、内容を遵守してください。

- Git 操作に関するルール (命名規則・許可コマンド)
  - パス: `.agent/rules/git.md`
- GitHub 操作に関するルール (許可コマンド)
  - パス: `.agent/rules/github.md`
- タスク管理の補足事項 (task.md の扱い)
  - パス: `.agent/rules/task_management.md`
- コーディングに関するルール (Kotlin/Android, Jetpack Compose, 検証プロセス)
  - パス: `.agent/rules/coding.md`

---
## Guidelines
1. 開発の各ステップで `.agent/skills/github-dev-flow/SKILL.md` に定義されたスキルを優先的に活用し、一貫性を保ってください。
2. 作業中の具体的な進捗は `docs/progress/task.md` (またはスキルが推奨する場所) で管理してください。
3. **サブモジュールの修正**: スキル等のサブモジュールを修正する際は、必ずその直下の `CONTRIBUTING.md` を確認し、定義されたフロー（Issue/PR）に従ってください。
4. コードを変更する際は、必ず `coding.md` に記載の検証手順を実行してください。
