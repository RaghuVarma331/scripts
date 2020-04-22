#!/bin/bash


# Detail Versions

path=/mnt/raghu/jenkins/workspace/PixelExperience
securitypatch=2020-04-05


# credentials

Telegram_Api_code=$(cat $path/cred** | grep api | cut -d "=" -f 2)
chat_id=$(cat $path/cred** | grep id | cut -d "=" -f 2)
password=$(cat $path/cred** | grep sf | cut -d "=" -f 2)
gitpassword=$(cat $path/cred** | grep git | cut -d "=" -f 2)


# Init Methods

BASIC_SYNC-1()
{
    cd $path
    rm -r sync.sh
    rm -r commonsource.sh
    wget https://github.com/RaghuVarma331/scripts/raw/master/Custom-Roms/PixelExperience/sync.sh
    wget https://github.com/RaghuVarma331/scripts/raw/master/Custom-Roms/PixelExperience/commonsource.sh
} &> /dev/null


BASIC_SYNC-2()
{
    cd $path
    chmod a+x sync.sh commonsource.sh
    ./sync.sh
    ./commonsource.sh
}

BUILD_DRG-1()
{
    cd $path/pe
    rm -r out
    cd vendor/aosp/build/tasks
    rm -r kernel.mk
    wget https://github.com/PixelExperience/vendor_aosp/raw/ten/build/tasks/kernel.mk
    cd $path/pe
    git clone https://github.com/RaghuVarma331/android_device_nokia_Dragon.git -b ten device/nokia/Dragon 
    cd packages/apps/Os_Updates/src/org/pixelexperience/ota/misc
    rm -r Constants.java
    wget https://github.com/RaghuVarma331/Json-configs/raw/master/Dragon/PixelExperience/Constants.java
    cd
    cd $path/pe   
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Pixel-Experience for Nokia 6.1 Plus build started 
    
    $(date)
    
    👤 By: Raghu Varma
    build's progress at $jenkinsurl"  
}  &> /dev/null 

BUILD_DRG-2()
{
    cd $path/pe 
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch aosp_Dragon-userdebug && make target-files-package otatools
    romname=$(cat $path/pe/out/target/product/Dragon/system/build.prop | grep org.pixelexperience.version.display | cut -d "=" -f 2)
    ./build/tools/releasetools/sign_target_files_apks -o -d $path/keys $path/pe/out/target/product/Dragon/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/pe/out/target/product/Dragon/signed-target-files.zip
    ./build/tools/releasetools/ota_from_target_files -k $path/keys/releasekey $path/pe/out/target/product/Dragon/signed-target-files.zip $path/pe/out/target/product/Dragon/$romname.zip
}

