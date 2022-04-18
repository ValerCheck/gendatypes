param (
    [string]$version = $null,
    [switch]$autoIncrement = $true
)

Function Get-AutoIncrementedVersion {
    Param ([string]$CurrentVersionString)

    $currentVersion = [System.Version]::Parse($CurrentVersionString.Split(" ")[1])
    $newVersionString = "{0}.{1}.{2}.{3}" -f ($currentVersion.Major, $currentVersion.Minor, $currentVersion.Build, $($currentVersion.Revision + 1))
    "Version: {0}" -f $newVersionString
}

$currentVersionString = @(cat "DESCRIPTION") -match "Version"
Write-Host $currentVersionString
$newVersionString = &{if ($autoIncrement -eq $true) {Get-AutoIncrementedVersion -CurrentVersionString $currentVersionString} else {$version} }
((Get-Content -Path "DESCRIPTION" -Raw) -replace $currentVersionString, $newVersionString) | Set-Content -Path "DESCRIPTION"

$newVersion = ("v{0}" -f ($newVersionString | Select-String -Pattern "\d.+").Matches.Value)

git add .
git commit -m ("Update version: {0}" -f $newVersion)
git tag $newVersion
git push --quiet
git push --tags --quiet
