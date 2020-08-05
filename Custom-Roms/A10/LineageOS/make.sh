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
securitypatch=2020-07-05


# credentials

Telegram_Api_code=$(cat $path/cred** | grep api | cut -d "=" -f 2)
chat_id=$(cat $path/cred** | grep id | cut -d "=" -f 2)
password=$(cat $path/cred** | grep sf | cut -d "=" -f 2)
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
    git clone https://$gitpassword@github.com/RaghuVarma331/Keys keys
    wget  https://github.com/RaghuVarma331/scripts/raw/master/pythonscripts/telegram.py
    wget https://github.com/RaghuVarma331/custom_roms_banners/raw/master/lineage.jpg
} &> /dev/null

L4()
{
    cd $path
    mkdir los
    cd los
    echo -ne '\n' | repo init -u git://github.com/LineageOS/android.git -b lineage-17.1 --depth=1
    repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
    sed -i "/ro.control_privapp_permissions=enforce/d" vendor/lineage/config/common.mk
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_external_motorola_faceunlock -b android-10.0 external/motorola/faceunlock
    cd $path/fpatch
    chmod a+x *
    ./setup.sh
}

L5()
{
    cd $path/los
    rm -r packages/apps/Updater
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
    
    New LineageOS 17.1 for Nokia 6.1 Plus build started 
    
    $(date)
    
    👤 By: Raghu Varma"
    cd $path/los
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_device_nokia_Dragon.git -b android-10.0 device/nokia/Dragon
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch lineage_Dragon-userdebug && make -j$(nproc --all) target-files-package otatools
    romname=$(cat $path/los/out/target/product/Dragon/system/build.prop | grep ro.lineage.version | cut -d "=" -f 2)
    ./build/tools/releasetools/sign_target_files_apks -o -d $path/keys $path/los/out/target/product/Dragon/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/los/out/target/product/Dragon/signed-target-files.zip
    ./build/tools/releasetools/ota_from_target_files -k $path/keys/releasekey $path/los/out/target/product/Dragon/signed-target-files.zip $path/los/out/target/product/Dragon/lineage-$romname.zip
    cd out/target/product/Dragon
    cp -r lineage-17.1**.zip $path/roms
    sshpass -p $password rsync -avP -e ssh lineage-17.1**.zip     raghuvarma331@frs.sourceforge.net:/home/frs/project/drg-sprout/LineageOS
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    Build successfully completed
    
    $(date) "
}

