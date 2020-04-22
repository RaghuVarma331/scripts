#!/bin/bash


# Detail Versions

path=/var/lib/jenkins/workspace/LineageOS
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
    wget https://github.com/RaghuVarma331/scripts/raw/master/Custom-Roms/LineageOS/sync.sh
    wget https://github.com/RaghuVarma331/scripts/raw/master/Custom-Roms/LineageOS/commonsource.sh
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

    cd $path/los
    rm -r out
    cd vendor/lineage/build/tasks
    rm -r kernel.mk
    wget https://github.com/LineageOS/android_vendor_lineage/raw/lineage-17.1/build/tasks/kernel.mk
    cd $path/los
    rm -r device/xiaomi/whyred
    rm -r kernel/xiaomi/whyred
    rm -r vendor/xiaomi/whyred
    git clone https://github.com/RaghuVarma331/android_device_nokia_Dragon.git -b ten device/nokia/Dragon 
    cd packages/apps/Os_Updates/src/org/pixelexperience/ota/misc
    rm -r Constants.java
    wget https://github.com/RaghuVarma331/Json-configs/raw/master/Dragon/LineageOS/Constants.java
    cd
    cd $path/los
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New LineageOS 17.1 for Nokia 6.1 Plus build started 
    
    $(date)
    
    👤 By: Raghu Varma
    build's progress at $jenkinsurl"  
} &> /dev/null

BUILD_DRG-2()
{
    cd $path/los
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch lineage_Dragon-userdebug && make target-files-package otatools
    romname=$(cat $path/los/out/target/product/Dragon/system/build.prop | grep ro.lineage.version | cut -d "=" -f 2)
    ./build/tools/releasetools/sign_target_files_apks -o -d $path/keys $path/los/out/target/product/Dragon/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/los/out/target/product/Dragon/signed-target-files.zip
    ./build/tools/releasetools/ota_from_target_files -k $path/keys/releasekey $path/los/out/target/product/Dragon/signed-target-files.zip $path/los/out/target/product/Dragon/lineage-$romname.zip
}

