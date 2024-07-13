#!/bin/bash

Set=""
ParuConfPath="paru.conf"
BakPath=""
SetPath=""

usage() {
	echo "Usage: ${0} <-s 'Set1 Set2...'> [-p ParuConfPath] [-b BakPath] [-S SetPath]"
    exit 1
}

while getopts ":s:p:b:S:" opt; do
    case ${opt} in
        s) Set=${OPTARG} ;;
        p) ParuConfPath=${OPTARG} ;;
        b) BakPath=${OPTARG} ;;
        S) SetPath=${OPTARG} ;;
        \?) usage ;;
        :) usage ;;
    esac
done

[[ -z ${BakPath} ]] && BakPath=${ParuConfPath}.bak
[[ -z ${SetPath} ]] && SetPath=${ParuConfPath}
[[ -z ${Set} ]] && usage

mv ${ParuConfPath} ${BakPath} || { echo "Error: Failed to create backup"; exit 1; }

# 将Set字符串分割为数组，假设以空格分隔
IFS=' ' read -r -a keywords <<< ${Set}

# 遍历关键词数组
while IFS= read -r Line; do
	Count=0
	Sign=""
	while [[ -n ${keywords[ ${Count} ]} ]]; do
		if grep -q "#${keywords[ ${Count} ]}" <<< "${Line}" || [[ ${Line} == "#${keywords[ ${Count} ]}" ]]; then
			echo ${Line:1} >> ${SetPath}
			Sign="T"
			break
		fi
		((Count++))
	done
	if [[ ! ${Sign} ]]; then
		echo ${Line} >> ${SetPath}
	fi
done < ${BakPath}

echo "Processing of ParuConf completed"