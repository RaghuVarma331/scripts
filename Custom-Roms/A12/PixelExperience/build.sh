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

path=/var/lib/jenkins/workspace/PixelExperience

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
    mkdir pe
    cd pe
    echo -ne '\n' | repo init -u https://github.com/PixelExperience/manifest -b twelve --depth=1
    repo sync
    sed -i "/ro.control_privapp_permissions=enforce/d" vendor/aosp/config/common.mk
    rm -r packages/apps/Updates
    git clone https://github.com/Motorola-SM6150/Os_Updates.git -b pe-12.1 packages/apps/Os_Updates
    cd packages/apps/Settings/src/com/android/settings/system
    rm -r SystemUpdatePreferenceController.java
    wget https://github.com/LineageOS/android_packages_apps_Settings/raw/lineage-19.1/src/com/android/settings/system/SystemUpdatePreferenceController.java &> /dev/null
    cd $path
    wget https://github.com/RaghuVarma331/scripts/raw/master/Patches/pe12_sign_target_files_apks.py &> /dev/null
    cat pe12_sign_target_files_apks.py > $path/pe/build/tools/releasetools/sign_target_files_apks.py
    cat pe12_sign_target_files_apks.py > $path/pe/build/tools/releasetools/sign_target_files_apks
    rm -r pe12_sign_target_files_apks.py
    cd $path/pe
    cd vendor/gapps/product/packages/apps
    rm -r Drive GoogleCamera Maps YouTube YouTubeMusicPrebuilt PrebuiltGmail Photos
    cd ..
    cd privileged_apps
    rm -r PixelLiveWallpaperPrebuilt RecorderPrebuilt    
}

G60G40-A()
{
    cd $path/pe
    git clone https://$gitpassword@github.com/RaghuVarma331/android_device_motorola_hanoip -b android-12.1-PV device/motorola/hanoip
    git clone https://$gitpassword@github.com/RaghuVarma331/android_kernel_motorola_sm6150 -b android-12.1 kernel/motorola/sm6150 --depth=1
    git clone https://$gitpassword@github.com/RaghuVarma331/kernel-headers -b android-12.1 kernel/motorola/kernel-headers
    git clone https://$gitlpassword@gitlab.com/RaghuVarma331/proprietary_vendor_motorola -b android-12.1-PV vendor/motorola --depth=1
}

