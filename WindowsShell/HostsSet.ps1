$source = Join-Path $PSScriptRoot "hosts"
$destination = "C:\Windows\System32\drivers\etc\hosts"
$temp = "C:\Windows\System32\drivers\etc\temp"
(Get-Content -Path $destination) + (Get-Content -Path $source) | Set-Content -Path $temp
Rename-Item -Path $destination -NewName "hosts.bak"
Rename-Item -Path $temp -NewName "hosts"