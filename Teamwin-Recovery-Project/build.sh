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
TV=3.7.0_
AV=12-0

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
    echo -ne '\n' | repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-12.1 --git-lfs --depth=1
    repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
    rm -r .repo
}

SOURCE()
{
    cd $path/twrp
    git clone https://github.com/Motorola-SM6150/android_device_motorola_hanoip-TWRP.git -b android-12.1 device/motorola/hanoip
    git clone https://github.com/Nokia-SDM660/android_device_nokia_DRG_sprout-TWRP.git -b android-12.1 device/nokia/DRG_sprout
    git clone https://github.com/Nokia-SDM660/android_device_nokia_B2N_sprout-TWRP.git -b android-12.1 device/nokia/B2N_sprout
    git clone https://github.com/Nokia-SDM660/android_device_nokia_CTL_sprout-TWRP.git -b android-12.1 device/nokia/CTL_sprout
    git clone https://github.com/Nokia-SDM660/android_device_nokia_PL2_sprout-TWRP.git -b android-12.1 device/nokia/PL2_sprout
    git clone https://github.com/Nokia-SDM660/android_device_nokia_DDV_sprout-TWRP.git -b android-12.1 device/nokia/DDV_sprout
    git clone https://github.com/Nokia-SDM660/android_device_nokia_A1N_sprout-TWRP.git -b android-12.1 device/nokia/A1N_sprout
}

