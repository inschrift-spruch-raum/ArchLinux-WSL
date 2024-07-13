#!/bin/bash

Scope=""
LocaleGenPath="locale.gen"
BakPath=""
SetPath=""

usage() {
	echo "Usage: ${0} <-s 'Scope1 Scope2...'> [-l LocaleGenPath] [-b BakPath] [-S SetPath]"
    exit 1
}

while getopts ":s:l:b:S:" opt; do
    case ${opt} in
        s) Scope=${OPTARG} ;;
        l) LocaleGenPath=${OPTARG} ;;
        b) BakPath=${OPTARG} ;;
        S) SetPath=${OPTARG} ;;
        \?) usage ;;
        :) usage ;;
    esac
done

[[ -z ${BakPath} ]] && BakPath=${LocaleGenPath}.bak
[[ -z ${SetPath} ]] && SetPath=${LocaleGenPath}
[[ -z ${Scope} ]] && usage

cp ${LocaleGenPath} ${BakPath} || { echo "Error: Failed to create backup"; exit 1; }

# 将Scope字符串分割为数组，假设以空格分隔
IFS=' ' read -r -a keywords <<< ${Scope}

# 遍历关键词数组
for keyword in ${keywords[@]}; do
    # 使用sed命令删除包含关键词的行首的#
    sed -i "/${keyword}/s/^#//" ${SetPath} || { echo "Error processing keyword: ${keyword}"; exit 1; }
done

echo "Processing of LocaleGen completed"