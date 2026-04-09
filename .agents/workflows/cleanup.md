---
description: マージ済みの作業ブランチとラベルを削除し、クリーンアップを行います
---

1. **マージ状況の確認**:
   - `git branch --show-current` で現在のブランチ名を確認する。
   - `gh pr view --json state` を実行し、ステータスが `MERGED` であることを確認する。
   - もし `MERGED` でない場合は中断し、ユーザーに状況を確認する。
2. **ブランチの切り替えと更新**:
   - `git checkout main` で `main` ブランチに切り替える。
   - `git pull` で最新の状態を取得する。
3. **不要ブランチの削除**:
   - `git branch -D <作業ブランチ名>` でローカルブランチを削除する。
   - `git remote prune origin` でリモート追跡ブランチを整理する。
4. **最終報告**:
   - クリーンアップが完了したこと、および次に着手可能なタスク（`docs/status/roadmap.md` 参照など）をユーザーに報告する。