L7()
{
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New LineageOS 17.1 for Nokia 7 Plus build started 
    
    $(date)
    
    👤 By: Raghu Varma"
    cd $path/los
    rm -r device/nokia
    rm -r out/target/product/*
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_device_nokia_Onyx.git -b android-10.0 device/nokia/Onyx
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch lineage_Onyx-userdebug && make -j$(nproc --all) target-files-package otatools
    romname=$(cat $path/los/out/target/product/Onyx/system/build.prop | grep ro.lineage.version | cut -d "=" -f 2)
    ./build/tools/releasetools/sign_target_files_apks -o -d $path/keys $path/los/out/target/product/Onyx/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/los/out/target/product/Onyx/signed-target-files.zip
    ./build/tools/releasetools/ota_from_target_files -k $path/keys/releasekey $path/los/out/target/product/Onyx/signed-target-files.zip $path/los/out/target/product/Onyx/lineage-$romname.zip
    cd out/target/product/Onyx
    cp -r lineage-17.1**.zip $path/roms
    sshpass -p $password rsync -avP -e ssh lineage-17.1**.zip     raghuvarma331@frs.sourceforge.net:/home/frs/project/b2n-sprout/LineageOS
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    Build successfully completed
    
    $(date) "
}

L8()
{
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New LineageOS 17.1 for Nokia 7.1 build started 
    
    $(date)
    
    👤 By: Raghu Varma"
    cd $path/los
    rm -r device/nokia
    rm -r out/target/product/*
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_device_nokia_Crystal.git -b android-10.0 device/nokia/Crystal
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch lineage_Crystal-userdebug && make -j$(nproc --all) target-files-package otatools
    romname=$(cat $path/los/out/target/product/Crystal/system/build.prop | grep ro.lineage.version | cut -d "=" -f 2)
    ./build/tools/releasetools/sign_target_files_apks -o -d $path/keys $path/los/out/target/product/Crystal/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/los/out/target/product/Crystal/signed-target-files.zip
    ./build/tools/releasetools/ota_from_target_files -k $path/keys/releasekey $path/los/out/target/product/Crystal/signed-target-files.zip $path/los/out/target/product/Crystal/lineage-$romname.zip
    cd out/target/product/Crystal
    cp -r lineage-17.1**.zip $path/roms
    sshpass -p $password rsync -avP -e ssh lineage-17.1**.zip     raghuvarma331@frs.sourceforge.net:/home/frs/project/ctl-sprout/LineageOS
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    Build successfully completed
    
    $(date) "
}

L9()
{
    cd $path
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P lineage.jpg -C "
    *
    🔥 New LineageOS 17.1 Build is up
    ==========================
    $(date)*
    
    ⬇️ [Download Rom](https://forum.xda-developers.com/nokia-6-1-plus/development/beta-lineageos-17-0-t3985367)
    💬 [Device Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/nokia.txt)
    💬 [Installation procedure](https://github.com/RaghuVarma331/changelogs/raw/master/crossdevelopment/abcrins.txt)
    📱Device: *Nokia 6.1 Plus*
    ⚡Build Version: *17.1* 
    ⚡Android Version: *10.0.0*
    ⚡Security Patch : *$securitypatch*
    👤 By: *@RaghuVarma*
    #drg #nokia #los #update
    Follow:  @Nokia6plusofficial ✅"  

    python telegram.py -t $Telegram_Api_code -c $chat_id  -P lineage.jpg -C "
    *
    🔥 New LineageOS 17.1 Build is up
    ==========================    
    $(date)*
    
    ⬇️ [Download ROM](https://forum.xda-developers.com/nokia-7-plus/development/rom-lineageos-17-0-t3993445)
    💬 [Device Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/nokia.txt)
    💬 [Installation procedure](https://github.com/RaghuVarma331/changelogs/raw/master/crossdevelopment/abcrins.txt)
    📱Device: *Nokia 7 Plus*
    ⚡Build Version: *17.1*
    ⚡Android Version: *10.0.0*
    ⚡Security Patch : *$securitypatch*
    👤 By: *@RaghuVarma*
    #b2n #nokia #los #update
    Follow: @Nokia7plusOfficial ✅"  

    python telegram.py -t $Telegram_Api_code -c $chat_id  -P lineage.jpg -C "
    *
    🔥 New LineageOS 17.1 Build is up
    ==========================    
    $(date)*
    
    ⬇️ [Download ROM](https://forum.xda-developers.com/nokia-7-1/development/rom-lineageos-17-0-t4019915)
    💬 [Device Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/nokia.txt)
    💬 [Installation procedure](https://github.com/RaghuVarma331/changelogs/raw/master/crossdevelopment/abcrins.txt)
    📱Device: *Nokia 7.1*
    ⚡Build Version: *17.1*
    ⚡Android Version: *10.0.0*
    ⚡Security Patch : *$securitypatch*
    👤 By: *@RaghuVarma*
    #ctl #nokia #los #update
    Follow: @nokia7161 ✅"  

    rm -r bin los keys  lineage.jpg  telegram.py

} &> /dev/null


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
echo "Started building LineageOS for Nokia 6.1 Plus"
echo "----------------------------------------------------" 
L6
echo "----------------------------------------------------"
echo "Started building LineageOS for Nokia 7 Plus"
echo "----------------------------------------------------" 
L7
echo "----------------------------------------------------"
echo "Started building LineageOS for Nokia 7.1"
echo "----------------------------------------------------"
L8
echo "----------------------------------------------------"
echo "Started Posting in Channel"
echo "----------------------------------------------------"
L9
