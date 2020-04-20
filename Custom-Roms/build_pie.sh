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

# Init Fields

Telegram_Api_code=
chat_id=
jenkinsurl=
securitypatch=2019-10-05

# Init Methods

EVOX-SOURCE()
{
    mkdir evo
    cd evo
    echo -ne '\n' | repo init -u https://github.com/Evolution-X/platform_manifest -b pie --depth=1
    repo sync -c --no-tags --no-clone-bundle -f --force-sync -j16
    sed -i "/ro.control_privapp_permissions=enforce/d" vendor/aosp/config/common.mk
    git clone https://github.com/LineageOS/android_packages_resources_devicesettings.git -b lineage-16.0 packages/resources/devicesettings
    git clone https://github.com/RaghuVarma331/android_device_nokia_Dragon.git -b pie device/nokia/Dragon
    git clone https://github.com/RaghuVarma331/android_kernel_nokia_sdm660.git -b pie --depth=1 kernel/nokia/sdm660
    git clone https://gitlab.com/RaghuVarma331/vendor_nokia_dragon.git -b pie vendor/nokia/Dragon
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New EvolutionX for Nokia 6.1 Plus build started 
    
    $(date)
    
    👤 By: Raghu Varma

    build's progress at $jenkinsurl"     
    . build/envsetup.sh && lunch aosp_Dragon-eng && make -j32 bacon
    cd out/target/product/Dragon
    rm -r android-info.txt  dex_bootjars obj_arm  product_copy_files_ignored.txt  symbols boot.img fake_packages ramdisk.img system build_fingerprint.txt gen ramdisk-recovery.img userdata.img build_thumbprint.txt install recovery clean_steps.mk kernel recovery.id data obj previous_build_config.mk  root vendor
    cd ..
    cp -r Dragon /var/lib/jenkins/workspace/Raghu
    cd 
    cd /var/lib/jenkins/workspace/Raghu
    mv Dragon drgevo
    rm -r evo
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="

    New EvolutionX Build is up 
    
    $(date)
    
    ⬇️ Download https://sourceforge.net/projects/drg-sprout/files/EvolutionX
    
    📱Device: Nokia 6.1 Plus
    
    ⚡Build Version: 2.3
    
    ⚡Android Version: 9.0.0
    
    ⚡Security Patch : $securitypatch
    
    👤 By: Raghu Varma
    
    Follow:  @Nokia6plusofficial ✅" 
}