G60G40-B()
{
    cd $path/pe
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch aosp_hanoip-userdebug && make -j$(nproc --all) target-files-package otatools
    romname=$(cat $path/pe/out/target/product/hanoip/system/build.prop | grep org.pixelexperience.version.display | cut -d "=" -f 2)
    sign_target_files_apks -o -d $path/keys $path/pe/out/target/product/hanoip/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/pe/out/target/product/hanoip/signed-target-files.zip
    ota_from_target_files -k $path/keys/releasekey $path/pe/out/target/product/hanoip/signed-target-files.zip $path/pe/out/target/product/hanoip/$romname.zip
    cp -r out/target/product/*/PixelExperience**.zip $path
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
    sshpass -p $SF rsync -avP -e ssh PixelExperience**hanoip**.zip  raghuvarma331@frs.sourceforge.net:/home/frs/project/motorola-sm6150/G60/PixelExperience
    git clone https://$gitpassword@github.com/Motorola-SM6150/OTA-server -b master OTA-server
    wget https://github.com/RaghuVarma331/scripts/raw/master/Json_generator/hanoip_pe.sh &> /dev/null
    chmod a+x hanoip_pe.sh
    ./hanoip_pe.sh &> /dev/null
    cat ***.json > $path/OTA-server/PixelExperience/hanoip.json
    cd $path/OTA-server
    git add . && git commit -s -m "OTA-server: PixelExperience: build $(date)" && git push  -u -f origin master
}

L3A()
{
    cd $path/pe
    rm -r external/bson
    rm -r system/qcom
    rm -r system/bpf
    rm -r system/netd
    rm -r system/bt
    rm -r frameworks/av
    rm -r hardware/qcom-caf/wlan
    git clone https://github.com/LineageOS/android_external_bson.git -b lineage-18.1 external/bson
    git clone https://github.com/LineageOS/android_system_qcom.git -b lineage-18.1 system/qcom
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_system_bpf -b android-12.1.0 system/bpf
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_system_netd -b android-12.1.0 system/netd
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_system_bt -b android-12.1.0-PE system/bt
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_frameworks_av -b android-12.1.0 frameworks/av
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_hardware_qcom_wlan -b android-12.1.0 hardware/qcom-caf/wlan
} &> /dev/null

L4()
{
    cd $path/pe
    rm -r packages/apps/Os_Updates
    git clone https://github.com/Nokia-SDM660/android_kernel_nokia_sdm660.git -b android-12.1.0-clang --depth=1 kernel/nokia/sdm660
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_device_nokia_Dragon -b android-12.1.0 device/nokia/Dragon
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_device_nokia_Onyx -b android-12.1.0 device/nokia/Onyx
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_device_nokia_Crystal -b android-12.1.0 device/nokia/Crystal
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_device_nokia_Plate2 -b android-12.1.0 device/nokia/Plate2
    git clone https://$gitpassword@github.com/Nokia-SDM660/proprietary_vendor_nokia -b android-12.1.0 vendor/nokia
    git clone https://$gitpassword@github.com/Nokia-SDM660/proprietary_vendor_nokia_GoogleCamera -b android-12.1.0 vendor/nokia/GoogleCamera
} &> /dev/null

L5()
{
    cd $path/pe
    git clone https://$gitpassword@github.com/HMD-AOSP/proprietary_vendor_nokia_Os_Updates -b Dragon-HMD-AOSP vendor/nokia/Os_Updates &> /dev/null
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Pixel-Experience for Nokia 6.1 Plus build started 
    
    $(date)
    "
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch aosp_Dragon-userdebug && make -j$(nproc --all) target-files-package otatools
    romname=$(cat $path/pe/out/target/product/Dragon/system/build.prop | grep org.pixelexperience.version.display | cut -d "=" -f 2)
    sign_target_files_apks -o -d $path/keys $path/pe/out/target/product/Dragon/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/pe/out/target/product/Dragon/signed-target-files.zip
    ota_from_target_files -k $path/keys/releasekey $path/pe/out/target/product/Dragon/signed-target-files.zip $path/pe/out/target/product/Dragon/$romname.zip
    cp -r out/target/product/*/PixelExperience**.zip $path
    rm -r out/target/product/*
    rm -r vendor/nokia/Os_Updates
    git clone https://$gitpassword@github.com/HMD-AOSP/proprietary_vendor_nokia_Os_Updates -b Onyx-HMD-AOSP vendor/nokia/Os_Updates &> /dev/null
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Pixel-Experience for Nokia 7 Plus build started 
    
    $(date)
    "
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch aosp_Onyx-userdebug && make -j$(nproc --all) target-files-package otatools
    romname=$(cat $path/pe/out/target/product/Onyx/system/build.prop | grep org.pixelexperience.version.display | cut -d "=" -f 2)
    sign_target_files_apks -o -d $path/keys $path/pe/out/target/product/Onyx/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/pe/out/target/product/Onyx/signed-target-files.zip
    ota_from_target_files -k $path/keys/releasekey $path/pe/out/target/product/Onyx/signed-target-files.zip $path/pe/out/target/product/Onyx/$romname.zip
    cp -r out/target/product/*/PixelExperience**.zip $path
    rm -r out/target/product/*
    rm -r vendor/nokia/Os_Updates
    git clone https://$gitpassword@github.com/HMD-AOSP/proprietary_vendor_nokia_Os_Updates -b Crystal-HMD-AOSP vendor/nokia/Os_Updates &> /dev/null
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Pixel-Experience for Nokia 7.1 build started 
    
    $(date)
    "
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch aosp_Crystal-userdebug && make -j$(nproc --all) target-files-package otatools
    romname=$(cat $path/pe/out/target/product/Crystal/system/build.prop | grep org.pixelexperience.version.display | cut -d "=" -f 2)
    sign_target_files_apks -o -d $path/keys $path/pe/out/target/product/Crystal/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/pe/out/target/product/Crystal/signed-target-files.zip
    ota_from_target_files -k $path/keys/releasekey $path/pe/out/target/product/Crystal/signed-target-files.zip $path/pe/out/target/product/Crystal/$romname.zip
    cp -r out/target/product/*/PixelExperience**.zip $path
    rm -r out/target/product/*
    rm -r vendor/nokia/Os_Updates
    git clone https://$gitpassword@github.com/HMD-AOSP/proprietary_vendor_nokia_Os_Updates -b Plate2-HMD-AOSP vendor/nokia/Os_Updates &> /dev/null
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Pixel-Experience for Nokia 6.1 build started 
    
    $(date)
    "
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch aosp_Plate2-userdebug && make -j$(nproc --all) target-files-package otatools
    romname=$(cat $path/pe/out/target/product/Plate2/system/build.prop | grep org.pixelexperience.version.display | cut -d "=" -f 2)
    sign_target_files_apks -o -d $path/keys $path/pe/out/target/product/Plate2/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/pe/out/target/product/Plate2/signed-target-files.zip
    ota_from_target_files -k $path/keys/releasekey $path/pe/out/target/product/Plate2/signed-target-files.zip $path/pe/out/target/product/Plate2/$romname.zip
    cp -r out/target/product/*/PixelExperience**.zip $path
    rm -r out/target/product/*
    rm -r vendor/nokia/Os_Updates
}


L6()
{
    cd $path/pe
    rm -r device/nokia
    rm -r vendor/nokia
    rm -r device/custom/sepolicy
    rm -r device/qcom/sepolicy-legacy-um
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_device_nokia_Daredevil.git -b android-12.1.0-PV device/nokia/Daredevil
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_device_nokia_Starlord.git -b android-12.1.0-PV device/nokia/Starlord
    git clone https://$gitlpassword@gitlab.com/RaghuVarma331/proprietary_vendor_nokia.git -b android-12.1.0-PV --depth=1 vendor/nokia
    git clone https://$gitpassword@github.com/Nokia-SDM660/proprietary_vendor_nokia_GoogleCamera -b android-12.1.0 vendor/nokia/GoogleCamera
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_device_qcom_sepolicy-legacy-um -b android-12.1.0 device/qcom/sepolicy-legacy-um
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_device_lineage_sepolicy -b android-12.1.0 device/lineage/sepolicy
}

L7()
{
    cd $path/pe
    git clone https://$gitpassword@github.com/HMD-AOSP/proprietary_vendor_nokia_Os_Updates -b Daredevil-HMD-AOSP vendor/nokia/Os_Updates &> /dev/null
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Pixel-Experience for Nokia 7.2 build started 
    
    $(date)
    "
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch aosp_Daredevil-userdebug && make -j$(nproc --all) target-files-package otatools
    romname=$(cat $path/pe/out/target/product/Daredevil/system/build.prop | grep org.pixelexperience.version.display | cut -d "=" -f 2)
    sign_target_files_apks -o -d $path/keys $path/pe/out/target/product/Daredevil/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/pe/out/target/product/Daredevil/signed-target-files.zip
    ota_from_target_files -k $path/keys/releasekey $path/pe/out/target/product/Daredevil/signed-target-files.zip $path/pe/out/target/product/Daredevil/$romname.zip
    cp -r out/target/product/*/PixelExperience**.zip $path
    rm -r out/target/product/*
    rm -r vendor/nokia/Os_Updates
    git clone https://$gitpassword@github.com/HMD-AOSP/proprietary_vendor_nokia_Os_Updates -b Starlord-HMD-AOSP vendor/nokia/Os_Updates &> /dev/null
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Pixel-Experience for Nokia 6.2 build started 
    
    $(date)
    "
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch aosp_Starlord-userdebug && make -j$(nproc --all) target-files-package otatools
    romname=$(cat $path/pe/out/target/product/Starlord/system/build.prop | grep org.pixelexperience.version.display | cut -d "=" -f 2)
    sign_target_files_apks -o -d $path/keys $path/pe/out/target/product/Starlord/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/pe/out/target/product/Starlord/signed-target-files.zip
    ota_from_target_files -k $path/keys/releasekey $path/pe/out/target/product/Starlord/signed-target-files.zip $path/pe/out/target/product/Starlord/$romname.zip
    cp -r out/target/product/*/PixelExperience**.zip $path
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
echo "Downloading Pixel-Experience Source Code.."
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
echo "Started uploading build and updating OTA for G60/G40"
echo "----------------------------------------------------" 
OTA-UPLOAD
echo "----------------------------------------------------"
echo "Downloading Nokia Patches.."
echo "----------------------------------------------------"
L3A
echo "----------------------------------------------------"
echo "Downloading DRG B2N CTL PL2 Device sources.."
echo "----------------------------------------------------" 
L4
echo "----------------------------------------------------"
echo "Started building for DRG B2N CTL PL2.."
echo "----------------------------------------------------" 
L5
echo "----------------------------------------------------"
echo "Downloading DDV SLD Device sources.."
echo "----------------------------------------------------" 
L6
echo "----------------------------------------------------"
echo "Started building for DDV SLD.."
echo "----------------------------------------------------" 
L7
echo "----------------------------------------------------"
echo "Successfully build completed.."
echo "----------------------------------------------------" 