BUILD()
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
    cd $path/twrp/device/nokia/DRG_sprout/installer
    rm -r ***.zip ramdisk-twrp.cpio &> /dev/null
    cd $path/twrp
    . build/envsetup.sh && lunch twrp_DRG_sprout-eng && make -j$(nproc --all) bootimage
    cd out/target/product/*
    mv boot.img twrp-$TV$AV-DRG_sprout-$CUSTOM_BUILD_DATE.img
    cp -r twrp****.img $path/release
    mv ***.cpio ramdisk-twrp.cpio
    cp -r ramdisk-twrp.cpio $path/twrp/device/nokia/DRG_sprout/installer
    cd $path/twrp/device/nokia/DRG_sprout/installer
    zip -r twrp-installer-$TV$AV-DRG_sprout-$CUSTOM_BUILD_DATE.zip magiskboot  META-INF ramdisk-twrp.cpio
    cp -r twrp****.zip $path/release
    rm -r ***.zip ramdisk-twrp.cpio &> /dev/null
    cd $path/twrp
    rm -r out/target/product/*
    cd $path/twrp/device/nokia/B2N_sprout/installer
    rm -r ***.zip ramdisk-twrp.cpio &> /dev/null
    cd $path/twrp
    . build/envsetup.sh && lunch twrp_B2N_sprout-eng && make -j$(nproc --all) bootimage
    cd out/target/product/*
    mv boot.img twrp-$TV$AV-B2N_sprout-$CUSTOM_BUILD_DATE.img
    cp -r twrp****.img $path/release
    mv ***.cpio ramdisk-twrp.cpio
    cp -r ramdisk-twrp.cpio $path/twrp/device/nokia/B2N_sprout/installer
    cd $path/twrp/device/nokia/B2N_sprout/installer
    zip -r twrp-installer-$TV$AV-B2N_sprout-$CUSTOM_BUILD_DATE.zip magiskboot  META-INF ramdisk-twrp.cpio
    cp -r twrp****.zip $path/release
    rm -r ***.zip ramdisk-twrp.cpio &> /dev/null
    cd $path/twrp
    rm -r out/target/product/*
    cd $path/twrp/device/nokia/CTL_sprout/installer
    rm -r ***.zip ramdisk-twrp.cpio &> /dev/null
    cd $path/twrp
    . build/envsetup.sh && lunch twrp_CTL_sprout-eng && make -j$(nproc --all) bootimage
    cd out/target/product/*
    mv boot.img twrp-$TV$AV-CTL_sprout-$CUSTOM_BUILD_DATE.img
    cp -r twrp****.img $path/release
    mv ***.cpio ramdisk-twrp.cpio
    cp -r ramdisk-twrp.cpio $path/twrp/device/nokia/CTL_sprout/installer
    cd $path/twrp/device/nokia/CTL_sprout/installer
    zip -r twrp-installer-$TV$AV-CTL_sprout-$CUSTOM_BUILD_DATE.zip magiskboot  META-INF ramdisk-twrp.cpio
    cp -r twrp****.zip $path/release
    rm -r ***.zip ramdisk-twrp.cpio &> /dev/null
    cd $path/twrp
    rm -r out/target/product/*
    cd $path/twrp/device/nokia/PL2_sprout/installer
    rm -r ***.zip ramdisk-twrp.cpio &> /dev/null
    cd $path/twrp
    . build/envsetup.sh && lunch twrp_PL2_sprout-eng && make -j$(nproc --all) bootimage
    cd out/target/product/*
    mv boot.img twrp-$TV$AV-PL2_sprout-$CUSTOM_BUILD_DATE.img
    cp -r twrp****.img $path/release
    mv ***.cpio ramdisk-twrp.cpio
    cp -r ramdisk-twrp.cpio $path/twrp/device/nokia/PL2_sprout/installer
    cd $path/twrp/device/nokia/PL2_sprout/installer
    zip -r twrp-installer-$TV$AV-PL2_sprout-$CUSTOM_BUILD_DATE.zip magiskboot  META-INF ramdisk-twrp.cpio
    cp -r twrp****.zip $path/release
    rm -r ***.zip ramdisk-twrp.cpio &> /dev/null
    cd $path/twrp
    rm -r out/target/product/*
    cd $path/twrp/device/nokia/DDV_sprout/installer
    rm -r ***.zip ramdisk-twrp.cpio &> /dev/null
    cd $path/twrp
    . build/envsetup.sh && lunch twrp_DDV_sprout-eng && make -j$(nproc --all) bootimage
    cd out/target/product/*
    mv boot.img twrp-$TV$AV-DDV_sprout-$CUSTOM_BUILD_DATE.img
    cp -r twrp****.img $path/release
    mv ***.cpio ramdisk-twrp.cpio
    cp -r ramdisk-twrp.cpio $path/twrp/device/nokia/DDV_sprout/installer
    cd $path/twrp/device/nokia/DDV_sprout/installer
    zip -r twrp-installer-$TV$AV-DDV_sprout-$CUSTOM_BUILD_DATE.zip magiskboot  META-INF ramdisk-twrp.cpio
    cp -r twrp****.zip $path/release
    rm -r ***.zip ramdisk-twrp.cpio &> /dev/null
    cd $path/twrp
    rm -r out/target/product/*
    cd $path/twrp/device/nokia/A1N_sprout/installer
    rm -r ***.zip ramdisk-twrp.cpio &> /dev/null
    cd $path/twrp
    . build/envsetup.sh && lunch twrp_A1N_sprout-eng && make -j$(nproc --all) bootimage
    cd out/target/product/*
    mv boot.img twrp-$TV$AV-A1N_sprout-$CUSTOM_BUILD_DATE.img
    cp -r twrp****.img $path/release
    mv ***.cpio ramdisk-twrp.cpio
    cp -r ramdisk-twrp.cpio $path/twrp/device/nokia/A1N_sprout/installer
    cd $path/twrp/device/nokia/A1N_sprout/installer
    zip -r twrp-installer-$TV$AV-A1N_sprout-$CUSTOM_BUILD_DATE.zip magiskboot  META-INF ramdisk-twrp.cpio
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
    sshpass -p $SF rsync -avP -e ssh ***hanoip***  raghuvarma331@frs.sourceforge.net:/home/frs/project/motorola-sm6150/G60/TWRP
    sshpass -p $SF rsync -avP -e ssh ***DRG_sprout** raghuvarma331@frs.sourceforge.net:/home/frs/project/drg-sprout/TWRP
    sshpass -p $SF rsync -avP -e ssh ***B2N_sprout** raghuvarma331@frs.sourceforge.net:/home/frs/project/b2n-sprout/TWRP
    sshpass -p $SF rsync -avP -e ssh ***CTL_sprout** raghuvarma331@frs.sourceforge.net:/home/frs/project/ctl-sprout/TWRP
    sshpass -p $SF rsync -avP -e ssh ***PL2_sprout** raghuvarma331@frs.sourceforge.net:/home/frs/project/pl2-sprout/TWRP
    sshpass -p $SF rsync -avP -e ssh ***DDV_sprout** raghuvarma331@frs.sourceforge.net:/home/frs/project/ddv-sprout/TWRP
    sshpass -p $SF rsync -avP -e ssh ***A1N_sprout** raghuvarma331@frs.sourceforge.net:/home/frs/project/a1n-sprout/TWRP
}

POST()
{
    cd $path
    wget https://github.com/RaghuVarma331/scripts/raw/master/pythonscripts/telegram.py
    wget https://github.com/RaghuVarma331/custom_roms_banners/raw/master/twrp.jpg

    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "
    *
    New TWRP-$TV$AV build

    $(date)*

    ⬇️ [Download TWRP](https://nokia-sdm660.github.io/)
    📱Device: *Nokia 6.1 Plus*
    ⚡Build Version: *$TV$AV*
    👤 By: *@RaghuVarma*
    #drg #nokia #twrp #update
    Follow:  @Nokia6plusofficial ✅"

    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "
    *
    New TWRP-$TV$AV build

    $(date)*

    ⬇️ [Download TWRP](https://nokia-sdm660.github.io/)
    📱Device: *Nokia 7 Plus*
    ⚡Build Version: *$TV$AV*
    👤 By: *@RaghuVarma*
    #b2n #nokia #twrp #update
    Follow:  @Nokia7plusofficial ✅"

    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "
    *
    New TWRP-$TV$AV build

    $(date)*

    ⬇️ [Download TWRP](https://nokia-sdm660.github.io/)
    📱Device: *Nokia 7.1*
    ⚡Build Version: *$TV$AV*
    👤 By: *@RaghuVarma*
    #ctl #nokia #twrp #update
    Follow:  @nokia7161 ✅"

    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "
    *
    New TWRP-$TV$AV build

    $(date)*

    ⬇️ [Download TWRP](https://nokia-sdm660.github.io/)
    📱Device: *Nokia 6.1*
    ⚡Build Version: *$TV$AV*
    👤 By: *@RaghuVarma*
    #pl2 #nokia #twrp #update
    Follow:  @nokia7161 ✅"

    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "
    *
    New TWRP-$TV$AV build

    $(date)*

    ⬇️ [Download TWRP](https://nokia-sdm660.github.io/)
    📱Device: *Nokia 7.2*
    ⚡Build Version: *$TV$AV*
    👤 By: *@RaghuVarma*
    #ddv #nokia #twrp #update
    Follow:  @Nokia7262 ✅"

    python telegram.py -t $Telegram_Api_code -c @Nokia8Sirocco -P twrp.jpg -C "
    *
    New TWRP-$TV$AV build

    $(date)*

    ⬇️ [Download TWRP](https://nokia-sdm660.github.io/)
    📱Device: *Nokia 8 Sirocco*
    ⚡Build Version: *$TV$AV*
    👤 By: *@RaghuVarma*
    #a1n #nokia #twrp #update
    Follow:  @Nokia8Sirocco ✅"

    python telegram.py -t $Telegram_Api_code -c @MotoG60G40  -P twrp.jpg -C "
    *
    New TWRP-$TV$AV build

    $(date)*

    ⬇️ [Download TWRP](https://motorola-sm6150.github.io/)
    📱Device: *Moto G60/G40*
    ⚡Build Version: *$TV$AV*
    👤 By: *@RaghuVarma*
    #g60 #g40 #twrp #update
    Follow:  @MotoG60G40 ✅" 
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
echo "Downloading device sources.."
echo "----------------------------------------------------" 
SOURCE
echo "----------------------------------------------------"
echo "Started building TWRP.."
echo "----------------------------------------------------" 
BUILD
echo "----------------------------------------------------"
echo "Successfully build completed.."
echo "----------------------------------------------------" 
echo "----------------------------------------------------"
echo "Started uploading builds.."
echo "----------------------------------------------------" 
TWRP-UPLOAD
echo "----------------------------------------------------"
echo "Started posting in telegram.."
echo "----------------------------------------------------" 
POST
echo "----------------------------------------------------"
echo "Successfully completed.."
echo "----------------------------------------------------" 
#CLEAN

