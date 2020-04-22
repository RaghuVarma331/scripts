#!/bin/bash

# Detail Versions

path=/mnt/raghu/jenkins/workspace/PixelExperience

# credentials

Telegram_Api_code=$(cat $path/cred** | grep api | cut -d "=" -f 2)
chat_id=$(cat $path/cred** | grep id | cut -d "=" -f 2)
password=$(cat $path/cred** | grep sf | cut -d "=" -f 2)
gitpassword=$(cat $path/cred** | grep git | cut -d "=" -f 2)


# Init Methods

COMMON-SOURCE()
{
    cd $path
    rm -r keys
    rm -r telegram.py
    rm -r pixel.jpg
    rm -r changelog.txt
    rm -r json
    rm -r prebuilts
    git clone https://$gitpassword@github.com/RaghuVarma331/Keys keys
    wget  https://github.com/RaghuVarma331/scripts/raw/master/pythonscripts/telegram.py
    wget https://github.com/RaghuVarma331/custom_roms_banners/raw/master/pixel.jpg
    wget https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/crossdevelopment/changelog.txt
    git clone https://$gitpassword@github.com/RaghuVarma331/Json-Tracker.git json
    git clone https://github.com/RaghuVarma331/prebuilt_kernels.git -b ten prebuilts 
    cd pe
    rm -r device/nokia
    rm -r packages/apps/Gallery2
    rm -r vendor/gapps
    rm -r packages/apps/Settings
    rm -r packages/apps/Updates
    rm -r device/custom/sepolicy   
    rm -r system/sepolicy
    git clone https://github.com/PixelExperience/system_sepolicy.git -b ten system/sepolicy
    cd system/sepolicy
    git remote add ss https://github.com/RaghuVarma331/android_system_sepolicy.git 
    git fetch ss
    git cherry-pick 242d14d7274dc8aed7ae91d77365aee25910cbf6  
    cd $path/pe
    git clone https://github.com/RaghuVarma331/android_kernel_nokia_sdm660.git -b ten-gcc --depth=1 kernel/nokia/sdm660
    git clone https://github.com/RaghuVarma331/android_vendor_nokia.git -b ten vendor/nokia
    git clone https://github.com/RaghuVarma331/vendor_nokia_Camera.git -b ten --depth=1 vendor/nokia/Camera
    git clone https://gitlab.com/RaghuVarma331/vendor_gapps.git -b ten --depth=1 vendor/gapps
    git clone https://github.com/RaghuVarma331/device_custom_sepolicy.git -b pe-ten device/custom/sepolicy
    git clone https://github.com/RaghuVarma331/android_packages_apps_Gallery2.git -b lineage-17.1 packages/apps/Gallery2
    git clone https://github.com/RaghuVarma331/Os_Updates.git -b pixel-ten packages/apps/Os_Updates          
    git clone https://github.com/LineageOS/android_packages_resources_devicesettings.git -b lineage-17.1 packages/resources/devicesettings
    git clone https://github.com/PixelExperience/packages_apps_Settings.git -b ten packages/apps/Settings    
    cd packages/apps/Settings    
    git remote add main https://github.com/RaghuVarma331/settings.git
    git fetch main
    git cherry-pick d0dede567168181d4f0035f61cf12f2996445be7
    git cherry-pick 249b4a08e10be19d20b9b25f88fcc6ee230a6614
    cd src/com/android/settings/system
    rm -r SystemUpdatePreferenceController.java
    wget https://raw.githubusercontent.com/RaghuVarma331/settings/ten/src/com/android/settings/system/SystemUpdatePreferenceController.java
    cd
    cd $path/pe 
} &> /dev/null


echo Setting up Common source..!!
COMMON-SOURCE
