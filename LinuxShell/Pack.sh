#!/bin/bash

ScriptDir=$(cd "$(dirname "$0")" && pwd)

cd ~
bash "${ScriptDir}/PackRelianceDownLoad.sh"
mkdir "ArchLinux"
cd "./ArchLinux/"
while ! curl -f -O "https://mirrors.ustc.edu.cn/archlinux/iso/latest/archlinux-bootstrap-x86_64.tar.zst"; do
  :
done
# 使用bsdtar而非tar是因为GNU tar不会保留拓展属性（extended attributes）
# https://wiki.archlinux.org/title/Full_system_backup_with_tar
bsdtar -xpf archlinux-bootstrap-x86_64.tar.zst
cp "${ScriptDir}/Set/wsl.conf" "./root.x86_64/etc/wsl.conf"
rm "./root.x86_64/etc/machine-id"
bash "${ScriptDir}/Set/LocaleGenSet.sh" -s "zh_ CN en_US" -l "./root.x86_64/etc/locale.gen"
echo -e "LANG = en_US.UTF-8\n" > "./root.x86_64/etc/locale.conf"
bash "${ScriptDir}/Set/MirrorlistSet.sh" -s "China" -n 5 -k 25 -m "./root.x86_64/etc/pacman.d/mirrorlist"
bash "${ScriptDir}/Set/PacmanConfSet.sh" -s "Color CheckSpace" -PA -p "./root.x86_64/etc/pacman.conf"
# 重新打包为archlinux-bootstrap.tar文件
bsdtar -cpf archlinux-bootstrap.tar -C root.x86_64 .
# 移动archlinux-bootstrap.tar到C盘
mv "archlinux-bootstrap.tar" "/mnt/c"