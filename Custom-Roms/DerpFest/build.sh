#!/bin/bash


# Detail Versions

path=/mnt/raghu/jenkins/workspace/DerpFest
securitypatch=2020-05-05


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
    wget https://github.com/RaghuVarma331/scripts/raw/master/Custom-Roms/DerpFest/sync.sh
    wget https://github.com/RaghuVarma331/scripts/raw/master/Custom-Roms/DerpFest/commonsource.sh
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
    cd $path/derp    
    rm -r out
    cd vendor/aosip/build/tasks
    rm -r kernel.mk
    wget https://github.com/DerpLab/platform_vendor_aosip/raw/ten/build/tasks/kernel.mk
    cd $path/derp
    git clone https://github.com/RaghuVarma331/android_device_nokia_Dragon.git -b ten device/nokia/Dragon
    cd packages/apps/Os_Updates/src/org/pixelexperience/ota/misc
    rm -r Constants.java
    wget https://github.com/RaghuVarma331/Json-configs/raw/master/Dragon/DerpFest/Constants.java
    cd
    cd $path/derp   
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New DerpFest for Nokia 6.1 Plus build started 
    
    $(date)
    
    👤 By: Raghu Varma
    build's progress at $jenkinsurl"  
} &> /dev/null 

BUILD_DRG-2()
{
    cd $path/derp
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch derp_Dragon-userdebug && make target-files-package otatools
    romname=$(cat $path/derp/out/target/product/Dragon/system/etc/prop.default | grep ro.aosip.version | cut -d "=" -f 2)
    ./build/tools/releasetools/sign_target_files_apks -o -d $path/keys $path/derp/out/target/product/Dragon/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/derp/out/target/product/Dragon/signed-target-files.zip
    ./build/tools/releasetools/ota_from_target_files -k $path/keys/releasekey $path/derp/out/target/product/Dragon/signed-target-files.zip $path/derp/out/target/product/Dragon/DerpFest-$romname.zip
}

