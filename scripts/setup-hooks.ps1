# Git Hooks をセットアップするスクリプト (Windows 用)
# .hooks ディレクトリを git の hooksPath に設定します。

$ErrorActionPreference = "Stop"

Write-Host "Setting up Git Hooks..." -ForegroundColor Cyan

# .hooks ディレクトリの存在確認
if (-not (Test-Path ".hooks")) {
    Write-Error "Error: .hooks directory not found."
    exit 1
}

# git config の設定
git config core.hooksPath .hooks

# 結果の確認
$currentPath = git config core.hooksPath
if ($currentPath -eq ".hooks") {
    Write-Host "Git Hooks registered successfully! (Path: .hooks)" -ForegroundColor Green
} else {
    Write-Error "Failed to register Git Hooks."
    exit 1
}
