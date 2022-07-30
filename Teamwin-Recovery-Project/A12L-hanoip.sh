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

path=/var/lib/jenkins/workspace/TWRP

# credentials

Telegram_Api_code=$(cat $path/cred** | grep api | cut -d "=" -f 2)
chat_id=$(cat $path/cred** | grep id | cut -d "=" -f 2)
gitpassword=$(cat $path/cred** | grep git | cut -d "=" -f 2)
SF=$(cat $path/cred** | grep sf | cut -d "=" -f 2)
TV=3.6.2_
AV=12.1-0

# D_T_Y
CUSTOM_DATE_YEAR="$(date -u +%Y)"
CUSTOM_DATE_MONTH="$(date -u +%m)"
CUSTOM_DATE_DAY="$(date -u +%d)"
CUSTOM_DATE_HOUR="$(date -u +%H)"
CUSTOM_DATE_MINUTE="$(date -u +%M)"
CUSTOM_BUILD_DATE="$CUSTOM_DATE_YEAR""$CUSTOM_DATE_MONTH""$CUSTOM_DATE_DAY"-"$CUSTOM_DATE_HOUR""$CUSTOM_DATE_MINUTE"

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
    mkdir release
    mkdir twrp
    cd twrp
    echo -ne '\n' | repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1 --depth=1
    repo sync
    rm -r .repo
    rm -r bootable/recovery
    rm -r system/vold
}

G60G40-A()
{
    cd $path/twrp
    git clone https://$gitpassword@github.com/Motorola-SM6150/android_device_motorola_hanoip-TWRP.git -b android-12.1 device/motorola/hanoip
    git clone https://$gitpassword@github.com/Motorola-SM6150/android_bootable_recovery -b android-12.1 --depth=1 bootable/recovery
    git clone https://$gitpassword@github.com/Motorola-SM6150/android_system_vold -b android-12.1 --depth=1 system/vold
}

G60G40-B()
{
    cd $path/twrp/device/motorola/hanoip/installer
    rm -r ***.zip ramdisk-twrp.cpio &> /dev/null
    cd $path/twrp
    . build/envsetup.sh && lunch twrp_hanoip-eng && make -j$(nproc --all) bootimage
    cd out/target/product/*
    mv boot.img twrp-$TV$AV-hanoip-$CUSTOM_BUILD_DATE.img
    cp -r twrp****.img $path/release
    mv ***.cpio ramdisk-twrp.cpio
    cp -r ramdisk-twrp.cpio $path/twrp/device/motorola/hanoip/installer
    cd $path/twrp/device/motorola/hanoip/installer
    zip -r twrp-installer-$TV$AV-hanoip-$CUSTOM_BUILD_DATE.zip magiskboot  META-INF ramdisk-twrp.cpio
    cp -r twrp****.zip $path/release
    rm -r ***.zip ramdisk-twrp.cpio &> /dev/null
    cd $path/twrp
    rm -r out/target/product/*
}

TWRP-UPLOAD()
{
    cd $path/release
    mkdir -p ~/.ssh  &&  echo "Host *" > ~/.ssh/config && echo " StrictHostKeyChecking no" >> ~/.ssh/config
    echo "# Allow Jenkins" >> /etc/sudoers && echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
    sshpass -p $SF rsync -avP -e ssh twrp***  raghuvarma331@frs.sourceforge.net:/home/frs/project/motorola-sm6150/G60/TWRP
    rm -r *
}

CLEAN()
{
    echo "----------------------------------------------------"
    echo "Started cleaning workspace.."
    echo "----------------------------------------------------" 
    cd $path
    rm -r bin  twrp release
    echo "----------------------------------------------------"
    echo "Successfully cleaned.."
    echo "----------------------------------------------------" 
}

echo "----------------------------------------------------"
echo "Downloading repo bin.."
echo "----------------------------------------------------" 
L2
echo "----------------------------------------------------"
echo "Downloading TWRP Source Code.."
echo "----------------------------------------------------" 
L3
echo "----------------------------------------------------"
echo "Downloading G60/G40 device source.."
echo "----------------------------------------------------" 
G60G40-A
echo "----------------------------------------------------"
echo "Started building TWRP for G60/G40.."
echo "----------------------------------------------------" 
G60G40-B
echo "----------------------------------------------------"
echo "Successfully build completed.."
echo "----------------------------------------------------" 
echo "----------------------------------------------------"
echo "Started uploading build for G60/G40"
echo "----------------------------------------------------" 
TWRP-UPLOAD
echo "----------------------------------------------------"
echo "Successfully completed.."
echo "----------------------------------------------------" 
#CLEAN
