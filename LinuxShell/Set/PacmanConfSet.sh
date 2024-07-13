#!/bin/bash

Set=""
ParallelDownload=""
ArchCn=""
PacmanConfPath="pacman.conf"
BakPath=""
SetPath=""

usage() {
	echo "Usage: ${0} <-s 'Set1 Set2...'> [-P](ParallelDownload) [-A](ArchCn) [-p pacmanConfPath] [-b BakPath] [-S SetPath]"
    exit 1
}

while getopts ":s:PAp:b:S:" opt; do
    case ${opt} in
        s) Set=${OPTARG} ;;
        P) ParallelDownload="T" ;;
        A) ArchCn="T" ;;
        p) PacmanConfPath=${OPTARG} ;;
        b) BakPath=${OPTARG} ;;
        S) SetPath=${OPTARG} ;;
        \?) usage ;;
        :) usage ;;
    esac
done

[[ -z ${BakPath} ]] && BakPath=${PacmanConfPath}.bak
[[ -z ${SetPath} ]] && SetPath=${PacmanConfPath}
[[ -z ${Set} ]] && usage

cp ${PacmanConfPath} ${BakPath} || { echo "Error: Failed to create backup"; exit 1; }

# 将Set字符串分割为数组，假设以空格分隔
IFS=' ' read -r -a keywords <<< ${Set}

# 遍历关键词数组
for keyword in ${keywords[@]}; do
    # 使用sed命令删除包含关键词的行首的#
    sed -i "/^#${keyword}/s/^#//" ${SetPath} || { echo "Error processing keyword: ${keyword}"; exit 1; }
done

if [[ $ParallelDownload == "T" ]]; then
    if grep -q "ParallelDownloads" "$SetPath"; then
        sed -i 's/#ParallelDownloads.*/ParallelDownloads = 16/' "$SetPath"
    else
        echo "ParallelDownloads = 16" >> "$SetPath"
    fi
fi

if [[ ${ArchCn} ]]; then
	echo "" >> ${SetPath}
	echo "[archlinuxcn]" >> ${SetPath}
	echo "Server = https://mirrors.sjtug.sjtu.edu.cn/archlinux-cn/\$arch" >> ${SetPath}
	echo "Server = https://mirrors.ustc.edu.cn/archlinuxcn/\$arch" >> ${SetPath}
	echo "Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/\$arch" >> ${SetPath}
	echo "SigLevel = Never" >> ${SetPath}
fi

echo "Processing of PacmanConf completed"