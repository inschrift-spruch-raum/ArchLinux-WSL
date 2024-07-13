#!/bin/bash

Scope=""
SudoersPath="sudoers"
BakPath=""
SetPath=""

usage() {
	echo "Usage: ${0} <-s 'Scope1,Scope2...'> [-p SudoersPath] [-b BakPath] [-S SetPath]"
    exit 1
}

while getopts ":s:p:b:S:" opt; do
    case ${opt} in
        s) Scope=${OPTARG} ;;
        p) SudoersPath=${OPTARG} ;;
        b) BakPath=${OPTARG} ;;
        S) SetPath=${OPTARG} ;;
        \?) usage ;;
        :) usage ;;
    esac
done

[[ -z ${BakPath} ]] && BakPath=${SudoersPath}.bak
[[ -z ${SetPath} ]] && SetPath=${SudoersPath}
[[ -z ${Scope} ]] && usage

mv ${SudoersPath} ${BakPath} || { echo "Error: Failed to create backup"; exit 1; }

# 将Scope字符串分割为数组，假设以`,`分隔
IFS=',' read -r -a keywords <<< ${Scope}

while IFS= read -r Line; do
	Count=0
	Sign=""
	while [[ -n ${keywords[ ${Count} ]} ]]; do
		if grep -q "# ${keywords[ ${Count} ]}" <<< "${Line}" || [[ ${Line} == "# ${keywords[ ${Count} ]}" ]]; then
			echo ${Line:2} >> ${SetPath}
			Sign="T"
			break
		fi
		((Count++))
	done
	if [[ ! ${Sign} ]]; then
		echo ${Line} >> ${SetPath}
	fi
done < ${BakPath}

echo "Processing of Sudoers completed"