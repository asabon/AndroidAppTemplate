---
trigger: always_on
---

# Git 操作ルール

## ブランチ命名規則
`github-dev-flow` スキルで `gh issue develop` を使用する際、以下の規約を遵守してください。

> [!IMPORTANT]
> **名前に日本語（全角文字）の使用は絶対禁止です**
> Issue タイトルが日本語の場合でも、**必ず英語に翻訳**してケバブケースにしてください。
> `--name` フラグで以下の形式を指定してください。

- **形式**: `[Issue番号]-kebab-case-description`
- **例**:
  - OK: `86-update-git-rules`
  - OK: `88-separate-readme` (元タイトル: テンプレート説明用 README の分離)
  - **NG**: `88-readme-の分離` (日本語が含まれている)
  - **NG**: `update-rules` (Issue番号がない)

- **サブモジュールの修正**:
  - サブモジュール（スキル等）に修正が必要な場合は、直接 `main` ブランチを編集してはいけません。
  - 必ず対象サブモジュールの直下にある `CONTRIBUTING.md` を確認し、そこに定義された開発フロー（Issue起票、PR作成等）に従ってください。

## バージョン管理 (Git)
- **禁止事項 (許可が必要)**:
  - 基本的にコミット、プッシュ、プル、ブランチ削除は、ユーザーの明示的な許可を得てください。
    - git commit
    - git push
    - git pull
    - git branch -d / -D
- **許可事項 (SafeToAutoRun: true)**:
  - 以下の読み取り専用および非破壊的な同期コマンドは、ユーザーの承認なしに実行できます：
    - git status / git status --porcelain
    - git log
    - git diff
    - git show
    - git branch (一覧表示)
    - git fetch origin
    - git remote prune origin
    - git remote -v
  - その他、リポジトリの状態を確認するための読み取り専用コマンドは自由に使用して構いません。
