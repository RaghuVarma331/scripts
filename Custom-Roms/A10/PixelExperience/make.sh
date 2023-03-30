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

# credentials

Telegram_Api_code=$(cat $path/cred** | grep api | cut -d "=" -f 2)
chat_id=$(cat $path/cred** | grep id | cut -d "=" -f 2)
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
} &> /dev/null

L4()
{
    cd $path
    mkdir pe
    cd pe
    echo -ne '\n' | repo init -u https://github.com/PixelExperience/manifest -b ten --git-lfs --depth=1
    repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
    sed -i "/ro.control_privapp_permissions=enforce/d" vendor/aosp/config/common.mk
    rm -r packages/apps/Updates
    rm -r external/motorola/faceunlock
    git clone https://github.com/Nokia-SDM660/Os_Updates.git -b android-10.0 packages/apps/Os_Updates
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_external_motorola_faceunlock -b android-10.0 external/motorola/faceunlock
}

L5()
{
    cd $path/pe
    rm -r packages/apps/Updates
    git clone https://$gitpassword@github.com/Nokia-SDM660/proprietary_vendor_nokia.git -b android-10.0 vendor/nokia
    git clone https://$gitpassword@github.com/Nokia-SDM660/proprietary_vendor_nokia_camera.git -b android-10.0 vendor/nokia/camera
    git clone https://$gitpassword@github.com/Nokia-SDM660/proprietary_vendor_nokia_GoogleCamera -b android-10.0 vendor/nokia/GoogleCamera
    git clone https://github.com/Nokia-SDM660/android_kernel_nokia_sdm660.git -b android-10.0-clang --depth=1 kernel/nokia/sdm660
    git clone https://github.com/Nokia-SDM660/android_external_bson.git -b lineage-17.1 external/bson
    git clone https://github.com/Nokia-SDM660/android_system_qcom.git -b lineage-17.1 system/qcom
    cd packages/apps/Settings/src/com/android/settings/system
    rm -r SystemUpdatePreferenceController.java
    wget https://github.com/RaghuVarma331/settings/raw/ten/src/com/android/settings/system/SystemUpdatePreferenceController.java
} &> /dev/null

L6()
{
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Pixel-Experience for Nokia 6.1 Plus build started 
    
    $(date)
    
    👤 By: Raghu Varma"   
    cd $path/pe
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_device_nokia_Dragon.git -b android-10.0 device/nokia/Dragon
    cd packages/apps/Os_Updates/src/org/pixelexperience/ota/misc
    rm -r Constants.java
    wget https://github.com/Nokia-SDM660/OTA-configs/raw/android-10.0/Dragon/PixelExperience/Constants.java
    cd $path/pe
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch aosp_Dragon-userdebug && make -j$(nproc --all) target-files-package otatools
    romname=$(cat $path/pe/out/target/product/Dragon/system/build.prop | grep org.pixelexperience.version.display | cut -d "=" -f 2)
    ./build/tools/releasetools/sign_target_files_apks -o -d $path/keys $path/pe/out/target/product/Dragon/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/pe/out/target/product/Dragon/signed-target-files.zip
    ./build/tools/releasetools/ota_from_target_files -k $path/keys/releasekey $path/pe/out/target/product/Dragon/signed-target-files.zip $path/pe/out/target/product/Dragon/$romname.zip
    cd out/target/product/Dragon  
    cp -r PixelExperience**.zip $path/roms
    wget https://github.com/RaghuVarma331/scripts/raw/master/Json_generator/drg_pe.sh
    chmod a+x drg_pe.sh
    ./drg_pe.sh
    cat **.json > $path/OTA-server/PixelExperience/Dragon.json
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    Build successfully completed
    
    $(date) "
}

