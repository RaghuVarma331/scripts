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
securitypatch=2019-11-05

# Init Methods

LINEAGE-SOURCE()
{
    wget https://github.com/RaghuVarma331/scripts/raw/master/telegram.py
    wget https://github.com/RaghuVarma331/custom_roms_banners/raw/master/lineage.jpg
    mkdir los
    cd los
    echo -ne '\n' | repo init -u git://github.com/LineageOS/android.git -b lineage-16.0 --depth=1
    repo sync -c --no-tags --no-clone-bundle -f --force-sync -j16
    sed -i "/ro.control_privapp_permissions=enforce/d" vendor/lineage/config/common.mk
    git clone https://github.com/LineageOS/android_packages_resources_devicesettings.git -b lineage-16.0 packages/resources/devicesettings
    git clone https://github.com/RaghuVarma331/android_kernel_nokia_sdm660.git -b pie --depth=1 kernel/nokia/sdm660	
    git clone https://github.com/RaghuVarma331/android_device_nokia_Daredevil.git -b pie device/nokia/Daredevil
    git clone https://gitlab.com/RaghuVarma331/vendor_nokia_daredevil.git -b pie --depth=1 vendor/nokia/Daredevil

    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New LineageOS 16.0 for Nokia 7.2 build started 
    
    $(date)
    
    👤 By: Raghu Varma
    build's progress at $jenkinsurl"  
    . build/envsetup.sh && lunch lineage_Daredevil-eng && make -j32 bacon
    cd out/target/product/Daredevil
    rm -r android-info.txt  dex_bootjars obj_arm  product_copy_files_ignored.txt  symbols boot.img fake_packages ramdisk.img system build_fingerprint.txt gen ramdisk-recovery.img userdata.img build_thumbprint.txt install recovery clean_steps.mk kernel recovery.id data obj previous_build_config.mk  root vendor
    cd ..
    cp -r Daredevil /var/lib/jenkins/workspace/Raghu
    cd 
    cd /var/lib/jenkins/workspace/Raghu
    mv Daredevil darelos
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P lineage.jpg -C "
    *
    New LineageOS 16.0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-2/development/rom-lineageos-16-0-t4000487)
    
    💬 [Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/Daredevil/LineageOS.txt)
    
    📱Device: Nokia 7.2
    
    ⚡Build Version: 16.0 
    
    ⚡Android Version: 9.0.0
    
    ⚡Security Patch : $securitypatch
    
    👤 By: Raghu Varma
    
    Follow:  @Nokia7262 ✅"  
    cd los
    rm -r device/nokia
    rm -r vendor/nokia
    rm -r out/target/product/Daredevil
    git clone https://github.com/RaghuVarma331/android_device_nokia_Starlord.git -b pie device/nokia/Starlord
    git clone https://gitlab.com/RaghuVarma331/vendor_nokia_starlord.git -b pie --depth=1 vendor/nokia/Starlord
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New LineageOS 16.0 for Nokia 6.2 build started 
    
    $(date)
    
    👤 By: Raghu Varma
    build's progress at $jenkinsurl"      
    . build/envsetup.sh && lunch lineage_Starlord-eng && make -j32 bacon
    cd out/target/product/Starlord
    rm -r android-info.txt  dex_bootjars obj_arm  product_copy_files_ignored.txt  symbols boot.img fake_packages ramdisk.img system build_fingerprint.txt gen ramdisk-recovery.img userdata.img build_thumbprint.txt install recovery clean_steps.mk kernel recovery.id data obj previous_build_config.mk  root vendor
    cd ..
    cp -r Starlord /var/lib/jenkins/workspace/Raghu
    cd 
    cd /var/lib/jenkins/workspace/Raghu
    mv Starlord starlos
    rm -r los
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P lineage.jpg -C "
    *
    New LineageOS 16.0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-6-2/development/rom-lineageos-16-0-t4000797)
    
    💬 [Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/Starlord/LineageOS.txt)
    
    📱Device: Nokia 6.2
    
    ⚡Build Version: 16.0
    
    ⚡Android Version: 9.0.0
    
    ⚡Security Patch : $securitypatch
    
    👤 By: Raghu Varma
    
    Follow: @Nokia7262 ✅"  
}

