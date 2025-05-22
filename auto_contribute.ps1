# contribute_loop.ps1

$repoPath = "C:\auto-contribute"
$startTime = Get-Date
$endTime = $startTime.AddHours(2)

$allFiles = @(
    "techs\php_sample.php",
    "techs\laravel_sample.php",
    "techs\codeigniter_sample.php",
    "techs\js_sample.js",
    "techs\jquery_sample.js",
    "techs\react_sample.jsx",
    "techs\flask_sample.py"
)

while ((Get-Date) -lt $endTime) {
    Set-Location $repoPath

    # Pick 2–3 random tech files
    $selected = Get-Random -InputObject $allFiles -Count (Get-Random -Min 2 -Max 4)

    foreach ($file in $selected) {
        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        Add-Content -Path "$repoPath\$file" -Value "// commit at $timestamp"
    }

    git add .
    git commit -m "Auto commit at $(Get-Date -Format 'HH:mm:ss')"
    git push origin main

    # Wait 5–15 minutes randomly before next commit
    $delay = Get-Random -Minimum 300 -Maximum 900
    Start-Sleep -Seconds $delay
}
