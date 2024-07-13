#!/bin/bash

sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list
sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
sed -i 's/http:/https:/g' /etc/apt/sources.list
while ! sudo apt update -y; do
  :
done
while ! sudo apt install libarchive-tools -y; do
  :
done