LINEAGE-SOURCE()
{
    mkdir los
    cd los
    echo -ne '\n' | repo init -u git://github.com/LineageOS/android.git -b lineage-16.0 --depth=1
    repo sync -c --no-tags --no-clone-bundle -f --force-sync -j16
    sed -i "/ro.control_privapp_permissions=enforce/d" vendor/lineage/config/common.mk
    git clone https://github.com/LineageOS/android_packages_resources_devicesettings.git -b lineage-16.0 packages/resources/devicesettings	
    git clone https://github.com/RaghuVarma331/android_device_nokia_Dragon.git -b pie device/nokia/Dragon
    git clone https://github.com/RaghuVarma331/android_kernel_nokia_sdm660.git -b pie --depth=1 kernel/nokia/sdm660	
    git clone https://gitlab.com/RaghuVarma331/vendor_nokia_dragon.git -b pie vendor/nokia/Dragon
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New LineageOS 16.0 for Nokia 6.1 Plus build started 
    
    $(date)
    
    👤 By: Raghu Varma

    build's progress at $jenkinsurl"  
    . build/envsetup.sh && lunch lineage_Dragon-eng && make -j32 bacon
    cd out/target/product/Dragon
    rm -r android-info.txt  dex_bootjars obj_arm  product_copy_files_ignored.txt  symbols boot.img fake_packages ramdisk.img system build_fingerprint.txt gen ramdisk-recovery.img userdata.img build_thumbprint.txt install recovery clean_steps.mk kernel recovery.id data obj previous_build_config.mk  root vendor
    cd ..
    cp -r Dragon /var/lib/jenkins/workspace/Raghu
    cd 
    cd /var/lib/jenkins/workspace/Raghu
    mv Dragon drglos
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="

    New LineageOS 16.0 Build is up 
    
    $(date)
    
    ⬇️ Download https://sourceforge.net/projects/drg-sprout/files/LineageOS
    
    📱Device: Nokia 6.1 Plus
    
    ⚡Build Version: 16.0
    
    ⚡Android Version: 9.0.0
    
    ⚡Security Patch : $securitypatch
    
    👤 By: Raghu Varma
    
    Follow:  @Nokia6plusofficial ✅"     
    cd los 
    rm -r device/nokia/Dragon     
    rm -r vendor/nokia/Dragon
    git clone https://github.com/RaghuVarma331/android_device_nokia_Onyx.git -b pie device/nokia/Onyx
    git clone https://gitlab.com/RaghuVarma331/vendor_nokia_onyx.git -b pie vendor/nokia/Onyx       
    rm -r out/target/product/Dragon    
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New LineageOS 16.0 for Nokia 7 Plus build started 
    
    $(date)
    
    👤 By: Raghu Varma

    build's progress at $jenkinsurl"
    . build/envsetup.sh && lunch lineage_Onyx-eng && make -j32 bacon
    cd out/target/product/Onyx
    rm -r android-info.txt  dex_bootjars obj_arm  product_copy_files_ignored.txt  symbols boot.img fake_packages ramdisk.img system build_fingerprint.txt gen ramdisk-recovery.img userdata.img build_thumbprint.txt install recovery clean_steps.mk kernel recovery.id data obj previous_build_config.mk  root vendor
    cd ..
    cp -r Onyx /var/lib/jenkins/workspace/Raghu
    cd 
    cd /var/lib/jenkins/workspace/Raghu
    mv Onyx b2nlos
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New LineageOS 16.0 Build is up 
    
    $(date)
    
    ⬇️ Download https://sourceforge.net/projects/b2n-sprout/files/LineageOS
    
    📱Device: Nokia 7 Plus
    
    ⚡Build Version: 16.0
    
    ⚡Android Version: 9.0.0
    
    ⚡Security Patch : $securitypatch
    
    👤 By: Raghu Varma
    
    Follow:  @Nokia7plusOfficial ✅"      
    cd los
    rm -r device/nokia
    rm -r kernel/nokia
    rm -r vendor/nokia
    rm -r prebuilts/clang 
    rm -r out/target/product/Onyx
    git clone https://github.com/PixelExperience/prebuilts_clang_host_linux-x86.git -b pie --depth=1 prebuilts/clang/host/linux-x86 
    git clone https://github.com/RaghuVarma331/android_device_xiaomi_whyred.git -b lineage-16.0 device/xiaomi/whyred    
    git clone https://github.com/RaghuVarma331/android_kernel_xiaomi_whyred.git --depth=1 -b pie-whyred kernel/xiaomi/whyred
    git clone https://github.com/RaghuVarma331/vendor_xiaomi_whyred.git -b pie vendor/xiaomi/whyred
    git clone https://github.com/RaghuVarma331/vendor_MiuiCamera.git -b pie vendor/MiuiCamera
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New LineageOS 16.0 for Redmi Note 5 Pro build started 
    
    $(date)
    
    👤 By: Raghu Varma

    build's progress at $jenkinsurl"    
    . build/envsetup.sh && lunch lineage_whyred-eng && make -j32 bacon
    cd out/target/product/whyred
    rm -r android-info.txt  dex_bootjars obj_arm  product_copy_files_ignored.txt  symbols boot.img fake_packages ramdisk.img system build_fingerprint.txt gen ramdisk-recovery.img userdata.img build_thumbprint.txt install recovery clean_steps.mk kernel recovery.id data obj previous_build_config.mk  root vendor
    cd ..
    cp -r whyred /var/lib/jenkins/workspace/Raghu
    cd 
    cd /var/lib/jenkins/workspace/Raghu
    mv whyred whyredlos	 
    rm -r los	 
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New LineageOS 16.0 Build is up 
    
    $(date)
    
    ⬇️ Download https://sourceforge.net/projects/whyred-rv/files/LineageOS
    
    📱Device: Redmi Note 5 Pro
    
    ⚡Build Version: 16.0
    
    ⚡Android Version: 9.0.0
    
    ⚡Security Patch : $securitypatch
    
    👤 By: Raghu Varma
    
    Follow:  @Nokia7plusOfficial ✅"       
}    