L7()
{
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Pixel-Experience for Nokia 7 Plus build started 
    
    $(date)
    
    👤 By: Raghu Varma"
    cd $path/pe
    rm -r device/nokia
    rm -r out/target/product/*
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_device_nokia_Onyx.git -b android-10.0 device/nokia/Onyx
    cd packages/apps/Os_Updates/src/org/pixelexperience/ota/misc
    rm -r Constants.java
    wget https://github.com/Nokia-SDM660/OTA-configs/raw/android-10.0/Onyx/PixelExperience/Constants.java
    cd $path/pe
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch aosp_Onyx-userdebug && make -j$(nproc --all) target-files-package otatools
    romname=$(cat $path/pe/out/target/product/Onyx/system/build.prop | grep org.pixelexperience.version.display | cut -d "=" -f 2)
    ./build/tools/releasetools/sign_target_files_apks -o -d $path/keys $path/pe/out/target/product/Onyx/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/pe/out/target/product/Onyx/signed-target-files.zip
    ./build/tools/releasetools/ota_from_target_files -k $path/keys/releasekey $path/pe/out/target/product/Onyx/signed-target-files.zip $path/pe/out/target/product/Onyx/$romname.zip
    cd out/target/product/Onyx  
    cp -r PixelExperience**.zip $path/roms
    wget https://github.com/RaghuVarma331/scripts/raw/master/Json_generator/b2n_pe.sh
    chmod a+x b2n_pe.sh
    ./b2n_pe.sh
    cat **.json > $path/OTA-server/PixelExperience/Onyx.json
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    Build successfully completed
    
    $(date) "
}

L8()
{
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Pixel-Experience for Nokia 6.1 build started 
    
    $(date)
    
    👤 By: Raghu Varma"
    cd $path/pe
    rm -r device/nokia
    rm -r out/target/product/*
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_device_nokia_Plate2.git -b android-10.0 device/nokia/Plate2
    cd packages/apps/Os_Updates/src/org/pixelexperience/ota/misc
    rm -r Constants.java
    wget https://github.com/Nokia-SDM660/OTA-configs/raw/android-10.0/Plate2/PixelExperience/Constants.java
    cd $path/pe
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch aosp_Plate2-userdebug && make -j$(nproc --all) target-files-package otatools
    romname=$(cat $path/pe/out/target/product/Plate2/system/build.prop | grep org.pixelexperience.version.display | cut -d "=" -f 2)
    ./build/tools/releasetools/sign_target_files_apks -o -d $path/keys $path/pe/out/target/product/Plate2/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/pe/out/target/product/Plate2/signed-target-files.zip
    ./build/tools/releasetools/ota_from_target_files -k $path/keys/releasekey $path/pe/out/target/product/Plate2/signed-target-files.zip $path/pe/out/target/product/Plate2/$romname.zip
    cd out/target/product/Plate2  
    cp -r PixelExperience**.zip $path/roms
    wget https://github.com/RaghuVarma331/scripts/raw/master/Json_generator/pl2_pe.sh
    chmod a+x pl2_pe.sh
    ./pl2_pe.sh
    cat **.json > $path/OTA-server/PixelExperience/Plate2.json
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    Build successfully completed
    
    $(date) "
}

L9()
{
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Pixel-Experience for Nokia 7.1 build started 
    
    $(date)
    
    👤 By: Raghu Varma"
    cd $path/pe
    rm -r device/nokia
    rm -r out/target/product/*
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_device_nokia_Crystal.git -b android-10.0 device/nokia/Crystal
    cd packages/apps/Os_Updates/src/org/pixelexperience/ota/misc
    rm -r Constants.java
    wget https://github.com/Nokia-SDM660/OTA-configs/raw/android-10.0/Crystal/PixelExperience/Constants.java
    cd $path/pe
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch aosp_Crystal-userdebug && make -j$(nproc --all) target-files-package otatools
    romname=$(cat $path/pe/out/target/product/Crystal/system/build.prop | grep org.pixelexperience.version.display | cut -d "=" -f 2)
    ./build/tools/releasetools/sign_target_files_apks -o -d $path/keys $path/pe/out/target/product/Crystal/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/pe/out/target/product/Crystal/signed-target-files.zip
    ./build/tools/releasetools/ota_from_target_files -k $path/keys/releasekey $path/pe/out/target/product/Crystal/signed-target-files.zip $path/pe/out/target/product/Crystal/$romname.zip
    cd out/target/product/Crystal  
    cp -r PixelExperience**.zip $path/roms
    wget https://github.com/RaghuVarma331/scripts/raw/master/Json_generator/ctl_pe.sh
    chmod a+x ctl_pe.sh
    ./ctl_pe.sh
    cat **.json > $path/OTA-server/PixelExperience/Crystal.json
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    Build successfully completed
    
    $(date) "
}


L10()
{
    cd $path
    rm -r bin pe keys
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
echo "Started building PixelExperience for Nokia 6.1 Plus"
echo "----------------------------------------------------" 
L6
echo "----------------------------------------------------"
echo "Started building PixelExperience for Nokia 7 Plus"
echo "----------------------------------------------------" 
L7
echo "----------------------------------------------------"
echo "Started building PixelExperience for Nokia 6.1"
echo "----------------------------------------------------" 
L8
echo "----------------------------------------------------"
echo "Started building PixelExperience for Nokia 7.1"
echo "----------------------------------------------------" 
L9
echo "----------------------------------------------------"
echo "Started cleaning"
echo "----------------------------------------------------" 
L10