PE-SOURCE()
{
    wget https://github.com/RaghuVarma331/scripts/raw/master/telegram.py
    wget https://github.com/RaghuVarma331/custom_roms_banners/raw/master/pixel.jpg
    mkdir pe
    cd pe
    echo -ne '\n' | repo init -u https://github.com/PixelExperience/manifest -b pie --depth=1
    repo sync -c --no-tags --no-clone-bundle -f --force-sync -j16
    sed -i "/ro.control_privapp_permissions=enforce/d" vendor/aosp/config/common.mk
    git clone https://github.com/LineageOS/android_packages_resources_devicesettings.git -b lineage-16.0 packages/resources/devicesettings
    git clone https://github.com/RaghuVarma331/android_kernel_nokia_sdm660.git -b pie --depth=1 kernel/nokia/sdm660	
    git clone https://github.com/RaghuVarma331/android_device_nokia_Daredevil.git -b pie device/nokia/Daredevil
    git clone https://gitlab.com/RaghuVarma331/vendor_nokia_daredevil.git -b pie --depth=1 vendor/nokia/Daredevil

    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New PixelExperience-Pie for Nokia 7.2 build started 
    
    $(date)
    
    👤 By: Raghu Varma
    build's progress at $jenkinsurl"  
    . build/envsetup.sh && lunch aosp_Daredevil-eng && make -j32 bacon
    cd out/target/product/Daredevil
    rm -r android-info.txt  dex_bootjars obj_arm  product_copy_files_ignored.txt  symbols boot.img fake_packages ramdisk.img system build_fingerprint.txt gen ramdisk-recovery.img userdata.img build_thumbprint.txt install recovery clean_steps.mk kernel recovery.id data obj previous_build_config.mk  root vendor
    cd ..
    cp -r Daredevil /var/lib/jenkins/workspace/Raghu
    cd 
    cd /var/lib/jenkins/workspace/Raghu
    mv Daredevil darepe
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P pixel.jpg -C "
    *
    New PixelExperience Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-2/development/rom-pixel-experience-t4006291)
    
    💬 [Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/Daredevil/PixelExperience.txt)
    
    📱Device: Nokia 7.2
    
    ⚡Build Version: Pie 
    
    ⚡Android Version: 9.0.0
    
    ⚡Security Patch : $securitypatch
    
    👤 By: Raghu Varma
    
    Follow:  @Nokia7262 ✅"  
    cd pe
    rm -r device/nokia
    rm -r vendor/nokia
    rm -r out/target/product/Daredevil
    git clone https://github.com/RaghuVarma331/android_device_nokia_Starlord.git -b pie device/nokia/Starlord
    git clone https://gitlab.com/RaghuVarma331/vendor_nokia_starlord.git -b pie --depth=1 vendor/nokia/Starlord
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New PixelExperience for Nokia 6.2 build started 
    
    $(date)
    
    👤 By: Raghu Varma
    build's progress at $jenkinsurl"      
    . build/envsetup.sh && lunch aosp_Starlord-eng && make -j32 bacon
    cd out/target/product/Starlord
    rm -r android-info.txt  dex_bootjars obj_arm  product_copy_files_ignored.txt  symbols boot.img fake_packages ramdisk.img system build_fingerprint.txt gen ramdisk-recovery.img userdata.img build_thumbprint.txt install recovery clean_steps.mk kernel recovery.id data obj previous_build_config.mk  root vendor
    cd ..
    cp -r Starlord /var/lib/jenkins/workspace/Raghu
    cd 
    cd /var/lib/jenkins/workspace/Raghu
    mv Starlord starpe
    rm -r pe
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P pixel.jpg -C "
    *
    New PixelExperience Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-6-2/development/rom-pixel-experience-t4006295)
    
    💬 [Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/Starlord/PixelExperience.txt)
    
    📱Device: Nokia 6.2
    
    ⚡Build Version: Pie
    
    ⚡Android Version: 9.0.0
    
    ⚡Security Patch : $securitypatch
    
    👤 By: Raghu Varma
    
    Follow: @Nokia7262 ✅"       
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
PS3='Please select your option (1-4): '
menuvar=("BasicSetup" "pe" "lineageos" "all_roms" "Exit")
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
        "pe")
            clear
            echo "----------------------------------------------"
            echo "Started Building Pixel-Experience for Nokia 7.2 & 6.2  ."
            echo "Please be patient..."
            # pe
            echo "----------------------------------------------"
            echo "Setting Up Tools & Stuff..."
            echo " "
            TOOLS_SETUP
	    echo " "	    
            echo "----------------------------------------------"
            echo "Setting up pe source..."
            echo " "
            PE-SOURCE
	    echo " "	 	    
            echo "----------------------------------------------"
            echo "Build successfully completed."
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
            echo "Started Building LineageOS 16.0 for Nokia 7.2 & 6.2  ."
            echo "Please be patient..."
            # lineageos
            echo "----------------------------------------------"
            echo "Setting Up Tools & Stuff..."
            echo " "
            TOOLS_SETUP
	    echo " "	    
            echo "----------------------------------------------"
            echo "Setting up los source..."
            echo " "
            LINEAGE-SOURCE
	    echo " "	 	    
            echo "----------------------------------------------"
            echo "Build successfully completed."
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
            echo "Started Building LineageOS 16.0 & Pixel-Exp for Nokia 7.2 & 6.2  ."
            echo "Please be patient..."
            # all_roms
            echo "----------------------------------------------"
            echo "Setting Up Tools & Stuff..."
            echo " "
            TOOLS_SETUP
	    echo " "	    
            echo "----------------------------------------------"
            echo "Setting up los source..."
            echo " "
            LINEAGE-SOURCE
	    echo " "	 	    
            echo "----------------------------------------------"
            echo "Setting up pe source..."
            echo " "
            PE-SOURCE
	    echo " "	    
            echo "----------------------------------------------"
            echo "Build successfully completed."
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
