#!/bin/bash

ScriptDir=$(cd "$(dirname "$0")" && pwd)

cd ~
paru -S --noconfirm nvim-lazy neovim-symlinks
sudo paru -Scc --noconfirm
sh -c "$(curl -fsSL https://gitee.com/leok77/ohmyzsh-gitee/raw/main/install.gitee.sh)"
git clone --depth=1 "https://gitee.com/romkatv/powerlevel10k.git" "./powerlevel10k"
echo "source ~/powerlevel10k/powerlevel10k.zsh-theme" >> ".zshrc"
mkdir ".config"
mkdir ".config/nvim"
cp -R "${ScriptDir}/Set/nvim" ".config/nvim"