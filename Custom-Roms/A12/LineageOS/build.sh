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

# Detail Versions

path=/var/lib/jenkins/workspace/LineageOS

# credentials

Telegram_Api_code=$(cat $path/cred** | grep api | cut -d "=" -f 2)
chat_id=$(cat $path/cred** | grep id | cut -d "=" -f 2)
gitpassword=$(cat $path/cred** | grep git | cut -d "=" -f 2)
gitlpassword=$(cat $path/cred** | grep lab | cut -d "=" -f 2)
SF=$(cat $path/cred** | grep sf | cut -d "=" -f 2)

L1()
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

L2()
{
    cd $path
    mkdir bin
    PATH=$path/bin:$PATH
    curl https://storage.googleapis.com/git-repo-downloads/repo > $path/bin/repo
    chmod a+x $path/bin/repo
}


L3()
{
    cd $path
    git clone https://$gitpassword@github.com/HMD-AOSP/Private_keys -b android-12.1.0 keys
    mkdir los
    cd los
    echo -ne '\n' | repo init -u https://github.com/LineageOS/android.git -b lineage-19.1 --depth=1
    repo sync
    sed -i "/ro.control_privapp_permissions=enforce/d" vendor/lineage/config/common.mk
    rm -r packages/apps/Settings
    rm -r packages/apps/Updater
    git clone https://github.com/Motorola-SM6150/Os_Updates.git -b lineage-19.1 packages/apps/Os_Updates
    git clone https://$gitpassword@github.com/RaghuVarma331/android_packages_apps_Settings.git -b lineage-19.1 packages/apps/Settings --depth=1
    cd $path
    wget https://github.com/RaghuVarma331/scripts/raw/master/Patches/pe12_sign_target_files_apks.py &> /dev/null
    cat pe12_sign_target_files_apks.py > $path/los/build/tools/releasetools/sign_target_files_apks.py
    cat pe12_sign_target_files_apks.py > $path/los/build/tools/releasetools/sign_target_files_apks
    rm -r pe12_sign_target_files_apks.py
}

G60G40-A()
{
    cd $path/los
    git clone https://$gitpassword@github.com/RaghuVarma331/android_device_motorola_hanoip -b android-12.1-PV device/motorola/hanoip
    git clone https://$gitpassword@github.com/RaghuVarma331/android_kernel_motorola_sm6150 -b android-12.1 kernel/motorola/sm6150 --depth=1
    git clone https://$gitpassword@github.com/RaghuVarma331/kernel-headers -b android-12.1 kernel/motorola/kernel-headers
    git clone https://$gitlpassword@gitlab.com/RaghuVarma331/proprietary_vendor_motorola -b android-12.1-PV vendor/motorola --depth=1
}

G60G40-B()
{
    cd $path/los
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch lineage_hanoip-userdebug && make -j$(nproc --all) target-files-package otatools
    romname=$(cat $path/los/out/target/product/hanoip/system/build.prop | grep ro.lineage.version | cut -d "=" -f 2)
    sign_target_files_apks -o -d $path/keys $path/los/out/target/product/hanoip/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/los/out/target/product/hanoip/signed-target-files.zip
    ota_from_target_files -k $path/keys/releasekey $path/los/out/target/product/hanoip/signed-target-files.zip $path/los/out/target/product/hanoip/lineage-$romname.zip
    cp -r out/target/product/*/lineage-19.1**.zip $path
    rm -r out/target/product/*
    rm -r device/moto*
    rm -r vendor/moto*
    rm -r kernel/moto*
}

OTA-UPLOAD()
{
    cd $path
    mkdir -p ~/.ssh  &&  echo "Host *" > ~/.ssh/config && echo " StrictHostKeyChecking no" >> ~/.ssh/config
    echo "# Allow Jenkins" >> /etc/sudoers && echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
    sshpass -p $SF rsync -avP -e ssh lineage-19.1**hanoip**.zip  raghuvarma331@frs.sourceforge.net:/home/frs/project/motorola-sm6150/G60/LineageOS
    git clone https://$gitpassword@github.com/Motorola-SM6150/OTA-server -b master OTA-server
    wget https://github.com/RaghuVarma331/scripts/raw/master/Json_generator/hanoip_los.sh &> /dev/null
    chmod a+x hanoip_los.sh
    ./hanoip_los.sh &> /dev/null
    cat ***.json > $path/OTA-server/LineageOS/hanoip.json
    cd $path/OTA-server
    git add . && git commit -s -m "OTA-server: LineageOS: build $(date)" && git push  -u -f origin master
}


echo "----------------------------------------------------"
echo "Downloading tools.."
echo "----------------------------------------------------" 
L1
echo "----------------------------------------------------"
echo "Downloading repo bin.."
echo "----------------------------------------------------" 
L2
echo "----------------------------------------------------"
echo "Downloading Lineage OS Source Code.."
echo "----------------------------------------------------" 
L3
echo "----------------------------------------------------"
echo "Downloading G60/G40 sources.."
echo "----------------------------------------------------" 
G60G40-A
echo "----------------------------------------------------"
echo "Started building for G60/G40.."
echo "----------------------------------------------------" 
G60G40-B
echo "----------------------------------------------------"
echo "Successfully build completed.."
echo "----------------------------------------------------" 
echo "----------------------------------------------------"
echo "Started uploading build and updating OTA for G60/G40"
echo "----------------------------------------------------" 
OTA-UPLOAD
echo "----------------------------------------------------"
echo "Successfully completed.."
echo "----------------------------------------------------" 
