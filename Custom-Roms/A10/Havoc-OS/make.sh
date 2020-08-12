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
securitypatch=2020-08-05


# credentials

Telegram_Api_code=$(cat $path/cred** | grep api | cut -d "=" -f 2)
chat_id=$(cat $path/cred** | grep id | cut -d "=" -f 2)
hpassword=$(cat $path/cred** | grep hsf | cut -d "=" -f 2)
gitpassword=$(cat $path/cred** | grep git | cut -d "=" -f 2)


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
    mkdir bin
    PATH=$path/bin:$PATH
    curl https://storage.googleapis.com/git-repo-downloads/repo > $path/bin/repo
    chmod a+x $path/bin/repo
} &> /dev/null

L3()
{
    cd $path
    wget  https://github.com/RaghuVarma331/scripts/raw/master/pythonscripts/telegram.py
} &> /dev/null

L4()
{
    cd $path
    mkdir havoc
    cd havoc
    echo -ne '\n' | repo init -u https://github.com/Havoc-OS/android_manifest.git -b ten --depth=1
    repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
    git clone https://$gitpassword@github.com/Havoc-OS/android_external_motorola_faceunlock -b ten external/motorola/faceunlock
    cd $path/fpatch
    chmod a+x *
    ./Havoc-OS.sh
}

L5()
{
    cd $path/havoc
    git clone https://$gitpassword@github.com/Nokia-SDM660/proprietary_vendor_nokia.git -b android-10.0 vendor/nokia
    git clone https://$gitpassword@github.com/Nokia-SDM660/proprietary_vendor_nokia_camera.git -b android-10.0 vendor/nokia/camera
    git clone https://$gitpassword@github.com/Nokia-SDM660/proprietary_vendor_nokia_GoogleCamera -b android-10.0 vendor/nokia/GoogleCamera
    git clone https://github.com/Nokia-SDM660/android_kernel_nokia_sdm660.git -b ten --depth=1 kernel/nokia/sdm660
    git clone https://github.com/Nokia-SDM660/android_external_bson.git -b lineage-17.1 external/bson
    git clone https://github.com/Nokia-SDM660/android_system_qcom.git -b lineage-17.1 system/qcom
} &> /dev/null

L6()
{
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Havoc OS for Nokia 6.1 Plus build started 
    
    $(date)
    
    👤 By: Raghu Varma"   
    cd $path/havoc
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_device_nokia_Dragon.git -b android-10.0 device/nokia/Dragon
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch havoc_Dragon-userdebug && make -j$(nproc --all) bacon
    cd out/target/product/Dragon
    cp -r Havoc-OS**.zip $path/roms
    cd $path/havoc
    rm -r out/target/product/*
    export IS_PHONE=true
    export WITH_GAPPS=true
    export TARGET_GAPPS_ARCH=arm64
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch havoc_Dragon-userdebug && make -j$(nproc --all) bacon
    cd out/target/product/Dragon
    cp -r Havoc-OS**.zip $path/roms
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    Build successfully completed
    
    $(date) "
}

L7()
{
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Havoc OS for Nokia 7 Plus build started 
    
    $(date)
    
    👤 By: Raghu Varma"
    cd $path/havoc
    rm -r device/nokia
    rm -r out/target/product/*
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_device_nokia_Onyx.git -b android-10.0 device/nokia/Onyx
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch havoc_Onyx-userdebug && make -j$(nproc --all) bacon
    cd out/target/product/Onyx
    cp -r Havoc-OS**.zip $path/roms
    cd $path/havoc
    rm -r out/target/product/*
    export IS_PHONE=true
    export WITH_GAPPS=true
    export TARGET_GAPPS_ARCH=arm64
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch havoc_Onyx-userdebug && make -j$(nproc --all) bacon
    cd out/target/product/Onyx
    cp -r Havoc-OS**.zip $path/roms
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    Build successfully completed
    
    $(date) "
}

L8()
{
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Havoc OS for Nokia 6.1 build started 
    
    $(date)
    
    👤 By: Raghu Varma"
    cd $path/havoc
    rm -r device/nokia
    rm -r out/target/product/*
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_device_nokia_Plate2.git -b android-10.0 device/nokia/Plate2
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch havoc_Plate2-userdebug && make -j$(nproc --all) bacon
    cd out/target/product/Plate2
    cp -r Havoc-OS**.zip $path/roms
    cd $path/havoc
    rm -r out/target/product/*
    export IS_PHONE=true
    export WITH_GAPPS=true
    export TARGET_GAPPS_ARCH=arm64
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch havoc_Plate2-userdebug && make -j$(nproc --all) bacon
    cd out/target/product/Plate2
    cp -r Havoc-OS**.zip $path/roms
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    Build successfully completed
    
    $(date) "
}

L9()
{
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Havoc OS for Nokia 7.1 build started 
    
    $(date)
    
    👤 By: Raghu Varma"
    cd $path/havoc
    rm -r device/nokia
    rm -r out/target/product/*
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_device_nokia_Crystal.git -b android-10.0 device/nokia/Crystal
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch havoc_Crystal-userdebug && make -j$(nproc --all) bacon
    cd out/target/product/Crystal
    cp -r Havoc-OS**.zip $path/roms
    cd $path/havoc
    rm -r out/target/product/*
    export IS_PHONE=true
    export WITH_GAPPS=true
    export TARGET_GAPPS_ARCH=arm64
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch havoc_Crystal-userdebug && make -j$(nproc --all) bacon
    cd out/target/product/Crystal
    cp -r Havoc-OS**.zip $path/roms
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    Build successfully completed
    
    $(date) "
    cd $path
    rm -r bin havoc telegram.py
}




echo "----------------------------------------------------"
echo "Started Stup"
echo "----------------------------------------------------" 
L1
echo "----------------------------------------------------"
echo "Started Downloading Repo"
echo "----------------------------------------------------" 
L2
echo "----------------------------------------------------"
echo "Started cloning keys & changelog"
echo "----------------------------------------------------" 
L3
echo "----------------------------------------------------"
echo "Started cloning Rom Source"
echo "----------------------------------------------------" 
L4
echo "----------------------------------------------------"
echo "Started cloning Nokia source"
echo "----------------------------------------------------" 
L5
echo "----------------------------------------------------"
echo "Started building Havoc OS for Nokia 6.1 Plus"
echo "----------------------------------------------------" 
L6
echo "----------------------------------------------------"
echo "Started building Havoc OS for Nokia 7 Plus"
echo "----------------------------------------------------" 
L7
echo "----------------------------------------------------"
echo "Started building Havoc OS for Nokia 6.1"
echo "----------------------------------------------------" 
L8
echo "----------------------------------------------------"
echo "Started building Havoc OS for Nokia 7.1"
echo "----------------------------------------------------" 
L9


