param (
    [Parameter(Mandatory=$true)]
    [string]$NewProjectName,

    [Parameter(Mandatory=$true)]
    [string]$NewPackageName
)

$OldProjectName = "AndroidAppTemplate"
$OldPackageName = "com.example.androidapptemplate"

Write-Host "Renaming project from $OldProjectName to $NewProjectName..."
Write-Host "Renaming package from $OldPackageName to $NewPackageName..."

# 1. Update settings.gradle.kts
(Get-Content settings.gradle.kts) -replace $OldProjectName, $NewProjectName | Set-Content settings.gradle.kts

# 2. Update package names in all relevant files
$Files = Get-ChildItem -Recurse -Include *.kt, *.kts, *.xml | Where-Object { $_.FullName -notmatch "\\\." }
foreach ($File in $Files) {
    (Get-Content $File.FullName) -replace $OldPackageName, $NewPackageName | Set-Content $File.FullName
    # Also update Theme name
    (Get-Content $File.FullName) -replace "AndroidAppTemplateTheme", "$($NewProjectName)Theme" | Set-Content $File.FullName
}

# 3. Move directory structure
$OldPackagePath = $OldPackageName.Replace(".", "\")
$NewPackagePath = $NewPackageName.Replace(".", "\")

function Move-Sources($BasePath) {
    $FullOldPath = Join-Path $pwd.Path "$BasePath\$OldPackagePath"
    $FullNewPath = Join-Path $pwd.Path "$BasePath\$NewPackagePath"

    if (Test-Path $FullOldPath) {
        Write-Host "Moving sources in $BasePath..."
        if (-not (Test-Path $FullNewPath)) {
            New-Item -Path $FullNewPath -ItemType Directory -Force
        }
        Copy-Item -Path "$FullOldPath\*" -Destination $FullNewPath -Recurse -Force
        Remove-Item -Path (Join-Path $pwd.Path "$BasePath\com") -Recurse -Force
    }
}

Move-Sources "app\src\main\java"
Move-Sources "app\src\test\java"
Move-Sources "app\src\androidTest\java"

Write-Host "Success! Project renamed to $NewProjectName."
Write-Host "Please sync Gradle and verify the changes."
