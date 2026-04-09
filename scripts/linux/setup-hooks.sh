#!/bin/bash

# Git Hooks をセットアップするスクリプト (Linux/macOS 用)
# .hooks ディレクトリを git の hooksPath に設定します。

set -e

echo "Setting up Git Hooks..."

# .hooks ディレクトリの存在確認
if [ ! -d ".hooks" ]; then
    echo "Error: .hooks directory not found."
    exit 1
fi

# git config の設定
git config core.hooksPath .hooks

# 結果の確認
current_path=$(git config core.hooksPath)
if [ "$current_path" = ".hooks" ]; then
    echo "Git Hooks registered successfully! (Path: .hooks)"
else
    echo "Failed to register Git Hooks."
    exit 1
fi
