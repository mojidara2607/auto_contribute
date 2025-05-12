$repoPath = "D:\wamp\www\vivek training programs\Personal\auto_contribute"
$techFiles = @{
    "PHP" = "index.php"
    "Laravel" = "laravel_sample.php"
    "CodeIgniter" = "codeigniter_sample.php"
    "React" = "react_sample.jsx"
    "jQuery" = "jquery_sample.js"
    "JavaScript" = "js_sample.js"
    "Flask" = "flask_sample.py"
}

# Pick 2 to 3 random techs
$selectedTechs = Get-Random -InputObject $techFiles.Keys -Count (Get-Random -Minimum 2 -Maximum 4)

foreach ($tech in $selectedTechs) {
    # Wait random seconds (up to 3 hours)
    $delay = Get-Random -Minimum 600 -Maximum 10800
    Start-Sleep -Seconds $delay

    $file = "$repoPath\techs\$($techFiles[$tech])"
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $file -Value "// Auto commit for $tech at $timestamp"

    cd $repoPath
    git add .
    git commit -m "Auto update $tech at $timestamp"
    git push origin main
}
