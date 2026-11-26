param (
    [string]$RootFolder = "C:\Users\Saalim.Wani\Documents\reporting-catalog"
)

if (-not (Test-Path $RootFolder)) {
    Write-Host "Folder not found: $RootFolder"
    exit 1
}

Write-Host "Searching recursively in:"
Write-Host $RootFolder
Write-Host ""

$files = @(
    Get-ChildItem -Path $RootFolder -Recurse -File -Filter "*.rdl" -ErrorAction SilentlyContinue |
        Where-Object {
            # Check for any dot inside the filename,
            # excluding the normal .rdl extension
            $_.BaseName -match "\."
        }
)

foreach ($file in $files) {
    Write-Host "File Name : $($file.Name)"
    Write-Host "Location  : $($file.DirectoryName)"
    Write-Host "Full Path : $($file.FullName)"
    Write-Host "------------------------------------------------------------"
}

Write-Host ""
Write-Host "============================================================"
Write-Host "Total RDL files containing extra dot: $($files.Count)"
Write-Host "============================================================"