TWRP-P-SOURCE()
{
    mkdir DRG_sprout
    mkdir B2N_sprout
    mkdir whyred	
    mkdir twrp
    cd twrp
    repo init -u git://github.com/omnirom/android.git -b android-9.0 --depth=1
    repo sync -c --no-tags --no-clone-bundle -f --force-sync -j16
    rm -r bootable/recovery
    git clone https://github.com/RaghuVarma331/android_device_nokia_DRG_sprout-TWRP.git -b android-9.0 device/nokia/DRG_sprout
    git clone https://github.com/RaghuVarma331/android_device_nokia_B2N_sprout-TWRP.git -b android-9.0 device/nokia/B2N_sprout    
    git clone https://github.com/RaghuVarma331/android_device_xiaomi_whyred-TWRP.git -b android-9.0 device/xiaomi/whyred    
    git clone https://github.com/RaghuVarma331/android_bootable_recovery.git -b android-9.0 bootable/recovery
    git clone https://github.com/TeamWin/external_magisk-prebuilt -b master external/magisk-prebuilt
    git clone https://github.com/TeamWin/android_external_busybox.git -b android-9.0 external/busybox
    git clone https://github.com/omnirom/android_external_toybox.git -b android-9.0 external/toybox
    git clone https://github.com/omnirom/android_vendor_qcom_opensource_commonsys.git -b android-9.0 vendor/qcom/opensource/commonsys
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    New TWRP-3.3.1-0 for Nokia 6.1 Plus build started 
    
    $(date)
    
    👤 By: Raghu Varma

    build's progress at $jenkinsurl"        
    . build/envsetup.sh && lunch omni_DRG_sprout-eng && make -j32 recoveryimage
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    New TWRP-3.3.1-0 for Nokia 7 Plus build started 
    
    $(date)
    
    👤 By: Raghu Varma

    build's progress at $jenkinsurl"   
    . build/envsetup.sh && lunch omni_B2N_sprout-eng && make -j32 recoveryimage
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    New TWRP-3.3.1-0 for Redmi Note 5 Pro build started 
    
    $(date)
    
    👤 By: Raghu Varma

    build's progress at $jenkinsurl"
    . build/envsetup.sh && lunch omni_whyred-eng && make -j32 recoveryimage	
    cd out/target/product/DRG_sprout
    mv recovery.img twrp-3.3.1-0-DRG_sprout-$(date +"%Y%m%d")-$(date +"%H%M").img
    cp -r twrp-3.3.1-0-DRG_sprout-$(date +"%Y%m%d")-$(date +"%H%M").img /var/lib/jenkins/workspace/Raghu/DRG_sprout
    cd
    cd /var/lib/jenkins/workspace/Raghu/twrp	
    cd out/target/product/B2N_sprout
    mv recovery.img twrp-3.3.1-0-B2N_sprout-$(date +"%Y%m%d")-$(date +"%H%M").img
    cp -r twrp-3.3.1-0-B2N_sprout-$(date +"%Y%m%d")-$(date +"%H%M").img /var/lib/jenkins/workspace/Raghu/B2N_sprout
    cd
    cd /var/lib/jenkins/workspace/Raghu/twrp
    cd out/target/product/whyred
    mv recovery.img twrp-3.3.1-0-whyred-$(date +"%Y%m%d")-$(date +"%H%M").img
    cp -r twrp-3.3.1-0-whyred-$(date +"%Y%m%d")-$(date +"%H%M").img /var/lib/jenkins/workspace/Raghu/whyred
    cd
    cd /var/lib/jenkins/workspace/Raghu/twrp	
    rm -r device/nokia/DRG_sprout
    rm -r device/nokia/B2N_sprout
    rm -r device/xiaomi/whyred	
    git clone https://github.com/RaghuVarma331/android_device_nokia_DRG_sprout-TWRP.git -b android-9.0-IS device/nokia/DRG_sprout    
    git clone https://github.com/RaghuVarma331/android_device_nokia_B2N_sprout-TWRP.git -b android-9.0-IS device/nokia/B2N_sprout 	
    rm -r build/tools/buildinfo.sh
    cp -r device/nokia/DRG_sprout/buildinfo.sh /var/lib/jenkins/workspace/Raghu/twrp/build/tools
    rm -r device/nokia/DRG_sprout/buildinfo.sh
    rm -r device/nokia/B2N_sprout/buildinfo.sh	
    rm -r out
    . build/envsetup.sh && lunch omni_DRG_sprout-eng && make -j32 recoveryimage
    . build/envsetup.sh && lunch omni_B2N_sprout-eng && make -j32 recoveryimage	
    cd out/target/product/DRG_sprout
    mv ramdisk-recovery.cpio ramdisk-twrp.cpio
    cp -r ramdisk-twrp.cpio /var/lib/jenkins/workspace/Raghu/twrp/device/nokia/DRG_sprout/installer
    cd
    cd /var/lib/jenkins/workspace/Raghu/twrp/device/nokia/DRG_sprout/installer
    zip -r twrp-installer-3.3.1-0-DRG_sprout-$(date +"%Y%m%d")-$(date +"%H%M").zip magiskboot  META-INF ramdisk-twrp.cpio
    cp -r twrp-installer-3.3.1-0-DRG_sprout-$(date +"%Y%m%d")-$(date +"%H%M").zip /var/lib/jenkins/workspace/Raghu/DRG_sprout  
    cd
    cd /var/lib/jenkins/workspace/Raghu/twrp	
    cd out/target/product/B2N_sprout
    mv ramdisk-recovery.cpio ramdisk-twrp.cpio
    cp -r ramdisk-twrp.cpio /var/lib/jenkins/workspace/Raghu/twrp/device/nokia/B2N_sprout/installer
    cd
    cd /var/lib/jenkins/workspace/Raghu/twrp/device/nokia/B2N_sprout/installer
    zip -r twrp-installer-3.3.1-0-B2N_sprout-$(date +"%Y%m%d")-$(date +"%H%M").zip magiskboot  META-INF ramdisk-twrp.cpio
    cp -r twrp-installer-3.3.1-0-B2N_sprout-$(date +"%Y%m%d")-$(date +"%H%M").zip /var/lib/jenkins/workspace/Raghu/B2N_sprout  
    cd
    cd /var/lib/jenkins/workspace/Raghu/
    rm -r twrp
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Twrp-3.3.1-0 Build is up 
    
    $(date)
    
    ⬇️ Download https://sourceforge.net/projects/drg-sprout/files/Twrp-3.3.1-0
    
    📱Device: Nokia 6.1 Plus
    
    ⚡Build Version: 3.3.1-0
    
    ⚡Android Version: 9.0.0
    
    👤 By: Raghu Varma
    
    Follow:  @Nokia6plusofficial ✅"     
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Twrp-3.3.1-0 Build is up 
    
    $(date)
    
    ⬇️ Download https://sourceforge.net/projects/b2n-sprout/files/Twrp-3.3.1-0
    
    📱Device: Nokia 7 Plus
    
    ⚡Build Version: 3.3.1-0
    
    ⚡Android Version: 9.0.0
    
    👤 By: Raghu Varma
    
    Follow:  @Nokia7plusOfficial ✅"     
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Twrp-3.3.1-0 Build is up 
    
    $(date)
    
    ⬇️ Download https://sourceforge.net/projects/whyred-rv/files/Twrp-3.3.1-0
    
    📱Device: Redmi Note 5 pro
    
    ⚡Build Version: 3.3.1-0
    
    ⚡Android Version: 9.0.0
    
    👤 By: Raghu Varma
    
    Follow:  @Nokia7plusOfficial ✅"	
}

