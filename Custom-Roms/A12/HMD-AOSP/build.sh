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

path=/var/lib/jenkins/workspace/HMD-AOSP

# credentials

Telegram_Api_code=$(cat $path/cred** | grep api | cut -d "=" -f 2)
chat_id=$(cat $path/cred** | grep id | cut -d "=" -f 2)
gitpassword=$(cat $path/cred** | grep git | cut -d "=" -f 2)
gitlpassword=$(cat $path/cred** | grep lab | cut -d "=" -f 2)

# D_T_Y
CUSTOM_DATE_YEAR="$(date -u +%Y)"
CUSTOM_DATE_MONTH="$(date -u +%m)"
CUSTOM_DATE_DAY="$(date -u +%d)"
CUSTOM_DATE_HOUR="$(date -u +%H)"
CUSTOM_DATE_MINUTE="$(date -u +%M)"
CUSTOM_BUILD_DATE="$CUSTOM_DATE_YEAR""$CUSTOM_DATE_MONTH""$CUSTOM_DATE_DAY"-"$CUSTOM_DATE_HOUR""$CUSTOM_DATE_MINUTE"

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
    git clone https://$gitpassword@github.com/HMD-AOSP/Private_keys -b android-12.0 keys
    mkdir aosp
    cd aosp
    echo -ne '\n' | repo init -u https://$gitpassword@github.com/HMD-AOSP/android_manifest.git -b android-12.0-V --depth=1
    repo sync
    rm -r .repo
    git clone https://$gitlpassword@gitlab.com/GovernorOS/android_vendor_gms -b android-12.0 --depth=1 vendor/gms
}

L4()
{
    cd $path/aosp
    git clone https://$gitpassword@github.com/HMD-AOSP/android_device_nokia_Dragon.git -b android-12.0 device/nokia/Dragon
    git clone https://$gitpassword@github.com/HMD-AOSP/android_device_nokia_Onyx.git -b android-12.0 device/nokia/Onyx
    git clone https://$gitpassword@github.com/HMD-AOSP/android_device_nokia_Crystal.git -b android-12.0 device/nokia/Crystal
    git clone https://$gitpassword@github.com/HMD-AOSP/android_device_nokia_Plate2.git -b android-12.0 device/nokia/Plate2
    git clone https://$gitpassword@github.com/HMD-AOSP/kernel-headers -b android-12.0 kernel/nokia/kernel-headers
    git clone https://$gitpassword@github.com/HMD-AOSP/proprietary_vendor_nokia -b android-12.0 --depth=1 vendor/nokia
    git clone https://$gitpassword@github.com/HMD-AOSP/proprietary_vendor_nokia_GoogleCamera -b android-12.0 vendor/nokia/GoogleCamera
} &> /dev/null

