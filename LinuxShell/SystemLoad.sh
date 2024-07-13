#!/bin/bash

ScriptDir=$(cd "$(dirname "$0")" && pwd)

echo -e "\n[user]\ndefault = Zero\n" >> /etc/wsl.conf
systemd-machine-id-setup
locale-gen
pacman-key --init
pacman-key --populate
pacman -Sy
pacman -S --needed --noconfirm archlinux-keyring archlinuxcn-keyring
pacman -Syyu --needed --noconfirm base base-devel glibc zsh zsh-completions curl wget git zstd neovim vifm paru
bash "${ScriptDir}/Set/ParuConfSet.sh" -s "BottomUp [bin] FileManager" -p "/etc/paru.conf"
bash "${ScriptDir}/Set/SudoersSet.sh" -s "root ALL=(ALL:ALL) ALL,%wheel ALL=(ALL:ALL) ALL" -p "/etc/sudoers"
useradd -m -G wheel -s /bin/zsh Zero
passwd
passwd Zero