DRG-TWRP-O-SOURCE()
{
    mkdir DRG_sprout
    mkdir twrp
    cd twrp
    repo init -u git://github.com/omnirom/android.git -b android-8.1 --depth=1
    repo sync -c --no-tags --no-clone-bundle -f --force-sync -j16
    rm -rf bootable/recovery
    git clone https://github.com/RaghuVarma331/android_device_nokia_DRG_sprout-TWRP.git -b android-8.1 device/nokia/DRG_sprout    
    git clone https://github.com/RaghuVarma331/android_bootable_recovery.git -b android-8.1 bootable/recovery
    git clone https://github.com/omnirom/android_external_busybox.git -b android-8.1 external/busybox
    git clone https://github.com/omnirom/android_external_toybox.git -b android-8.1 external/toybox
    git clone https://github.com/TeamWin/android_device_qcom_common -b android-8.0 device/qcom/common
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    New TWRP-3.2.3-0 for Nokia 6.1 Plus build started 
    
    $(date)
    
    👤 By: Raghu Varma

    build's progress at $jenkinsurl"          
    . build/envsetup.sh && lunch omni_DRG_sprout-eng && make -j32 recoveryimage
    cd out/target/product/DRG_sprout
    mv recovery.img twrp-3.2.3-0-DRG_sprout-$(date +"%Y%m%d")-$(date +"%H%M").img
    cp -r twrp-3.2.3-0-DRG_sprout-$(date +"%Y%m%d")-$(date +"%H%M").img /var/lib/jenkins/workspace/Raghu/DRG_sprout
    cd
    cd /var/lib/jenkins/workspace/Raghu
    rm -r twrp
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Twrp-3.2.3-0 Build is up 
    
    $(date)
    
    ⬇️ Download https://sourceforge.net/projects/drg-sprout/files/Twrp-3.2.3-0
    
    📱Device: Nokia 6.1 Plus
    
    ⚡Build Version: 3.2.3-0
    
    ⚡Android Version: 8.1.0
    
    👤 By: Raghu Varma
    
    Follow:  @Nokia6plusofficial ✅"         
}