L5()
{
    cd $path/aosp
    git clone https://$gitpassword@github.com/HMD-AOSP/proprietary_vendor_nokia_Os_Updates -b Dragon-HMD-AOSP vendor/nokia/Os_Updates &> /dev/null
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New HMD-AOSP for Nokia 6.1 Plus build started 
    
    $(date)
    "
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch aosp_Dragon-userdebug && make -j$(nproc --all) target-files-package otatools
    sign_target_files_apks -o -d $path/keys $path/aosp/out/target/product/Dragon/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/aosp/out/target/product/Dragon/signed-target-files.zip
    ota_from_target_files -k $path/keys/releasekey $path/aosp/out/target/product/Dragon/signed-target-files.zip $path/aosp/out/target/product/Dragon/HMD-AOSP_Dragon-12.0-$CUSTOM_BUILD_DATE.zip
    cp -r out/target/product/*/HMD-AOSP**.zip $path
    rm -r out/target/product/*
    rm -r vendor/nokia/Os_Updates
    git clone https://$gitpassword@github.com/HMD-AOSP/proprietary_vendor_nokia_Os_Updates -b Onyx-HMD-AOSP vendor/nokia/Os_Updates &> /dev/null
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New HMD-AOSP for Nokia 7 Plus build started 
    
    $(date)
    "
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch aosp_Onyx-userdebug && make -j$(nproc --all) target-files-package otatools
    sign_target_files_apks -o -d $path/keys $path/aosp/out/target/product/Onyx/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/aosp/out/target/product/Onyx/signed-target-files.zip
    ota_from_target_files -k $path/keys/releasekey $path/aosp/out/target/product/Onyx/signed-target-files.zip $path/aosp/out/target/product/Onyx/HMD-AOSP_Onyx-12.0-$CUSTOM_BUILD_DATE.zip
    cp -r out/target/product/*/HMD-AOSP**.zip $path
    rm -r out/target/product/*
    rm -r vendor/nokia/Os_Updates
    git clone https://$gitpassword@github.com/HMD-AOSP/proprietary_vendor_nokia_Os_Updates -b Crystal-HMD-AOSP vendor/nokia/Os_Updates &> /dev/null
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New HMD-AOSP for Nokia 7.1 build started 
    
    $(date)
    "
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch aosp_Crystal-userdebug && make -j$(nproc --all) target-files-package otatools
    sign_target_files_apks -o -d $path/keys $path/aosp/out/target/product/Crystal/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/aosp/out/target/product/Crystal/signed-target-files.zip
    ota_from_target_files -k $path/keys/releasekey $path/aosp/out/target/product/Crystal/signed-target-files.zip $path/aosp/out/target/product/Crystal/HMD-AOSP_Crystal-12.0-$CUSTOM_BUILD_DATE.zip
    cp -r out/target/product/*/HMD-AOSP**.zip $path
    rm -r out/target/product/*
    rm -r vendor/nokia/Os_Updates
    git clone https://$gitpassword@github.com/HMD-AOSP/proprietary_vendor_nokia_Os_Updates -b Plate2-HMD-AOSP vendor/nokia/Os_Updates &> /dev/null
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New HMD-AOSP for Nokia 6.1 build started 
    
    $(date)
    "
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch aosp_Plate2-userdebug && make -j$(nproc --all) target-files-package otatools
    sign_target_files_apks -o -d $path/keys $path/aosp/out/target/product/Plate2/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/aosp/out/target/product/Plate2/signed-target-files.zip
    ota_from_target_files -k $path/keys/releasekey $path/aosp/out/target/product/Plate2/signed-target-files.zip $path/aosp/out/target/product/Plate2/HMD-AOSP_Plate2-12.0-$CUSTOM_BUILD_DATE.zip
    cp -r out/target/product/*/HMD-AOSP**.zip $path
    rm -r out/target/product/*
    rm -r vendor/nokia/Os_Updates
}

L6()
{
    cd $path/aosp
    rm -r device/nokia
    rm -r vendor/nokia
    rm -r device/lineage/sepolicy
    rm -r device/qcom/sepolicy-legacy-um
    git clone https://$gitpassword@github.com/HMD-AOSP/android_device_nokia_Daredevil.git -b android-12.0-PV device/nokia/Daredevil
    git clone https://$gitpassword@github.com/HMD-AOSP/android_device_nokia_Starlord.git -b android-12.0-PV device/nokia/Starlord
    git clone https://$gitlpassword@gitlab.com/RaghuVarma331/proprietary_vendor_nokia.git -b android-12.0-PV --depth=1 vendor/nokia
    git clone https://$gitpassword@github.com/HMD-AOSP/proprietary_vendor_nokia_GoogleCamera -b android-12.0 vendor/nokia/GoogleCamera
    git clone https://$gitpassword@github.com/HMD-AOSP/android_device_lineage_sepolicy -b android-12.0-PV device/lineage/sepolicy
    git clone https://$gitpassword@github.com/HMD-AOSP/android_device_qcom_sepolicy-legacy-um -b android-12.0-PV device/qcom/sepolicy-legacy-um
}

L7()
{
    cd $path/aosp
    git clone https://$gitpassword@github.com/HMD-AOSP/proprietary_vendor_nokia_Os_Updates -b Daredevil-HMD-AOSP vendor/nokia/Os_Updates &> /dev/null
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New HMD-AOSP for Nokia 7.2 build started 
    
    $(date)
    "
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch aosp_Daredevil-userdebug && make -j$(nproc --all) target-files-package otatools
    sign_target_files_apks -o -d $path/keys $path/aosp/out/target/product/Daredevil/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/aosp/out/target/product/Daredevil/signed-target-files.zip
    ota_from_target_files -k $path/keys/releasekey $path/aosp/out/target/product/Daredevil/signed-target-files.zip $path/aosp/out/target/product/Daredevil/HMD-AOSP_Daredevil-12.0-$CUSTOM_BUILD_DATE.zip
    cp -r out/target/product/*/HMD-AOSP**.zip $path
    rm -r out/target/product/*
    rm -r vendor/nokia/Os_Updates
    git clone https://$gitpassword@github.com/HMD-AOSP/proprietary_vendor_nokia_Os_Updates -b Starlord-HMD-AOSP vendor/nokia/Os_Updates &> /dev/null
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New HMD-AOSP for Nokia 6.2 build started 
    
    $(date)
    "
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch aosp_Starlord-userdebug && make -j$(nproc --all) target-files-package otatools
    sign_target_files_apks -o -d $path/keys $path/aosp/out/target/product/Starlord/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/aosp/out/target/product/Starlord/signed-target-files.zip
    ota_from_target_files -k $path/keys/releasekey $path/aosp/out/target/product/Starlord/signed-target-files.zip $path/aosp/out/target/product/Starlord/HMD-AOSP_Starlord-12.0-$CUSTOM_BUILD_DATE.zip
    cp -r out/target/product/*/HMD-AOSP**.zip $path
    rm -r out/target/product/*
    rm -r vendor/nokia/Os_Updates
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
echo "Downloading HMD-AOSP Source Code.."
echo "----------------------------------------------------" 
L3
echo "----------------------------------------------------"
echo "Downloading DRG B2N CTL PL2 Device sources.."
echo "----------------------------------------------------" 
L4
echo "----------------------------------------------------"
echo "Started building HMD-AOSP for DRG B2N CTL PL2.."
echo "----------------------------------------------------" 
L5
echo "----------------------------------------------------"
echo "Downloading DDV SLD Device sources.."
echo "----------------------------------------------------" 
L6
echo "----------------------------------------------------"
echo "Started building HMD-AOSP for DDV SLD.."
echo "----------------------------------------------------" 
L7
echo "----------------------------------------------------"
echo "Successfully build completed.."
echo "----------------------------------------------------" 



