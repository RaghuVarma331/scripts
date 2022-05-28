#!/bin/bash

apt install unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract rename
apt install liblzma-dev python-pip brotli
pip install backports.lzma protobuf==3.18.0 pycrypto extract-dtb
echo -ne '\n' | ./12.sh
