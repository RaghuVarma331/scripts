#!/bin/bash

# Detail Versions

path=/var/lib/jenkins/workspace/LineageOS

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
    rm -r lineage.jpg
    rm -r changelog.txt
    rm -r whyred.txt
    rm -r json
    rm -r prebuilts
    git clone https://$gitpassword@github.com/RaghuVarma331/Keys keys
    wget  https://github.com/RaghuVarma331/scripts/raw/master/pythonscripts/telegram.py
    wget https://github.com/RaghuVarma331/custom_roms_banners/raw/master/lineage.jpg
    wget https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/crossdevelopment/changelog.txt
    wget https://github.com/RaghuVarma331/changelogs/raw/master/crossdevelopment/whyred.txt
    git clone https://$gitpassword@github.com/RaghuVarma331/Json-Tracker.git json
    git clone https://github.com/RaghuVarma331/prebuilt_kernels.git -b ten prebuilts
    cd los
    rm -r device/nokia
    rm -r device/lineage/sepolicy
    rm -r packages/apps/Updater    
    git clone https://github.com/RaghuVarma331/android_kernel_nokia_sdm660.git -b ten-gcc --depth=1 kernel/nokia/sdm660
    git clone https://github.com/RaghuVarma331/android_vendor_nokia.git -b ten vendor/nokia
    git clone https://github.com/RaghuVarma331/vendor_nokia_Camera.git -b ten --depth=1 vendor/nokia/Camera
    git clone https://gitlab.com/RaghuVarma331/vendor_gapps.git -b ten --depth=1 vendor/gapps
    git clone https://github.com/RaghuVarma331/device_custom_sepolicy.git -b los-ten device/lineage/sepolicy
    git clone https://github.com/RaghuVarma331/Os_Updates.git -b pixel-ten packages/apps/Os_Updates    
    git clone https://github.com/LineageOS/android_packages_resources_devicesettings.git -b lineage-17.1 packages/resources/devicesettings
    cd $path/los
} &> /dev/null


echo Setting up Common source..!!
COMMON-SOURCE