BUILD_DRG-3()
{

    cd $path/los
    cd out/target/product/Dragon
    rm -r **.json
    wget https://github.com/RaghuVarma331/scripts/raw/master/Json_generator/drg_lineage.sh
    chmod a+x drg_lineage.sh
    ./drg_lineage.sh
    zipname=$(echo lineage-17.1**.zip)
    cat $zipname.json > $path/json/Dragon/lineage.json    
    sshpass -p $password rsync -avP -e ssh lineage-17.1**.zip     raghuvarma331@frs.sourceforge.net:/home/frs/project/drg-sprout/LineageOS
    cd 
    cd $path
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P lineage.jpg -C "
    *
    New LineageOS 17.1 Build is up 
    
    $(date)*
    
    ⬇️ [Download Rom](https://forum.xda-developers.com/nokia-6-1-plus/development/beta-lineageos-17-0-t3985367)
    ⬇️ [Download Vendor](https://forum.xda-developers.com/nokia-6-1-plus/development/vendor-drg-drgsprout-treble-gsi-vendor-t4040201)
    💬 [Device Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/nokia.txt)
    💬 [Installation procedure](https://github.com/RaghuVarma331/changelogs/raw/master/crossdevelopment/abcrins.txt)
    📱Device: *Nokia 6.1 Plus*
    ⚡Build Version: *17.1* 
    ⚡Android Version: *10.0.0*
    ⚡Security Patch : *$securitypatch*
    👤 By: *Raghu Varma*
    #drg #nokia #los #update
    Follow:  @Nokia6plusofficial ✅"  
    cd json
    git add .
    git commit -m "Dragon: LineageOS 17.1 build $(date)"
    git push -u -f origin master

} &> /dev/null


BUILD_B2N-1()
{
    cd $path/los
    rm -r device/nokia
    rm -r out/target/product/**
    git clone https://github.com/RaghuVarma331/android_device_nokia_Onyx.git -b ten device/nokia/Onyx   
    cd packages/apps/Os_Updates/src/org/pixelexperience/ota/misc
    rm -r Constants.java
    wget https://github.com/RaghuVarma331/Json-configs/raw/master/Onyx/LineageOS/Constants.java
    cd
    cd $path/los    
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New LineageOS 17.1 for Nokia 7 Plus build started 
    
    $(date)
    
    👤 By: Raghu Varma
    build's progress at $jenkinsurl"      
} &> /dev/null

BUILD_B2N-2()
{
    cd $path/los
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch lineage_Onyx-userdebug && make target-files-package otatools
    romname=$(cat $path/los/out/target/product/Onyx/system/build.prop | grep ro.lineage.version | cut -d "=" -f 2)
    ./build/tools/releasetools/sign_target_files_apks -o -d $path/keys $path/los/out/target/product/Onyx/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/los/out/target/product/Onyx/signed-target-files.zip
    ./build/tools/releasetools/ota_from_target_files -k $path/keys/releasekey $path/los/out/target/product/Onyx/signed-target-files.zip $path/los/out/target/product/Onyx/lineage-$romname.zip
}

BUILD_B2N-3()
{

    cd $path/los
    cd out/target/product/Onyx
    rm -r **.json      
    wget https://github.com/RaghuVarma331/scripts/raw/master/Json_generator/b2n_lineage.sh
    chmod a+x b2n_lineage.sh
    ./b2n_lineage.sh
    zipname=$(echo lineage-17.1**.zip)
    cat $zipname.json > $path/json/Onyx/lineage.json        
    sshpass -p $password rsync -avP -e ssh lineage-17.1**.zip     raghuvarma331@frs.sourceforge.net:/home/frs/project/b2n-sprout/LineageOS
    cd 
    cd $path
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P lineage.jpg -C "
    *
    New LineageOS 17.1 Build is up 
    
    $(date)*
    
    ⬇️ [Download ROM](https://forum.xda-developers.com/nokia-7-plus/development/rom-lineageos-17-0-t3993445)
    ⬇️ [Download Vendor](https://forum.xda-developers.com/nokia-7-plus/development/vendor-b2n-b2nsprout-treble-gsi-vendor-t4040207)
    💬 [Device Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/nokia.txt)
    💬 [Installation procedure](https://github.com/RaghuVarma331/changelogs/raw/master/crossdevelopment/abcrins.txt)
    📱Device: *Nokia 7 Plus*
    ⚡Build Version: *17.1*
    ⚡Android Version: *10.0.0*
    ⚡Security Patch : *$securitypatch*
    👤 By: *Raghu Varma*
    #b2n #nokia #los #update
    Follow: @Nokia7plusOfficial ✅"    
    cd json
    git add .
    git commit -m "Onyx: LineageOS 17.1 build $(date)"
    git push -u -f origin master
} &> /dev/null

BUILD_CTL-1()
{

    cd $path/los
    rm -r device/nokia
    rm -r out/target/product/**
    git clone https://github.com/RaghuVarma331/android_device_nokia_Crystal.git -b ten device/nokia/Crystal   
    cd packages/apps/Os_Updates/src/org/pixelexperience/ota/misc
    rm -r Constants.java
    wget https://github.com/RaghuVarma331/Json-configs/raw/master/Crystal/LineageOS/Constants.java
    cd
    cd $path/los    
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New LineageOS 17.1 for Nokia 7.1 build started 
    
    $(date)
    
    👤 By: Raghu Varma
    build's progress at $jenkinsurl"    
} &> /dev/null

BUILD_CTL-2()
{
    cd $path/los
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch lineage_Crystal-userdebug && make target-files-package otatools
    romname=$(cat $path/los/out/target/product/Crystal/system/build.prop | grep ro.lineage.version | cut -d "=" -f 2)
    ./build/tools/releasetools/sign_target_files_apks -o -d $path/keys $path/los/out/target/product/Crystal/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/los/out/target/product/Crystal/signed-target-files.zip
    ./build/tools/releasetools/ota_from_target_files -k $path/keys/releasekey $path/los/out/target/product/Crystal/signed-target-files.zip $path/los/out/target/product/Crystal/lineage-$romname.zip
}


BUILD_CTL-3()
{
    cd $path/los
    cd out/target/product/Crystal
    rm -r **.json
    wget https://github.com/RaghuVarma331/scripts/raw/master/Json_generator/ctl_lineage.sh
    chmod a+x ctl_lineage.sh
    ./ctl_lineage.sh
    zipname=$(echo lineage-17.1**.zip)
    cat $zipname.json > $path/json/Crystal/lineage.json      
    sshpass -p $password rsync -avP -e ssh lineage-17.1**.zip     raghuvarma331@frs.sourceforge.net:/home/frs/project/ctl-sprout/LineageOS
    cd 
    cd $path
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P lineage.jpg -C "
    *
    New LineageOS 17.1 Build is up 
    
    $(date)*
    
    ⬇️ [Download ROM](https://forum.xda-developers.com/nokia-7-1/development/rom-lineageos-17-0-t4019915)
    ⬇️ [Download Vendor](https://forum.xda-developers.com/nokia-7-1/development/vendor-ctl-ctlsprout-treble-gsi-vendor-t4040211)
    💬 [Device Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/nokia.txt)
    💬 [Installation procedure](https://github.com/RaghuVarma331/changelogs/raw/master/crossdevelopment/abcrins.txt)
    📱Device: *Nokia 7.1*
    ⚡Build Version: *17.1*
    ⚡Android Version: *10.0.0*
    ⚡Security Patch : *$securitypatch*
    👤 By: *Raghu Varma*
    #ctl #nokia #los #update
    Follow: @nokia7161  ✅"     
    cd json
    git add .
    git commit -m "Crystal: LineageOS 17.1 build $(date)"
    git push -u -f origin master
} &> /dev/null

BUILD_DDV-1()
{
    cd $path/los
    rm -r device/nokia
    rm -r out/target/product/**
    git clone https://github.com/RaghuVarma331/android_device_nokia_Daredevil.git -b ten device/nokia/Daredevil 
    cd packages/apps/Os_Updates/src/org/pixelexperience/ota/misc
    rm -r Constants.java
    wget https://github.com/RaghuVarma331/Json-configs/raw/master/Daredevil/LineageOS/Constants.java
    cd
    cd $path/los
    cd vendor/lineage/build/tasks
    rm -r kernel.mk
    wget https://github.com/RaghuVarma331/prebuilt_kernels/raw/ten/LOS/kernel.mk
    cd
    cd $path/los    
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New LineageOS 17.1 for Nokia 7.2 build started 
    
    $(date)
    
    👤 By: Raghu Varma
    build's progress at $jenkinsurl"     
} &> /dev/null

BUILD_DDV-2()
{
    cd $path/los
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch lineage_Daredevil-userdebug && make target-files-package otatools
    romname=$(cat $path/los/out/target/product/Daredevil/system/build.prop | grep ro.lineage.version | cut -d "=" -f 2)
    ./build/tools/releasetools/sign_target_files_apks -o -d $path/keys $path/los/out/target/product/Daredevil/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/los/out/target/product/Daredevil/signed-target-files.zip
    ./build/tools/releasetools/ota_from_target_files -k $path/keys/releasekey $path/los/out/target/product/Daredevil/signed-target-files.zip $path/los/out/target/product/Daredevil/lineage-$romname.zip
}

BUILD_DDV-3()
{
    cd $path/los
    cd out/target/product/Daredevil
    rm -r **.json
    wget https://github.com/RaghuVarma331/scripts/raw/master/Json_generator/ddv_lineage.sh
    chmod a+x ddv_lineage.sh
    ./ddv_lineage.sh
    zipname=$(echo lineage-17.1**.zip)
    cat $zipname.json > $path/json/Daredevil/lineage.json      
    sshpass -p $password rsync -avP -e ssh lineage-17.1**.zip     raghuvarma331@frs.sourceforge.net:/home/frs/project/ddv-sprout/LineageOS
    cd 
    cd $path
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P lineage.jpg -C "
    *
    New LineageOS 17.1 Build is up 
    
    $(date)*
    
    ⬇️ [Download ROM](https://forum.xda-developers.com/nokia-7-2/development/rom-lineageos-17-0-t4001281)
    ⬇️ [Download Vendor](https://forum.xda-developers.com/nokia-7-2/development/vendor-ddv-ddvsprout-treble-gsi-vendor-t4083095)
    💬 [Device Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/nokia.txt)
    💬 [Installation procedure](https://github.com/RaghuVarma331/changelogs/raw/master/crossdevelopment/abcrins.txt)
    📱Device: *Nokia 7.2*
    ⚡Build Version: *17.1*
    ⚡Android Version: *10.0.0*
    ⚡Security Patch : *$securitypatch*
    👤 By: *Raghu Varma*
    #ddv #nokia #los #update
    Follow: @Nokia7262  ✅"     
    cd json
    git add .
    git commit -m "Daredevil: LineageOS 17.1 build $(date)"
    git push -u -f origin master
} &> /dev/null


BUILD_WHY-1()
{
    cd $path/los
    rm -r device/nokia
    rm -r kernel/nokia
    rm -r vendor/nokia 
    rm -r vendor/gapps
    rm -r out/target/product/**
    rm -r device/lineage/sepolicy
    git clone https://github.com/LineageOS/android_device_lineage_sepolicy.git -b lineage-17.1 device/lineage/sepolicy
    cd device/lineage/sepolicy
    git remote add ls https://github.com/RaghuVarma331/device_custom_sepolicy
    git fetch ls
    git cherry-pick 126467d47adbcca911ac54957c89dcfd5d3b0f50
    cd $path/los
    git clone https://github.com/RaghuVarma331/android_device_xiaomi_whyred.git -b lineage-17.1 device/xiaomi/whyred
    git clone https://github.com/RaghuVarma331/android_kernel_xiaomi_whyred.git -b lineage-17.1 --depth=1 kernel/xiaomi/whyred
    git clone https://github.com/RaghuVarma331/vendor_xiaomi_whyred.git -b lineage-17.1 vendor/xiaomi/whyred
    cd packages/apps/Os_Updates/src/org/pixelexperience/ota/misc
    rm -r Constants.java
    wget https://raw.githubusercontent.com/RaghuVarma331/Json-configs/master/whyred/LineageOS/Constants.java
    cd
    cd $path/los
    cd vendor/lineage/build/tasks
    rm -r kernel.mk
    wget https://github.com/LineageOS/android_vendor_lineage/raw/lineage-17.1/build/tasks/kernel.mk
    cd
    cd $path/los          
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New LineageOS 17.1 for Redmi Note 5 Pro build started 
    
    $(date)
    
    👤 By: Raghu Varma
    build's progress at $jenkinsurl"   
} &> /dev/null

BUILD_WHY-2()
{
    cd $path/los
    . build/envsetup.sh && lunch lineage_whyred-userdebug && make target-files-package otatools
    romname=$(cat $path/los/out/target/product/whyred/system/build.prop | grep ro.lineage.version | cut -d "=" -f 2)
    ./build/tools/releasetools/sign_target_files_apks -o -d $path/keys $path/los/out/target/product/whyred/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip $path/los/out/target/product/whyred/signed-target-files.zip
    ./build/tools/releasetools/ota_from_target_files -k $path/keys/releasekey $path/los/out/target/product/whyred/signed-target-files.zip $path/los/out/target/product/whyred/lineage-$romname.zip
}

BUILD_WHY-3()
{
    cd $path/los
    cd out/target/product/whyred
    rm -r **.json  
    wget https://github.com/RaghuVarma331/scripts/raw/master/Json_generator/whyred_lineage.sh
    chmod a+x whyred_lineage.sh
    ./whyred_lineage.sh
    zipname=$(echo lineage-17.1**.zip)
    cat $zipname.json > $path/json/whyred/lineage.json       
    sshpass -p $password rsync -avP -e ssh lineage-17.1**.zip     raghuvarma331@frs.sourceforge.net:/home/frs/project/whyred-rv/LineageOS
    cd 
    cd $path
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P lineage.jpg -C "
    *
    New LineageOS 17.1 Build is up 
    
    $(date)*
    
    ⬇️ [Download ROM](https://forum.xda-developers.com/redmi-note-5-pro/development/rom-lineageos-16-0-t3882431)
    💬 [Device Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/whyred.txt)
    📱Device: *Redmi Note 5 Pro*
    ⚡Build Version: *17.1*
    ⚡Android Version: *10.0.0*
    ⚡Security Patch : *$securitypatch*
    👤 By: *Raghu Varma*
    #whyred #nokia #los #update
    Follow: @whyredrn5pro ✅"      
    cd json
    git add .
    git commit -m "Whyred: LineageOS 17.1 build $(date)"
    git push -u -f origin master
    cd $path/los
    rm -r out
} &> /dev/null 
 


BASIC_SYNC-1
BASIC_SYNC-2
echo "----------------------------------------------------"
echo "Started building LineageOS for Nokia 6.1 Plus"
echo "----------------------------------------------------" 
BUILD_DRG-1
BUILD_DRG-2
BUILD_DRG-3
echo "----------------------------------------------------"
echo " build successfully completed" 
echo "----------------------------------------------------" 

echo "----------------------------------------------------" 
echo "Started building LineageOS for Nokia 7 Plus"
echo "----------------------------------------------------" 
BUILD_B2N-1
BUILD_B2N-2
BUILD_B2N-3
echo "----------------------------------------------------" 
echo " build successfully completed"
echo "----------------------------------------------------" 

echo "----------------------------------------------------" 
echo "Started building LineageOS for Nokia 7.1"
echo "----------------------------------------------------" 
BUILD_CTL-1
BUILD_CTL-2
BUILD_CTL-3
echo "----------------------------------------------------"
echo " build successfully completed" 
echo "----------------------------------------------------" 

echo "----------------------------------------------------" 
echo "Started building LineageOS for Nokia 7.2"
echo "----------------------------------------------------" 
BUILD_DDV-1
BUILD_DDV-2
BUILD_DDV-3
echo "----------------------------------------------------"
echo " build successfully completed" 
echo "----------------------------------------------------" 

echo "----------------------------------------------------"
echo "Started building LineageOS for Redmi note 5 pro"
echo "----------------------------------------------------"
BUILD_WHY-1
BUILD_WHY-2
BUILD_WHY-3
echo "----------------------------------------------------"
echo " build successfully completed" 
echo "----------------------------------------------------" 
