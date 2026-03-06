#!/bin/bash

# Release Drafter 用の GitHub ラベルをセットアップするスクリプト
# 各ラベルが既に存在してもエラーにならないように制御します。

set -e

# ラベル定義: "名前:カラー:説明"
LABELS=(
  "enhancement:a2eeef:新機能・機能改善"
  "bug:d73a4a:不具合報告・修正"
  "documentation:0075ca:ドキュメント更新"
  "refactor:1d76db:リファクタリング"
  "chore:c5def5:雑務・ビルド関連"
  "test:006b75:テスト追加・修正"
  "major:0e8a16:メジャーバージョンアップ（破壊的変更あり）"
  "minor:fbca04:マイナーバージョンアップ（機能追加）"
  "breaking:d93f0b:破壊的変更"
  "working:fef2c0:現在作業中"
)

echo "Checking and creating GitHub Labels for Release Drafter..."

for label_info in "${LABELS[@]}"; do
  IFS=':' read -r name color description <<< "$label_info"
  
  if gh label list --search "$name" | grep -q -w "$name"; then
    echo "Label '$name' already exists. Updating..."
    gh label edit "$name" --color "$color" --description "$description"
  else
    echo "Creating label '$name'..."
    gh label create "$name" --color "$color" --description "$description"
  fi
done

echo "Labels setup completed!"
