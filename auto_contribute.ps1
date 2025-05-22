# Path to your Git repo
$repoPath = "C:\auto-contribute"
Set-Location $repoPath

# Max commit session duration
$startTime = Get-Date
$endTime = $startTime.AddHours(2)

# File options by tech
$allFiles = @(
    "techs\php_sample.php",
    "techs\laravel_sample.php",
    "techs\codeigniter_sample.php",
    "techs\js_sample.js",
    "techs\jquery_sample.js",
    "techs\react_sample.jsx",
    "techs\flask_sample.py"
)

# Pick 2–3 random techs to contribute for today
$todayFiles = Get-Random -InputObject $allFiles -Count (Get-Random -Min 2 -Max 4)

# Random number of commits for today (0 to 10)
$commitCount = Get-Random -Minimum 0 -Maximum 11

# Exit early if no commit today
if ($commitCount -eq 0) {
    Write-Output "No commits today. Taking a break!"
    exit
}

# Generate random commit times within 2 hours
$timeSlots = @()
while ($timeSlots.Count -lt $commitCount) {
    $randSeconds = Get-Random -Minimum 0 -Maximum 7200
    $timeSlot = $startTime.AddSeconds($randSeconds)
    if ($timeSlot -lt $endTime) {
        $timeSlots += $timeSlot
    }
}
$timeSlots = $timeSlots | Sort-Object

foreach ($time in $timeSlots) {
    $waitSeconds = ($time - (Get-Date)).TotalSeconds
    if ($waitSeconds -gt 0) {
        Start-Sleep -Seconds $waitSeconds
    }

    # Pick 1–2 files from selected techs
    $filesToEdit = Get-Random -InputObject $todayFiles -Count (Get-Random -Min 1 -Max 3)

    foreach ($file in $filesToEdit) {
        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        Add-Content -Path "$repoPath\$file" -Value "// commit at $timestamp"
    }

    git add .

    $commitMessages = @(
        "Tweak: minor improvements",
        "Update logic slightly",
        "Fix small typo",
        "Add log line",
        "Refactor sample code",
        "Daily edit at $(Get-Date -Format 'HH:mm')"
    )
    $message = Get-Random -InputObject $commitMessages

    git commit -m $message
    git push origin main

    Write-Output "Committed at $(Get-Date -Format 'HH:mm:ss') with message: $message"
}