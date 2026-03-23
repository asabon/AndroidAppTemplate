# build-aab

## 概要

- "v1.0.0" のように "v" で始まるタグを付けると、そのバージョンの AAB がビルドされて GitHub のリリースページにアップロードされます。
- workflow_dispatch イベントを使って手動でビルドをトリガーすることもできますが、その場合は GitHub のリリースページにアップロードされることはありません。

## ディレクトリ・ファイル構成

```text
+ .github/
  + workflows/
    + build-aab.yml     # AAB ビルドとリリースを実行する GitHub Actions ワークフロー定義。
+ app/
  + build.gradle.kts    # Android アプリのビルド設定ファイル。
+ buld.gradle.kts       # プロジェクト全体のビルド設定ファイル。
```

## 設定方法

1. 上記ディレクトリ構成を維持したまま、ファイル(build-aab.yml)をコピーする。
2. GitHub のリポジトリに対する設定で、Secrets に以下を追加する。
   - `KEYSTORE_BASE64`
     - キーストアファイルを Base64 エンコードした文字列
     - GitHub Actions により、この文字列がデコードされて keystore.jks というファイル名で保存される。
   - `KEYSTORE_PROPERTIES`
       ```text
       storeFile=keystore.jks
       storePassword=キーストアのパスワード
       keyAlias=キーペアのエイリアス
       keyPassword=キーペアのパスワード
       ```
3. アプリの `build.gradle.kts` に以下を追加する。
   ```kotlin
   import org.jetbrains.kotlin.gradle.dsl.JvmTarget
   import org.jlleitschuh.gradle.ktlint.reporter.ReporterType
   import java.io.FileInputStream // ← これを追加★
   // ... 省略

   android {
     // ... 省略
     // ここから追加★
     signingConfigs {
       create("release") {
         // keystore.properties から情報を読み込む
         // - GitHub Actions の場合は Secrets から設定される
         // - ローカルでビルドする場合は、プロジェクトルートに keystore.properties が配置されている前提
         val propsFile = rootProject.file("keystore.properties")
         // 単なるビルドチェックなど、署名付き AAB を生成しない場合は keystore.properties は不要
         // その場合は signingConfig の設定をスキップする
         if (propsFile.exists()) {
           val props =
             Properties().apply {
               load(FileInputStream(propsFile))
             }
           storeFile = rootProject.file(props["storeFile"] as String)
           storePassword = props["storePassword"] as String
           keyAlias = props["keyAlias"] as String
           keyPassword = props["keyPassword"] as String
         } else {
           println("⚠️ keystore.properties not found, skipping signingConfig setup")
         }
       }
     }
     // ここまで追加★
     // ... 省略
     buildTypes {
       // ... 省略
       release {
         // ここから追加★
         val propsFile = rootProject.file("keystore.properties")
         if (propsFile.exists()) {
           signingConfig = signingConfigs.getByName("release")
         } else {
           println("⚠️ keystore.properties not found, skipping signingConfig assignment")
         }
         // ここまで追加★
         // ... 省略
       }
     }
   }
   ```
4. ローカルでビルドできるようにする場合は、プロジェクトルートに、 'keystore.jks' と 'keystore.properties' を配置する。
   - (重要)ただし、これらのファイルは Git 管理下に置かないように、`.gitignore` に追加しておくこと。
   - キーストアファイルは Base64 エンコードする前のものを keystore.jks として配置する。
   - keystore.properties の中身は、上記 `KEYSTORE_PROPERTIES` と同じものを配置する。

## 使い方

1. GitHub で Release を行う際にタグを打つことができますが、
   その際に "v1.0.0" のように "v" で始まるタグを付けてコミットをプッシュすると、
   署名付きの AAB がビルドされて GitHub のリリースページにアップロードされます。
   - バージョン番号は build.gradle.kts の記述に依存します。
   - 自動的にバージョン番号を更新するような処理は入っていない、必要に応じて手動で更新してください。
