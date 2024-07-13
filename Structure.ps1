$ScriptDir = & wsl -- wslpath -a "$PSScriptRoot"

. "$PSScriptRoot\WindowsShell\HostsSet.ps1"
wsl --update
wsl --shutdown
wsl bash "$ScriptDir/LinuxShell/Sudo.sh"
wsl --shutdown
. "$PSScriptRoot\WindowsShell\WSLConfCopy.ps1"
wsl --import "ArchLinux" "C:\ArchLinux" "C:\archlinux-bootstrap.tar"
wsl --shutdown
wsl --set-default "ArchLinux"
wsl --shutdown
wsl sh "$ScriptDir/LinuxShell/SystemLoad.sh"
wsl --shutdown
wsl sh "$ScriptDir/LinuxShell/UserLoad.sh"
wsl --shutdown
wsl --export --vhd "ArchLinux" "C:\ArchLinux.vhdx"
wsl --shutdown