KIWIS-SOURCE()
{
    mkdir kiwis-kernel
    git clone https://github.com/RaghuVarma331/aarch64-linux-android-4.9.git -b master aarch64-linux-android-4.9
    git clone https://github.com/RaghuVarma331/clang-r365631c-9.0.8.git -b master clang
    git clone https://github.com/RaghuVarma331/arm-linux-androideabi-4.9.git arm-linux-androideabi-4.9
    git clone https://github.com/RaghuVarma331/android_kernel_nokia_sdm660.git -b pie drg
    git clone https://github.com/RaghuVarma331/android_kernel_xiaomi_whyred.git -b pie-whyred why
    cd drg
    export ARCH=arm64
    export CROSS_COMPILE=/var/lib/jenkins/workspace/Raghu/aarch64-linux-android-4.9/bin/aarch64-linux-android-
    mkdir output
    make -C $(pwd) O=output SAT-perf_defconfig
    make -j32 -C $(pwd) O=output
    cp -r output/arch/arm64/boot/Image.gz-dtb /var/lib/jenkins/workspace/Raghu/drg/DRG_sprout
    cd DRG_sprout
    zip -r Kiwis-kernel-9.0-DRG_sprout-$(date +"%Y%m%d")-$(date +"%H%M").zip META-INF patch tools Image.gz-dtb anykernel.sh   
    cp -r Kiwis-kernel-9.0-DRG_sprout-$(date +"%Y%m%d")-$(date +"%H%M").zip /var/lib/jenkins/workspace/Raghu/kiwis-kernel
    cd
    cd /var/lib/jenkins/workspace/Raghu
    rm -r drg
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Kiwis-kernel Build is up 
    
    $(date)
    
    ⬇️ Download https://sourceforge.net/projects/drg-sprout/files/Kiwis-kernel
    
    📱Device: Nokia 6.1 Plus
    
    ⚡Android Version: 9.0.0
    
    👤 By: Raghu Varma
    
    Follow:  @Nokia6plusofficial ✅"    
    cd why
    export CROSS_COMPILE_ARM32=/var/lib/jenkins/workspace/Raghu/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-
    make O=out ARCH=arm64 whyred_defconfig
    PATH="/var/lib/jenkins/workspace/Raghu/clang/bin:/var/lib/jenkins/workspace/Raghu/aarch64-linux-android-4.9/bin:${PATH}" \
    make -j$(nproc --all) O=out \
                          ARCH=arm64 \
                          CC=clang \
                          CLANG_TRIPLE=aarch64-linux-gnu- \
                          CROSS_COMPILE=aarch64-linux-android-
    cp -r out/arch/arm64/boot/Image.gz-dtb /var/lib/jenkins/workspace/Raghu/why/whyred
    cd whyred
    zip -r Kiwis-kernel-9.0-whyred-$(date +"%Y%m%d")-$(date +"%H%M").zip META-INF patch tools Image.gz-dtb anykernel.sh   
    cp -r Kiwis-kernel-9.0-whyred-$(date +"%Y%m%d")-$(date +"%H%M").zip /var/lib/jenkins/workspace/Raghu/kiwis-kernel
    cd
    cd /var/lib/jenkins/workspace/Raghu
    rm -r why   aarch64-linux-android-4.9  arm-linux-androideabi-4.9  clang    
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    New Kiwis-kernel Build is up 
    
    $(date)
    
    ⬇️ Download https://sourceforge.net/projects/whyred-rv/files/Kiwis-kernel
    
    📱Device: Redmi note 5 pro 
    
    ⚡Android Version: 9.0.0
    
    👤 By: Raghu Varma
    
    Follow:  @Nokia6plusofficial ✅"    
}

