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

Telegram_Api_code=
chat_id=
gitpassword=

L1()
{
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
    git clone https://$gitpassword@github.com/Motorola-SM6150/Private_keys -b android-13.0 keys
    mkdir pe
    cd pe
    echo -ne '\n' | repo init -u https://github.com/PixelExperience/manifest -b thirteen-plus --git-lfs --depth=1
    repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
    rm -r .repo
    sed -i "/ro.control_privapp_permissions=enforce/d" vendor/aosp/config/common.mk
}

L4()
{
    cd $path/pe
    git clone https://$gitpassword@github.com/Motorola-SM6150/android_device_motorola_hanoip -b android-13.0 --depth=1 device/motorola/hanoip
    git clone https://$gitpassword@github.com/Motorola-SM6150/proprietary_vendor_motorola_hanoip -b android-13.0 --depth=1 vendor/motorola/hanoip
    git clone https://$gitpassword@github.com/Motorola-SM6150/android_kernel_motorola_sm6150 -b android-13.0 --depth=1 kernel/motorola/sm6150
    . build/envsetup.sh && lunch aosp_hanoip-userdebug && make -j$(nproc --all) target-files-package otatools
    romname=$(cat $path/pe/out/target/product/hanoip/system/build.prop | grep org.pixelexperience.version.display | cut -d "=" -f 2)
    sign_target_files_apks -o -d $path/keys $path/pe/out/target/product/hanoip/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/pe/out/target/product/hanoip/signed-target-files.zip
    ota_from_target_files -k $path/keys/releasekey $path/pe/out/target/product/hanoip/signed-target-files.zip $path/pe/out/target/product/hanoip/$romname.zip
    cp -r out/target/product/*/PixelExperience**.zip $path
    rm -r out/target/product/*
    rm -r device/moto*
    rm -r kernel/moto*
    rm -r vendor/moto*
    rm -r vendor/aosp
}

L5()
{
    cd $path/pe
    git clone https://$gitpassword@github.com/RaghuVarma331/vendor_aosp -b thirteen-plus vendor/aosp --depth=1
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_device_nokia_Dragon -b android-13.0 device/nokia/Dragon --depth=1
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_device_nokia_Onyx -b android-13.0 device/nokia/Onyx --depth=1
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_device_nokia_Crystal -b android-13.0 device/nokia/Crystal --depth=1
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_device_nokia_Plate2 -b android-13.0 device/nokia/Plate2 --depth=1
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_device_nokia_Daredevil -b android-13.0 device/nokia/Daredevil --depth=1
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_device_nokia_Avenger -b android-13.0 device/nokia/Avenger --depth=1
    git clone https://$gitpassword@github.com/Nokia-SDM660/proprietary_vendor_nokia_Dragon -b android-13.0 vendor/nokia/Dragon --depth=1
    git clone https://$gitpassword@github.com/Nokia-SDM660/proprietary_vendor_nokia_Onyx -b android-13.0 vendor/nokia/Onyx --depth=1
    git clone https://$gitpassword@github.com/Nokia-SDM660/proprietary_vendor_nokia_Crystal -b android-13.0 vendor/nokia/Crystal --depth=1
    git clone https://$gitpassword@github.com/Nokia-SDM660/proprietary_vendor_nokia_Plate2 -b android-13.0 vendor/nokia/Plate2 --depth=1
    git clone https://$gitpassword@github.com/Nokia-SDM660/proprietary_vendor_nokia_Daredevil -b android-13.0 vendor/nokia/Daredevil --depth=1
    git clone https://$gitpassword@github.com/Nokia-SDM660/proprietary_vendor_nokia_Avenger -b android-13.0 vendor/nokia/Avenger --depth=1
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_kernel_nokia_LC-SDM660.git -b android-13.0-GCC --depth=1 kernel/nokia/sdm660
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    New Pixel-Experience Plus for Nokia 7.2 build started

    $(date)
    "
    . build/envsetup.sh && lunch aosp_Daredevil-userdebug && make -j$(nproc --all) target-files-package otatools
    romname=$(cat $path/pe/out/target/product/Daredevil/system/build.prop | grep org.pixelexperience.version.display | cut -d "=" -f 2)
    sign_target_files_apks -o -d $path/keys $path/pe/out/target/product/Daredevil/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/pe/out/target/product/Daredevil/signed-target-files.zip
    ota_from_target_files -k $path/keys/releasekey $path/pe/out/target/product/Daredevil/signed-target-files.zip $path/pe/out/target/product/Daredevil/$romname.zip
    cp -r out/target/product/*/PixelExperience**.zip $path
    rm -r out/target/product/*
    rm -r kernel/nokia/sdm660
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_kernel_nokia_sdm660.git -b android-13.0-GCC --depth=1 kernel/nokia/sdm660
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    New Pixel-Experience Plus for Nokia 6.1 Plus build started

    $(date)
    "
    . build/envsetup.sh && lunch aosp_Dragon-userdebug && make -j$(nproc --all) target-files-package otatools
    romname=$(cat $path/pe/out/target/product/Dragon/system/build.prop | grep org.pixelexperience.version.display | cut -d "=" -f 2)
    sign_target_files_apks -o -d $path/keys $path/pe/out/target/product/Dragon/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/pe/out/target/product/Dragon/signed-target-files.zip
    ota_from_target_files -k $path/keys/releasekey $path/pe/out/target/product/Dragon/signed-target-files.zip $path/pe/out/target/product/Dragon/$romname.zip
    cp -r out/target/product/*/PixelExperience**.zip $path
    rm -r out/target/product/*
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    New Pixel-Experience Plus for Nokia 7 Plus build started

    $(date)
    "
    . build/envsetup.sh && lunch aosp_Onyx-userdebug && make -j$(nproc --all) target-files-package otatools
    romname=$(cat $path/pe/out/target/product/Onyx/system/build.prop | grep org.pixelexperience.version.display | cut -d "=" -f 2)
    sign_target_files_apks -o -d $path/keys $path/pe/out/target/product/Onyx/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/pe/out/target/product/Onyx/signed-target-files.zip
    ota_from_target_files -k $path/keys/releasekey $path/pe/out/target/product/Onyx/signed-target-files.zip $path/pe/out/target/product/Onyx/$romname.zip
    cp -r out/target/product/*/PixelExperience**.zip $path
    rm -r out/target/product/*
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    New Pixel-Experience Plus for Nokia 7.1 build started

    $(date)
    "
    . build/envsetup.sh && lunch aosp_Crystal-userdebug && make -j$(nproc --all) target-files-package otatools
    romname=$(cat $path/pe/out/target/product/Crystal/system/build.prop | grep org.pixelexperience.version.display | cut -d "=" -f 2)
    sign_target_files_apks -o -d $path/keys $path/pe/out/target/product/Crystal/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/pe/out/target/product/Crystal/signed-target-files.zip
    ota_from_target_files -k $path/keys/releasekey $path/pe/out/target/product/Crystal/signed-target-files.zip $path/pe/out/target/product/Crystal/$romname.zip
    cp -r out/target/product/*/PixelExperience**.zip $path
    rm -r out/target/product/*
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    New Pixel-Experience Plus for Nokia 6.1 build started

    $(date)
    "
    . build/envsetup.sh && lunch aosp_Plate2-userdebug && make -j$(nproc --all) target-files-package otatools
    romname=$(cat $path/pe/out/target/product/Plate2/system/build.prop | grep org.pixelexperience.version.display | cut -d "=" -f 2)
    sign_target_files_apks -o -d $path/keys $path/pe/out/target/product/Plate2/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/pe/out/target/product/Plate2/signed-target-files.zip
    ota_from_target_files -k $path/keys/releasekey $path/pe/out/target/product/Plate2/signed-target-files.zip $path/pe/out/target/product/Plate2/$romname.zip
    cp -r out/target/product/*/PixelExperience**.zip $path
    rm -r out/target/product/*
    rm -r kernel/nokia/sdm660
    rm -r bootable/recovery
    git clone https://$gitpassword@github.com/RaghuVarma331/android_bootable_recovery.git -b thirteen bootable/recovery --depth=1
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_kernel_nokia_FIH-MSM8998.git -b android-13.0-GCC --depth=1 kernel/nokia/msm8998
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    New Pixel-Experience Plus for Nokia 8 Sirocco build started

    $(date)
    "
    . build/envsetup.sh && lunch aosp_Avenger-userdebug && make -j$(nproc --all) target-files-package otatools
    romname=$(cat $path/pe/out/target/product/Avenger/system/build.prop | grep org.pixelexperience.version.display | cut -d "=" -f 2)
    sign_target_files_apks -o -d $path/keys $path/pe/out/target/product/Avenger/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/pe/out/target/product/Avenger/signed-target-files.zip
    ota_from_target_files -k $path/keys/releasekey $path/pe/out/target/product/Avenger/signed-target-files.zip $path/pe/out/target/product/Avenger/$romname.zip
    cp -r out/target/product/*/PixelExperience**.zip $path
    rm -r out/target/product/*
    rm -r device/nokia
    rm -r vendor/nokia
    rm -r kernel/nokia
}

echo "----------------------------------------------------"
echo "Initialising setup.."
echo "----------------------------------------------------"
L1
echo "----------------------------------------------------"
echo "Setting up repo launcher.."
echo "----------------------------------------------------"
L2
echo "----------------------------------------------------"
echo "Downloading Pixel Experience Plus source code.."
echo "----------------------------------------------------"
L3
echo "----------------------------------------------------"
echo "Building Pixel Experience Plus for Moto G60/G40F.."
echo "----------------------------------------------------"
L4
echo "----------------------------------------------------"
echo "Building Pixel Experience Plus for Nokia Devices.."
echo "----------------------------------------------------"
L5
