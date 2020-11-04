#!/bin/bash
#
# RAGHU VARMA Build Script 
# Coded by RV 
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

clear

# Detail Versions

path=/var/lib/jenkins/workspace/Raghu
securitypatch=2020-09-05

# credentials

Telegram_Api_code=$(cat $path/cred** | grep api | cut -d "=" -f 2)
chat_id=$(cat $path/cred** | grep id | cut -d "=" -f 2)
password=$(cat $path/cred** | grep sf | cut -d "=" -f 2)
gitpassword=$(cat $path/cred** | grep git | cut -d "=" -f 2)



# Init Methods

TOOLS_SETUP() 
{
        sudo apt-get update 
        echo -ne '\n' | sudo apt-get upgrade
        echo -ne '\n' | sudo apt-get install git ccache schedtool lzop bison gperf build-essential zip curl zlib1g-dev g++-multilib python-networkx libxml2-utils bzip2 libbz2-dev libghc-bzlib-dev squashfs-tools pngcrush liblz4-tool optipng libc6-dev-i386 gcc-multilib libssl-dev gnupg flex lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev xsltproc unzip python-pip python-dev libffi-dev libxml2-dev libxslt1-dev libjpeg8-dev openjdk-8-jdk imagemagick device-tree-compiler mailutils-mh expect python3-requests python-requests android-tools-fsutils sshpass
        sudo swapon --show
        sudo fallocate -l 20G /swapfile
        ls -lh /swapfile
        sudo chmod 600 /swapfile
        sudo mkswap /swapfile
        sudo swapon /swapfile
        sudo swapon --show
        sudo cp /etc/fstab /etc/fstab.bak
        echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
	git config --global user.email "raghuvarma331@gmail.com"
	git config --global user.name "RaghuVarma331"
	mkdir -p ~/.ssh  &&  echo "Host *" > ~/.ssh/config && echo " StrictHostKeyChecking no" >> ~/.ssh/config
	echo "# Allow Jenkins" >> /etc/sudoers && echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
} &> /dev/null




REPO()
{
       cd $path
       mkdir bin
       PATH=$path/bin:$PATH
       curl https://storage.googleapis.com/git-repo-downloads/repo > $path/bin/repo
       chmod a+x $path/bin/repo
} &> /dev/null


TWRP-Q-SOURCE()
{
    cd $path
    wget https://github.com/RaghuVarma331/scripts/raw/master/pythonscripts/telegram.py
    wget https://github.com/RaghuVarma331/custom_roms_banners/raw/master/twrp.jpg
    git clone https://$gitpassword@github.com/RaghuVarma331/otatools.git -b master M21
    mkdir twrp
    cd twrp
    echo -ne '\n' | repo init -u git://github.com/RaghuVarma331/Twrp-Manifest.git -b android-10.0 --depth=1
    repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
    git clone https://github.com/RaghuVarma331/android_device_samsung_m21-TWRP.git -b android-10.0 device/samsung/m21
    . build/envsetup.sh && lunch omni_m21-eng && make -j$(nproc --all) recoveryimage
    cd out/target/product/m21
    cp -r recovery.img $path/M21/bin
    cd $path/M21/bin
    chmod a+x pack.sh
    ./pack.sh
    sshpass -p $password rsync -avP -e ssh twrp-3.4.0-0** raghuvarma331@frs.sourceforge.net:/home/frs/project/sm-m215f/TWRP
    cd $path
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "
    *
    New Twrp-3.4.0-0 build
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/galaxy-m21/development/unofficial-twrp-3-4-0-0-team-win-t4185397)
    📱Device: *Galaxy M21*
    ⚡Build Version: *3.4.0-0*
    ⚡Android Version: *10.0*
    👤 By: *@RaghuVarma*
    #M21 #twrp #update
    Follow: @SamsungM21Updates ✅
    Join: @SamsungGalaxyM21Discussion ✅" 
}    

echo Setting up tools..!!
TOOLS_SETUP
echo downloading repo..!!
REPO
echo "-----------------------------------------------------"
echo "Started building TWRP-3.4.0-0 For M21                "
echo "-----------------------------------------------------" 
TWRP-Q-SOURCE
echo "----------------------------------------------------"
echo " builds successfully completed" 
echo "----------------------------------------------------" 
    