BUILD_DRG-3()
{
    cd $path/derp
    cd out/target/product/Dragon
    rm -r **.json
    wget https://github.com/RaghuVarma331/scripts/raw/master/Json_generator/drg_derp.sh
    chmod a+x drg_derp.sh
    ./drg_derp.sh
    zipname=$(echo DerpFest**.zip)
    cat $zipname.json > $path/json/Dragon/derp.json       
    sshpass -p $password rsync -avP -e ssh DerpFest**.zip     raghuvarma331@frs.sourceforge.net:/home/frs/project/drg-sprout/DerpFest
    cd 
    cd $path
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P derp.jpg -C "
    *
    New DerpFest Build is up 
    
    $(date)*
    
    ⬇️ [Download ROM](https://forum.xda-developers.com/nokia-6-1-plus/development/rom-aosip-derpfest-t4084447)
    ⬇️ [Download Vendor](https://forum.xda-developers.com/nokia-6-1-plus/development/vendor-drg-drgsprout-treble-gsi-vendor-t4040201)
    💬 [Device Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/nokia.txt)
    💬 [Installation procedure](https://github.com/RaghuVarma331/changelogs/raw/master/crossdevelopment/abcrins.txt)
    📱Device: *Nokia 6.1 Plus*
    ⚡Build Version: *Ten*
    ⚡Android Version: *10.0.0*
    ⚡Security Patch : *$securitypatch*
    👤 By: *@RaghuVarma*
    #drg #nokia #derp #update
    Follow:  @Nokia6plusofficial ✅" 
    cd json
    git add .
    git commit -m "Dragon: DerpFest 10.0 build $(date)"
    git push -u -f origin master
} &> /dev/null 

BUILD_B2N-1()
{
    cd $path/derp
    rm -r device/nokia
    rm -r out/target/product/**
    git clone https://github.com/RaghuVarma331/android_device_nokia_Onyx.git -b ten device/nokia/Onyx 
    cd packages/apps/Os_Updates/src/org/pixelexperience/ota/misc
    rm -r Constants.java
    wget https://github.com/RaghuVarma331/Json-configs/raw/master/Onyx/DerpFest/Constants.java
    cd
    cd $path/derp  
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New DerpFest for Nokia 7 Plus build started 
    
    $(date)
    
    👤 By: Raghu Varma
    build's progress at $jenkinsurl"   
} &> /dev/null 

BUILD_B2N-2()
{
    cd $path/derp
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch derp_Onyx-userdebug && make target-files-package otatools
    romname=$(cat $path/derp/out/target/product/Onyx/system/etc/prop.default | grep ro.aosip.version | cut -d "=" -f 2)
    ./build/tools/releasetools/sign_target_files_apks -o -d $path/keys $path/derp/out/target/product/Onyx/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/derp/out/target/product/Onyx/signed-target-files.zip
    ./build/tools/releasetools/ota_from_target_files -k $path/keys/releasekey $path/derp/out/target/product/Onyx/signed-target-files.zip $path/derp/out/target/product/Onyx/DerpFest-$romname.zip
}

BUILD_B2N-3()
{
    cd $path/derp
    cd out/target/product/Onyx
    rm -r **.json
    wget https://github.com/RaghuVarma331/scripts/raw/master/Json_generator/b2n_derp.sh
    chmod a+x b2n_derp.sh
    ./b2n_derp.sh
    zipname=$(echo DerpFest**.zip)
    cat $zipname.json > $path/json/Onyx/derp.json      
    sshpass -p $password rsync -avP -e ssh DerpFest**.zip     raghuvarma331@frs.sourceforge.net:/home/frs/project/b2n-sprout/DerpFest
    cd 
    cd $path
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P derp.jpg -C "
    *
    New DerpFest Build is up 
    
    $(date)*
     
    ⬇️ [Download ROM](https://forum.xda-developers.com/nokia-7-plus/development/rom-aosip-derpfest-t4084459)
    ⬇️ [Download Vendor](https://forum.xda-developers.com/nokia-7-plus/development/vendor-b2n-b2nsprout-treble-gsi-vendor-t4040207)
    💬 [Device Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/nokia.txt)
    💬 [Installation procedure](https://github.com/RaghuVarma331/changelogs/raw/master/crossdevelopment/abcrins.txt)
    📱Device: *Nokia 7 Plus*
    ⚡Build Version: *Ten*
    ⚡Android Version: *10.0.0*
    ⚡Security Patch : *$securitypatch*
    👤 By: *@RaghuVarma*
    #b2n #nokia #derp #update
    Follow: @Nokia7plusOfficial ✅"        
    cd json
    git add .
    git commit -m "Onyx: DerpFest 10.0 build $(date)"
    git push -u -f origin master
} &> /dev/null 

BUILD_CTL-1()
{ 
    cd $path/derp
    rm -r device/nokia
    rm -r out/target/product/**
    git clone https://github.com/RaghuVarma331/android_device_nokia_Crystal.git -b ten device/nokia/Crystal 
    cd packages/apps/Os_Updates/src/org/pixelexperience/ota/misc
    rm -r Constants.java
    wget https://github.com/RaghuVarma331/Json-configs/raw/master/Crystal/DerpFest/Constants.java
    cd
    cd $path/derp
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New DerpFest for Nokia 7.1 build started 
    
    $(date)
    
    👤 By: Raghu Varma
    build's progress at $jenkinsurl"    
} &> /dev/null 

BUILD_CTL-2()
{ 
    cd $path/derp
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch derp_Crystal-userdebug && make target-files-package otatools
    romname=$(cat $path/derp/out/target/product/Crystal/system/etc/prop.default | grep ro.aosip.version | cut -d "=" -f 2)
    ./build/tools/releasetools/sign_target_files_apks -o -d $path/keys $path/derp/out/target/product/Crystal/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/derp/out/target/product/Crystal/signed-target-files.zip
    ./build/tools/releasetools/ota_from_target_files -k $path/keys/releasekey $path/derp/out/target/product/Crystal/signed-target-files.zip $path/derp/out/target/product/Crystal/DerpFest-$romname.zip
}

BUILD_CTL-3()
{ 
    cd cd $path/derp
    cd out/target/product/Crystal
    rm -r **.json
    wget https://github.com/RaghuVarma331/scripts/raw/master/Json_generator/ctl_derp.sh
    chmod a+x ctl_derp.sh
    ./ctl_derp.sh
    zipname=$(echo DerpFest**.zip)
    cat $zipname.json > $path/json/Crystal/derp.json     
    sshpass -p $password rsync -avP -e ssh DerpFest**.zip     raghuvarma331@frs.sourceforge.net:/home/frs/project/ctl-sprout/DerpFest
    cd 
    cd $path
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P derp.jpg -C "
    *
    New DerpFest Build is up 
    
    $(date)*
     
    ⬇️ [Download ROM](https://forum.xda-developers.com/nokia-7-1/development/rom-aosip-derpfest-t4084451)
    ⬇️ [Download Vendor](https://forum.xda-developers.com/nokia-7-1/development/vendor-ctl-ctlsprout-treble-gsi-vendor-t4040211)
    💬 [Device Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/nokia.txt)
    💬 [Installation procedure](https://github.com/RaghuVarma331/changelogs/raw/master/crossdevelopment/abcrins.txt)
    📱Device: *Nokia 7.1*
    ⚡Build Version: *Ten*
    ⚡Android Version: *10.0.0*
    ⚡Security Patch : *$securitypatch*
    👤 By: *@RaghuVarma*
    #ctl #nokia #derp #update
    Follow: @nokia7161 ✅"     
    cd json
    git add .
    git commit -m "Crystal: DerpFest 10.0 build $(date)"
    git push -u -f origin master
} &> /dev/null 


BUILD_PL2-1()
{
    cd $path/derp
    rm -r device/nokia
    rm -r out/target/product/**
    git clone https://github.com/RaghuVarma331/android_device_nokia_Plate2.git -b ten device/nokia/Plate2
    cd packages/apps/Os_Updates/src/org/pixelexperience/ota/misc
    rm -r Constants.java
    wget https://github.com/RaghuVarma331/Json-configs/raw/master/Plate2/DerpFest/Constants.java
    cd
    cd $path/derp
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New DerpFest for Nokia 6.1 build started 
    
    $(date)
    
    👤 By: Raghu Varma
    build's progress at $jenkinsurl"     
} &> /dev/null 

BUILD_PL2-2()
{
 
    cd $path/derp
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch derp_Plate2-userdebug && make target-files-package otatools
    romname=$(cat $path/derp/out/target/product/Plate2/system/etc/prop.default | grep ro.aosip.version | cut -d "=" -f 2)
    ./build/tools/releasetools/sign_target_files_apks -o -d $path/keys $path/derp/out/target/product/Plate2/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/derp/out/target/product/Plate2/signed-target-files.zip
    ./build/tools/releasetools/ota_from_target_files -k $path/keys/releasekey $path/derp/out/target/product/Plate2/signed-target-files.zip $path/derp/out/target/product/Plate2/DerpFest-$romname.zip
}

BUILD_PL2-3()
{

    cd $path/derp
    cd out/target/product/Plate2
    rm -r **.json
    wget https://github.com/RaghuVarma331/scripts/raw/master/Json_generator/pl2_derp.sh
    chmod a+x pl2_derp.sh
    ./pl2_derp.sh
    zipname=$(echo DerpFest**.zip)
    cat $zipname.json > $path/json/Plate2/derp.json     
    sshpass -p $password rsync -avP -e ssh DerpFest**.zip     raghuvarma331@frs.sourceforge.net:/home/frs/project/pl2-sprout/DerpFest
    cd 
    cd $path
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P derp.jpg -C "
    *
    New DerpFest Build is up 
    
    $(date)*
     
    ⬇️ [Download ROM](https://forum.xda-developers.com/nokia-6-2018/development/rom-aosip-derpfest-t4084463)
    ⬇️ [Download Vendor](https://forum.xda-developers.com/nokia-6-2018/development/vendor-pl2-pl2sprout-treble-gsi-vendor-t4040213)
    💬 [Device Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/nokia.txt)
    💬 [Installation procedure](https://github.com/RaghuVarma331/changelogs/raw/master/crossdevelopment/abcrins.txt)
    📱Device: *Nokia 6.1*
    ⚡Build Version: *Ten*
    ⚡Android Version: *10.0.0*
    ⚡Security Patch : *$securitypatch*
    👤 By: *@RaghuVarma*
    #pl2 #nokia #derp #update
    Follow: @nokia7161 ✅"     
    cd json
    git add .
    git commit -m "Plate2: DerpFest 10.0 build $(date)"
    git push -u -f origin master
} &> /dev/null 

BUILD_DDV-1()
{
    cd $path/derp
    rm -r device/nokia
    rm -r out/target/product/**
    git clone https://github.com/RaghuVarma331/android_device_nokia_Daredevil.git -b ten device/nokia/Daredevil
    cd packages/apps/Os_Updates/src/org/pixelexperience/ota/misc
    rm -r Constants.java
    wget https://github.com/RaghuVarma331/Json-configs/raw/master/Daredevil/DerpFest/Constants.java
    cd
    cd $path/derp
    cd vendor/aosip/build/tasks
    rm -r kernel.mk
    wget https://github.com/RaghuVarma331/prebuilt_kernels/raw/ten/DERP/kernel.mk
    cd
    cd $path/derp    
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New DerpFest for Nokia 7.2 build started 
    
    $(date)
    
    👤 By: Raghu Varma
    build's progress at $jenkinsurl"      
} &> /dev/null 

BUILD_DDV-2()
{
    cd $path/derp
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch derp_Daredevil-userdebug && make target-files-package otatools
    romname=$(cat $path/derp/out/target/product/Daredevil/system/etc/prop.default | grep ro.aosip.version | cut -d "=" -f 2)
    ./build/tools/releasetools/sign_target_files_apks -o -d $path/keys $path/derp/out/target/product/Daredevil/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/derp/out/target/product/Daredevil/signed-target-files.zip
    ./build/tools/releasetools/ota_from_target_files -k $path/keys/releasekey $path/derp/out/target/product/Daredevil/signed-target-files.zip $path/derp/out/target/product/Daredevil/DerpFest-$romname.zip
 
}

BUILD_DDV-3()
{
    $path/derp
    cd out/target/product/Daredevil
    rm -r **.json
    wget https://github.com/RaghuVarma331/scripts/raw/master/Json_generator/ddv_derp.sh
    chmod a+x ddv_derp.sh
    ./ddv_derp.sh
    zipname=$(echo DerpFest**.zip)
    cat $zipname.json > $path/json/Daredevil/derp.json     
    sshpass -p $password rsync -avP -e ssh DerpFest**.zip     raghuvarma331@frs.sourceforge.net:/home/frs/project/ddv-sprout/DerpFest
    cd 
    cd $path
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P derp.jpg -C "
    *
    New DerpFest Build is up 
    
    $(date)*
     
    ⬇️ [Download ROM](https://forum.xda-developers.com/nokia-7-2/development/rom-aosip-derpfest-t4084471)
    ⬇️ [Download Vendor](https://forum.xda-developers.com/nokia-7-2/development/vendor-ddv-ddvsprout-treble-gsi-vendor-t4083095)
    💬 [Device Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/nokia.txt)
    💬 [Installation procedure](https://github.com/RaghuVarma331/changelogs/raw/master/crossdevelopment/abcrins.txt)
    📱Device: *Nokia 7.2*
    ⚡Build Version: *Ten*
    ⚡Android Version: *10.0.0*
    ⚡Security Patch : *$securitypatch*
    👤 By: *@RaghuVarma*
    #ddv #nokia #derp #update
    Follow: @Nokia7262 ✅"     
    cd json
    git add .
    git commit -m "Daredevil: DerpFest 10.0 build $(date)"
    git push -u -f origin master
    cd 
    cd $path/derp
    rm -r out
} &> /dev/null 

BASIC_SYNC-1
BASIC_SYNC-2
echo "----------------------------------------------------"
echo "Started building DerpFest for Nokia 6.1 Plus"
echo "----------------------------------------------------" 
BUILD_DRG-1
BUILD_DRG-2
BUILD_DRG-3
echo "----------------------------------------------------"
echo " build successfully completed" 
echo "----------------------------------------------------" 

echo "----------------------------------------------------" 
echo "Started building DerpFest for Nokia 7 Plus"
echo "----------------------------------------------------" 
BUILD_B2N-1
BUILD_B2N-2
BUILD_B2N-3
echo "----------------------------------------------------" 
echo " build successfully completed"
echo "----------------------------------------------------" 

echo "----------------------------------------------------" 
echo "Started building DerpFest for Nokia 7.1"
echo "----------------------------------------------------" 
BUILD_CTL-1
BUILD_CTL-2
BUILD_CTL-3
echo "----------------------------------------------------"
echo " build successfully completed" 
echo "----------------------------------------------------" 

echo "----------------------------------------------------" 
echo "Started building DerpFest for Nokia 6.1"
echo "----------------------------------------------------" 
BUILD_PL2-1
BUILD_PL2-2
BUILD_PL2-3
echo "----------------------------------------------------"
echo " build successfully completed" 
echo "----------------------------------------------------" 

echo "----------------------------------------------------" 
echo "Started building DerpFest for Nokia 7.2"
echo "----------------------------------------------------" 
BUILD_DDV-1
BUILD_DDV-2
BUILD_DDV-3
echo "----------------------------------------------------"
echo " build successfully completed" 
echo "----------------------------------------------------"  
