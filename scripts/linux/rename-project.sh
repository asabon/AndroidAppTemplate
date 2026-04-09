#!/bin/bash

# プロジェクト名とパッケージ名の一括置換スクリプト
# 使い方: ./scripts/rename-project.sh "NewProjectName" "com.new.package.name"

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <NewProjectName> <NewPackageName>"
    echo "Example: $0 MyCoolApp com.mycompany.mycoolapp"
    exit 1
fi

NEW_PROJECT_NAME=$1
NEW_PACKAGE_NAME=$2
OLD_PROJECT_NAME="AndroidAppTemplate"
OLD_PACKAGE_NAME="com.example.androidapptemplate"

echo "Renaming project from $OLD_PROJECT_NAME to $NEW_PROJECT_NAME..."
echo "Renaming package from $OLD_PACKAGE_NAME to $NEW_PACKAGE_NAME..."

# 1. プロジェクト名の置換 (settings.gradle.kts)
sed -i "s/$OLD_PROJECT_NAME/$NEW_PROJECT_NAME/g" settings.gradle.kts

# 2. パッケージ名の置換 (build.gradle.kts, AndroidManifest.xml, Source codes)
# 全てのファイルを検索してパッケージ名を置換
find . -type f \( -name "*.kt" -o -name "*.kts" -o -name "*.xml" \) -not -path "*/.*" -exec sed -i "s/$OLD_PACKAGE_NAME/$NEW_PACKAGE_NAME/g" {} +

# 3. ディレクトリ構造の移動
NEW_PACKAGE_PATH=$(echo $NEW_PACKAGE_NAME | sed 's/\./\//g')
OLD_PACKAGE_PATH=$(echo $OLD_PACKAGE_NAME | sed 's/\./\//g')

move_sources() {
    local base_path=$1
    local old_path="$base_path/$OLD_PACKAGE_PATH"
    local new_path="$base_path/$NEW_PACKAGE_PATH"

    if [ -d "$old_path" ]; then
        echo "Moving sources in $base_path..."
        mkdir -p "$new_path"
        cp -r "$old_path"/* "$new_path/"
        rm -rf "$base_path/com" # 旧構造を削除 (com.example... を想定)
    fi
}

move_sources "app/src/main/java"
move_sources "app/src/test/java"
move_sources "app/src/androidTest/java"

# 4. テーマ名の置換 (AndroidAppTemplateTheme -> NewProjectNameTheme)
sed -i "s/AndroidAppTemplateTheme/${NEW_PROJECT_NAME}Theme/g" $(find . -name "*.kt")

echo "Success! Project renamed to $NEW_PROJECT_NAME."
echo "Please sync Gradle and verify the changes."
