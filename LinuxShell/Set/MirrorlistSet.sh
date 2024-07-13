#!/bin/bash

#The Shell script features:
#Set Mirrorlist without changing other parts
#Generally, it is necessary to overwrite the source file
#We do not rule out user requirements for the storage location of files in the feature
#and provide settings for the storage location

Scope=""
ServerNum=128
SkipServerNum=0
MirrorlistPath="mirrorlist"
BakPath=""
SetPath=""

usage() {
	echo "Usage: ${0} <-s Scope> [-n ServerNum] [-k SkipServerNum] [-m MirrorlistPath] [-b BakPath] [-S SetPath]"
    exit 1
}

while getopts ":s:n:k:m:b:S:" opt; do
    case ${opt} in
        s) Scope=${OPTARG} ;;
        n) ServerNum=${OPTARG} ;;
        k) SkipServerNum=${OPTARG} ;;
        m) MirrorlistPath=${OPTARG} ;;
        b) BakPath=${OPTARG} ;;
        S) SetPath=${OPTARG} ;;
        \?) usage ;;
        :) usage ;;
    esac
done

[[ -z ${BakPath} ]] && BakPath=${MirrorlistPath}.bak
[[ -z ${SetPath} ]] && SetPath=${MirrorlistPath}
[[ -z ${Scope} ]] && usage

mv ${MirrorlistPath} ${BakPath} || { echo "Error: Failed to create backup"; exit 1; }

ServerCount=0
SkipServerCount=0
FoundScope=""
while IFS= read -r Line; do
    if [[ ${Line} == "## ${Scope}" ]]; then
        echo ${Line} >> ${SetPath}
        FoundScope="T"
    elif [[ ${FoundScope} ]]; then
        if [[ ${Line} =~ ^[[:space:]]*#Server ]] && [[ ${ServerCount} -lt ${ServerNum} ]] && [[ ${SkipServerCount} -ge ${SkipServerNum} ]]; then
            echo ${Line#*#} >> ${SetPath}
			((ServerCount++))
        elif [[ ${SkipServerCount} -lt ${SkipServerNum} ]]; then
			echo ${Line} >> ${SetPath}
			((SkipServerCount++))
        else
            if [[ ${ServerCount} -ge ${ServerNum} ]] || [[ -z ${Line} ]]; then
                FoundScope=""
            fi
            echo ${Line} >> ${SetPath}
        fi
    else
        echo ${Line} >> ${SetPath}
    fi
done < ${BakPath}

echo "Processing of mirrorlist completed"