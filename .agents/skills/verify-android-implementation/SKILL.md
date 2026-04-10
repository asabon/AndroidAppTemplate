---
name: verify-android-implementation
description: 実装作業完了後に、ビルド・テスト・Lint を網羅的に検証します
---

# Android 検証スキル

このスキルは、Android プロジェクトにおいてコードの変更が完了した後に、アプリの品質と安定性を保証するための「必須検証手順」を定義します。

## 適用タイミング

- 実装作業が完了し、ユーザーに報告する直前
- Pull Request を作成・更新する直前
- 重要なリファクタリングを行った後

## 検証手順 (Step 0 - 6)

**実行前に必ず、以下の 0 から 6 を順番に実行してください。途中でエラーが発生した場合は「失敗時の対応」に従って修正し、最初からやり直してください。**

### 0. 事前確認と教訓の参照 (必須)
前回の実行で得られた教訓や、現在意図的に無視されている警告を確認し、無駄な試行錯誤を避けてください。
- **教訓**: [lessons-learned.md](references/lessons-learned.md)
- **抑制リスト**: [suppression-list.md](references/suppression-list.md)
- **アクション**: 解除条件を満たしている抑制項目があれば、可能であれば今回合わせて修正を試みてください。

### 1. ビルド確認
```pwsh
./gradlew assembleDebug
```
ビルドエラーが起きないことを確認します。

### 2. ユニットテスト
```pwsh
./gradlew testDebugUnitTest
```
すべてのテストがパスすることを確認します。

### 3. 静的解析と自動整形 (ktlint)
まず自動整形を行い、次に整形しきれなかった警告（100文字制限など）をチェックします。
```pwsh
./gradlew ktlintFormat ktlintCheck
```
> [!IMPORTANT]
> 行の長さ (100文字制限) は `ktlintFormat` では自動修正されません。必ず `ktlintCheck` でエラーが出ないか確認し、必要に応じて手動で改行してください。

### 4. Android Lint 解析
プロジェクト全体のポテンシャルな不具合や規約違反をチェックします。
```pwsh
./gradlew lintDebug
```

### 5. 厳格なレポート確認 (最重要)
ビルドが成功 (`Exit code: 0`) しても、生成されたレポートファイルを `view_file` で開き、**警告 (Warning) が 1 つも残っていないこと** を目視で確認してください。

- **ktlint レポート**: `app/build/reports/ktlint/**/*.html` (XML も可)
  - **特に 100 文字制限 (Line Length)**: 自動修正されないため、目視で必ず確認してください。
- **Android Lint レポート**: `app/build/reports/lint-results-debug.xml` (または .html)
  - 未使用のリソースや、パフォーマンス上の懸念がないかを確認します。

> [!IMPORTANT]
> レポートが見つからない場合は、`ls -R app/build/reports` を実行して正確なパスを特定してください。

### 6. 自己改善 (教訓・抑制の記録)
検証が完了したら、今回の過程で得られた知見を **[lessons-learned.md](references/lessons-learned.md)** に、新しく意図的に抑制した警告があれば **[suppression-list.md](references/suppression-list.md)** に追記してください。
**※問題なく完了した場合でも、「今回の環境ではこの手順がスムーズだった」等の知見があれば記録してください。**

---

## 失敗時・警告発生時の対応

- 1 つでも失敗した項目、または警告が残っている場合は、原因を特定してコードを修正してください。
- 修正後、再度 **手順 1 から** 全てをやり直してください。
- 全ての項目がクリアされるまで、作業の完了を報告したり、PR のマージを依頼してはいけません。