BUILD_DRG-3()
{
    cd $path/pe 
    cd out/target/product/Dragon
    rm -r **.json
    wget https://github.com/RaghuVarma331/scripts/raw/master/Json_generator/drg_pe.sh
    chmod a+x drg_pe.sh
    ./drg_pe.sh
    zipname=$(echo PixelExperience**.zip)
    cat $zipname.json > $path/json/Dragon/pixel.json       
    sshpass -p $password rsync -avP -e ssh PixelExperience**.zip     raghuvarma331@frs.sourceforge.net:/home/frs/project/drg-sprout/PixelExperience
    cd 
    cd $path
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P pixel.jpg -C "
    *
    New Pixel-Experience Build is up 
    
    $(date)*
    
    ⬇️ [Download ROM](https://forum.xda-developers.com/nokia-6-1-plus/development/rom-pixel-experience-t3985853)
    ⬇️ [Download Vendor](https://forum.xda-developers.com/nokia-6-1-plus/development/vendor-drg-drgsprout-treble-gsi-vendor-t4040201)
    💬 [Device Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/nokia.txt)
    💬 [Installation procedure](https://github.com/RaghuVarma331/changelogs/raw/master/crossdevelopment/abcrins.txt)
    📱Device: *Nokia 6.1 Plus*
    ⚡Build Version: *Ten*
    ⚡Android Version: *10.0.0*
    ⚡Security Patch : *$securitypatch*
    👤 By: *Raghu Varma*
    #drg #nokia #pe #update
    Follow:  @Nokia6plusofficial ✅" 
    cd json
    git add .
    git commit -m "Dragon: PixelExperience 10.0 build $(date)"
    git push -u -f origin master
}  &> /dev/null 

BUILD_B2N-1()
{
    cd $path/pe 
    rm -r device/nokia
    rm -r out/target/product/**
    git clone https://github.com/RaghuVarma331/android_device_nokia_Onyx.git -b ten device/nokia/Onyx 
    cd packages/apps/Os_Updates/src/org/pixelexperience/ota/misc
    rm -r Constants.java
    wget https://github.com/RaghuVarma331/Json-configs/raw/master/Onyx/PixelExperience/Constants.java
    cd
    cd $path/pe    
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Pixel-Experience for Nokia 7 Plus build started 
    
    $(date)
    
    👤 By: Raghu Varma
    build's progress at $jenkinsurl"   
}  &> /dev/null 

BUILD_B2N-2()
{
    cd $path/pe 
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch aosp_Onyx-userdebug && make target-files-package otatools
    romname=$(cat $path/pe/out/target/product/Onyx/system/build.prop | grep org.pixelexperience.version.display | cut -d "=" -f 2)
    ./build/tools/releasetools/sign_target_files_apks -o -d $path/keys $path/pe/out/target/product/Onyx/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/pe/out/target/product/Onyx/signed-target-files.zip
    ./build/tools/releasetools/ota_from_target_files -k $path/keys/releasekey $path/pe/out/target/product/Onyx/signed-target-files.zip $path/pe/out/target/product/Onyx/$romname.zip
}
  
BUILD_B2N-3()
{
    cd $path/pe 
    cd out/target/product/Onyx
    rm -r **.json
    wget https://github.com/RaghuVarma331/scripts/raw/master/Json_generator/b2n_pe.sh
    chmod a+x b2n_pe.sh
    ./b2n_pe.sh
    zipname=$(echo PixelExperience**.zip)
    cat $zipname.json > $path/json/Onyx/pixel.json      
    sshpass -p $password rsync -avP -e ssh PixelExperience**.zip     raghuvarma331@frs.sourceforge.net:/home/frs/project/b2n-sprout/PixelExperience
    cd 
    cd $path
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P pixel.jpg -C "
    *
    New Pixel-Experience Build is up 
    
    $(date)*
     
    ⬇️ [Download ROM](https://forum.xda-developers.com/nokia-7-plus/development/rom-pixel-experience-t3992063)
    ⬇️ [Download Vendor](https://forum.xda-developers.com/nokia-7-plus/development/vendor-b2n-b2nsprout-treble-gsi-vendor-t4040207)
    💬 [Device Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/nokia.txt)
    💬 [Installation procedure](https://github.com/RaghuVarma331/changelogs/raw/master/crossdevelopment/abcrins.txt)
    📱Device: *Nokia 7 Plus*
    ⚡Build Version: *Ten*
    ⚡Android Version: *10.0.0*
    ⚡Security Patch : *$securitypatch*
    👤 By: *Raghu Varma*
    #b2n #nokia #pe #update
    Follow: @Nokia7plusOfficial ✅"        
    cd json
    git add .
    git commit -m "Onyx: PixelExperience 10.0 build $(date)"
    git push -u -f origin master
}  &> /dev/null 

BUILD_CTL-1()
{ 
    cd $path/pe 
    rm -r device/nokia
    rm -r out/target/product/**
    git clone https://github.com/RaghuVarma331/android_device_nokia_Crystal.git -b ten device/nokia/Crystal 
    cd packages/apps/Os_Updates/src/org/pixelexperience/ota/misc
    rm -r Constants.java
    wget https://github.com/RaghuVarma331/Json-configs/raw/master/Crystal/PixelExperience/Constants.java
    cd
    cd $path/pe    
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Pixel-Experience for Nokia 7.1 build started 
    
    $(date)
    
    👤 By: Raghu Varma
    build's progress at $jenkinsurl"      
}  &> /dev/null 

BUILD_CTL-2()
{ 
    cd $path/pe 
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch aosp_Crystal-userdebug && make target-files-package otatools
    romname=$(cat $path/pe/out/target/product/Crystal/system/build.prop | grep org.pixelexperience.version.display | cut -d "=" -f 2)
    ./build/tools/releasetools/sign_target_files_apks -o -d $path/keys $path/pe/out/target/product/Crystal/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/pe/out/target/product/Crystal/signed-target-files.zip
    ./build/tools/releasetools/ota_from_target_files -k $path/keys/releasekey $path/pe/out/target/product/Crystal/signed-target-files.zip $path/pe/out/target/product/Crystal/$romname.zip
}

BUILD_CTL-3()
{ 
    cd $path/pe 
    cd out/target/product/Crystal
    rm -r **.json
    wget https://github.com/RaghuVarma331/scripts/raw/master/Json_generator/ctl_pe.sh
    chmod a+x ctl_pe.sh
    ./ctl_pe.sh
    zipname=$(echo PixelExperience**.zip)
    cat $zipname.json > $path/json/Crystal/pixel.json     
    sshpass -p $password rsync -avP -e ssh PixelExperience**.zip     raghuvarma331@frs.sourceforge.net:/home/frs/project/ctl-sprout/PixelExperience
    cd 
    cd $path
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P pixel.jpg -C "
    *
    New Pixel-Experience Build is up 
    
    $(date)*
     
    ⬇️ [Download ROM](https://forum.xda-developers.com/nokia-7-1/development/rom-pixel-experience-t4019933)
    ⬇️ [Download Vendor](https://forum.xda-developers.com/nokia-7-1/development/vendor-ctl-ctlsprout-treble-gsi-vendor-t4040211)
    💬 [Device Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/nokia.txt)
    💬 [Installation procedure](https://github.com/RaghuVarma331/changelogs/raw/master/crossdevelopment/abcrins.txt)
    📱Device: *Nokia 7.1*
    ⚡Build Version: *Ten*
    ⚡Android Version: *10.0.0*
    ⚡Security Patch : *$securitypatch*
    👤 By: *Raghu Varma*
    #ctl #nokia #pe #update
    Follow: @nokia7161 ✅"     
    cd json
    git add .
    git commit -m "Crystal: PixelExperience 10.0 build $(date)"
    git push -u -f origin master
}  &> /dev/null 

BUILD_DDV-1()
{

    cd $path/pe 
    rm -r device/nokia
    rm -r out/target/product/**
    git clone https://github.com/RaghuVarma331/android_device_nokia_Daredevil.git -b ten device/nokia/Daredevil
    cd packages/apps/Os_Updates/src/org/pixelexperience/ota/misc
    rm -r Constants.java
    wget https://github.com/RaghuVarma331/Json-configs/raw/master/Daredevil/PixelExperience/Constants.java
    cd
    cd $path/pe
    cd vendor/aosp/build/tasks
    rm -r kernel.mk
    wget https://github.com/RaghuVarma331/prebuilt_kernels/raw/ten/PE/kernel.mk
    cd
    cd $path/pe    
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Pixel-Experience for Nokia 7.2 build started 
    
    $(date)
    
    👤 By: Raghu Varma
    build's progress at $jenkinsurl"  
}  &> /dev/null 

BUILD_DDV-2()
{
    cd $path/pe 
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch aosp_Daredevil-userdebug && make target-files-package otatools
    romname=$(cat $path/pe/out/target/product/Daredevil/system/build.prop | grep org.pixelexperience.version.display | cut -d "=" -f 2)
    ./build/tools/releasetools/sign_target_files_apks -o -d $path/keys $path/pe/out/target/product/Daredevil/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/pe/out/target/product/Daredevil/signed-target-files.zip
    ./build/tools/releasetools/ota_from_target_files -k $path/keys/releasekey $path/pe/out/target/product/Daredevil/signed-target-files.zip $path/pe/out/target/product/Daredevil/$romname.zip
}

BUILD_DDV-3()
{
    cd $path/pe 
    cd out/target/product/Daredevil
    rm -r **.json
    wget https://github.com/RaghuVarma331/scripts/raw/master/Json_generator/ddv_pe.sh
    chmod a+x ddv_pe.sh
    ./ddv_pe.sh
    zipname=$(echo PixelExperience**.zip)
    cat $zipname.json > $path/json/Daredevil/pixel.json     
    sshpass -p $password rsync -avP -e ssh PixelExperience**.zip     raghuvarma331@frs.sourceforge.net:/home/frs/project/ddv-sprout/PixelExperience
    cd 
    cd $path
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P pixel.jpg -C "
    *
    New Pixel-Experience Build is up 
    
    $(date)*
     
    ⬇️ [Download ROM](https://forum.xda-developers.com/nokia-7-2/development/rom-pixel-experience-t4077103)
    ⬇️ [Download Vendor](https://forum.xda-developers.com/nokia-7-2/development/vendor-ddv-ddvsprout-treble-gsi-vendor-t4083095)
    💬 [Device Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/nokia.txt)
    💬 [Installation procedure](https://github.com/RaghuVarma331/changelogs/raw/master/crossdevelopment/abcrins.txt)
    📱Device: *Nokia 7.2*
    ⚡Build Version: *Ten*
    ⚡Android Version: *10.0.0*
    ⚡Security Patch : *$securitypatch*
    👤 By: *Raghu Varma*
    #ddv #nokia #pe #update
    Follow: @Nokia7262 ✅"     
    cd json
    git add .
    git commit -m "Daredevil: PixelExperience 10.0 build $(date)"
    git push -u -f origin master
    cd 
    cd $path/pe
    rm -r out

}  &> /dev/null 



BASIC_SYNC-1
BASIC_SYNC-2
echo "----------------------------------------------------"
echo "Started building PixelExperience for Nokia 6.1 Plus"
echo "----------------------------------------------------" 
BUILD_DRG-1
BUILD_DRG-2
BUILD_DRG-3
echo "----------------------------------------------------"
echo " build successfully completed" 
echo "----------------------------------------------------" 

echo "----------------------------------------------------" 
echo "Started building PixelExperience for Nokia 7 Plus"
echo "----------------------------------------------------" 
BUILD_B2N-1
BUILD_B2N-2
BUILD_B2N-3
echo "----------------------------------------------------" 
echo " build successfully completed"
echo "----------------------------------------------------" 

echo "----------------------------------------------------" 
echo "Started building PixelExperience for Nokia 7.1"
echo "----------------------------------------------------" 
BUILD_CTL-1
BUILD_CTL-2
BUILD_CTL-3
echo "----------------------------------------------------"
echo " build successfully completed" 
echo "----------------------------------------------------" 

echo "----------------------------------------------------" 
echo "Started building PixelExperience for Nokia 7.2"
echo "----------------------------------------------------" 
BUILD_DDV-1
BUILD_DDV-2
BUILD_DDV-3
echo "----------------------------------------------------"
echo " build successfully completed" 
echo "----------------------------------------------------" 