TOOLS_SETUP() 
{
        sudo apt-get update 
        echo -ne '\n' | sudo apt-get upgrade
        echo -ne '\n' | sudo apt-get install git ccache schedtool lzop bison gperf build-essential zip curl zlib1g-dev g++-multilib python-networkx libxml2-utils bzip2 libbz2-dev libghc-bzlib-dev squashfs-tools pngcrush liblz4-tool optipng libc6-dev-i386 gcc-multilib libssl-dev gnupg flex lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev xsltproc unzip python-pip python-dev libffi-dev libxml2-dev libxslt1-dev libjpeg8-dev openjdk-8-jdk imagemagick device-tree-compiler repo mailutils-mh expect python3-requests python-requests android-tools-fsutils
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
}

		
# Main Menu
clear
echo "------------------------------------------------"
echo "A simple remote script to compile custom Stuff"
echo "Coded By Raghu Varma.G "
echo "------------------------------------------------"
PS3='Please select your option (1-6): '
menuvar=("BasicSetup" "evox" "lineageos" "twrp" "kiwis-kernel" "all_roms" "Exit")
select menuvar in "${menuvar[@]}"
do
    case $menuvar in
        "BasicSetup")
            clear
            echo "----------------------------------------------"
            echo "Started Settingup Basic Stuff For Linux..."
            echo "Please be patient..."
            # BasicSetup
            echo "----------------------------------------------"
            echo "Setting Up Tools & Stuff..."
            echo " "
            TOOLS_SETUP
	    echo " "	    
            echo "----------------------------------------------"
            echo "Settingup Basic Stuff For Linux finished."
            echo " "
            echo "----------------------------------------------"
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;; 
        "twrp")
            clear
            echo "----------------------------------------------"
            echo "Started Building TWRP-3.3.1-0 for DRG , B2N & WHYRED  ."
            echo "Please be patient..."
            # twrp
            echo "----------------------------------------------"
            echo "Setting Up Tools & Stuff..."
            echo " "
            TOOLS_SETUP
	    echo " "	    
            echo "----------------------------------------------"
            echo "Setting up twrp pie source..."
            echo " "
            TWRP-P-SOURCE
	    echo " "	 
            echo "----------------------------------------------"
            echo "Setting up twrp oreo source..."
            echo " "
            DRG-TWRP-O-SOURCE
	    echo " "	 	    
            echo "----------------------------------------------"
            echo "Builds successfully completed."
            echo " "
            echo "----------------------------------------------"
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;	
        "kiwis-kernel")
            clear
            echo "----------------------------------------------"
            echo "Started Building kiwis-kernel For DRG_sprout  ."
            echo "Please be patient..."
            # kiwis-kernel
            echo "----------------------------------------------"
            echo "Setting Up Tools & Stuff..."
            echo " "
            TOOLS_SETUP
	    echo " "	    
            echo "----------------------------------------------"
            echo "Setting up twrp kiwis-kernel source..."
            echo " "
            KIWIS-SOURCE
	    echo " "    
            echo "----------------------------------------------"
            echo "kiwis-kernel Build successfully completed."
            echo " "
            echo "----------------------------------------------"
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;		    
        "evox")
            clear
            echo "----------------------------------------------"
            echo "Started Building Evolution-X For DRG_sprout  ."
            echo "Please be patient..."
            # evox
            echo "----------------------------------------------"
            echo "Setting Up Tools & Stuff..."
            echo " "
            TOOLS_SETUP
	    echo " "	    
            echo "----------------------------------------------"
            echo "Setting up Environment & source..."
            echo " "
            EVOX-SOURCE
	    echo " "
            echo "----------------------------------------------"
            echo "Evolution-X Build successfully completed."
            echo " "
            echo "----------------------------------------------"
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;		    
        "lineageos")
            clear
            echo "----------------------------------------------"
            echo "Started Building Lineageos ."
            echo "Please be patient..."
            # lineageos
            echo "----------------------------------------------"
            echo "Setting Up Tools & Stuff..."
            echo " "
            TOOLS_SETUP
	    echo " "	    
            echo "----------------------------------------------"
            echo "Setting up Environment & source..."
            echo " "
            LINEAGE-SOURCE
	    echo " "
            echo "----------------------------------------------"
            echo "Lineageos Builds successfully completed."
            echo " "
            echo "----------------------------------------------"
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;	   
	"all_roms")
            clear
            echo "----------------------------------------------"
            echo "Started Building Roms,kernels,twrps for all mentioned devices  ."
            echo "Please be patient..."
            # all_roms
            echo "----------------------------------------------"	    
            echo "Setting up Evolution-X for drg"
            echo " "	    
            EVOX-SOURCE
	    echo " "	    
            echo "----------------------------------------------"
            echo "Setting up lineage source "
            echo " "
            LINEAGE-SOURCE
	    echo " "			
            echo "----------------------------------------------"
            echo "Setting up Twrp Oreo source..."
            echo " "
            DRG-TWRP-O-SOURCE
	    echo " "
            echo "----------------------------------------------"
            echo "Setting up Twrp Pie source...."
            echo " "
            TWRP-P-SOURCE          
	    echo " "     	
            echo "----------------------------------------------"
            echo "Setting up kiwis-kernel source..."
            echo " "
            KIWIS-SOURCE
	    echo " "	    
            echo "----------------------------------------------"
            echo "builds finished."
            echo " "
            echo "----------------------------------------------"
            echo "Press any key for end the script."
            echo "----------------------------------------------"
            read -n1 -r key
            break
            ;;	    
        "Exit")
            break
            ;;
        *) echo Invalid option.;;
    esac
done  
