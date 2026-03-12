# Release Drafter 用の GitHub ラベルをセットアップするスクリプト
# 各ラベルが既に存在してもエラーにならないように制御します。

$ErrorActionPreference = "Stop"

# ラベル定義
$labels = @(
    # 分類ラベル (Category Labels)
    @{ name = "enhancement"; color = "a2eeef"; description = "新機能・機能改善" }
    @{ name = "bug"; color = "d73a4a"; description = "不具合報告・修正" }
    @{ name = "documentation"; color = "0075ca"; description = "ドキュメント更新" }
    @{ name = "refactor"; color = "1d76db"; description = "リファクタリング" }
    @{ name = "chore"; color = "c5def5"; description = "雑務・ビルド関連" }
    @{ name = "test"; color = "006b75"; description = "テスト追加・修正" }
    @{ name = "research"; color = "6bc59a"; description = "調査・リサーチ" }
    @{ name = "question"; color = "cc317c"; description = "質問" }
    @{ name = "discussion"; color = "0052cc"; description = "議論・検討" }
    @{ name = "security"; color = "e99695"; description = "セキュリティ" }
    
    # リリース調整ラベル (Release Labels)
    @{ name = "major"; color = "0e8a16"; description = "メジャーバージョンアップ（破壊的変更あり）" }
    @{ name = "minor"; color = "fbca04"; description = "マイナーバージョンアップ（機能追加）" }
    @{ name = "breaking"; color = "d93f0b"; description = "破壊的変更" }

)

Write-Host "Checking and creating GitHub Labels for Release Drafter..." -ForegroundColor Cyan

foreach ($label in $labels) {
    $existing = gh label list --search $label.name | Where-Object { $_ -match "\b$($label.name)\b" }
    
    if ($existing) {
        Write-Host "Label '$($label.name)' already exists. Updating..." -ForegroundColor Yellow
        gh label edit $label.name --color $label.color --description $label.description
    }
    else {
        Write-Host "Creating label '$($label.name)'..." -ForegroundColor Green
        gh label create $label.name --color $label.color --description $label.description
    }
}

Write-Host "Labels setup completed!" -ForegroundColor Cyan
