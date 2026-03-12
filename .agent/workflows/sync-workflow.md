---
description: テンプレートリポジリから最新のワークフローを取り込みます
---
このコマンドは、antigravity-workflow テンプレートの更新内容（新しいルールやワークフロー改善など）を、既存のプロジェクトに取り込むためのコマンドです。

AIエージェントは、以下の手順で更新作業を慎重かつ効率的に行ってください。

1. **一時的なリモートの登録**
   - テンプレートリポジリ (`https://github.com/asabon/antigravity-workflow.git`) を、現在のプロジェクトに一時的なリモート（例: `upstream-sync`）として登録してください。
   - `git remote add upstream-sync https://github.com/asabon/antigravity-workflow.git`

2. **最新情報の取得**
   - `git fetch upstream-sync main` を実行し、テンプレートの最新の差分情報を取得してください。

3. **差分の分析と要約（インテリジェント・プロポーザル）**
   - `git diff upstream-sync/main -- .antigravityrule .agent/ scripts/ .github/ .vscode/` を実行し、主要なルールや設定ファイルの差分を確認してください。
   - 抽出した差分を AI が精読し、以下の内容をユーザーに要約して提示してください：
     - **変更があったファイルと、その大まかな内容（例：規約の追加、バグ修正、機能改善）**
     - **適用を推奨するもの、および現在のカスタマイズと競合する可能性があるものの分類**
   - ユーザーに対し、「すべて適用」「選択して適用」「詳細は各ファイルを確認」などの次のアクションを求めてください。

4. **選択的反映の実行**
   - ユーザーから承認を得た箇所について、以下のいずれかの方法で反映を行ってください：
     - ファイル全体を最新にする場合: `git checkout upstream-sync/main -- <path>`
     - 部分的にマージする場合: `git restore --source upstream-sync/main --patch <path>` または AI が必要な箇所だけをコード編集ツールで修正。

5. **後片付けと報告**
   - 同期が完了したら、一時的に登録したリモートを削除してください： `git remote remove upstream-sync`
   - 最終的に取り込んだ変更点のリストをユーザーに報告し、完了としてください。
