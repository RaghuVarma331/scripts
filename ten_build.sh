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
securitypatch=2019-12-05
twrpsp='2019-12-05'
evoxversion=3.5
havocversion=3.0
oxversion=v-3
password=
gitpassword=username:password
path=/var/lib/jenkins/workspace/Raghu

# Init Methods

LINEAGE-SOURCE()
{
    wget https://github.com/RaghuVarma331/scripts/raw/master/telegram.py
    wget https://github.com/RaghuVarma331/custom_roms_banners/raw/master/lineage.jpg
    git clone https://$gitpassword@github.com/RaghuVarma331/changelogs.git changelog
    mkdir los
    cd los
    echo -ne '\n' | repo init -u git://github.com/LineageOS/android.git -b lineage-17.0 --depth=1
    repo sync -c --no-tags --no-clone-bundle -f --force-sync -j16
    sed -i "/ro.control_privapp_permissions=enforce/d" vendor/lineage/config/common.mk
    git clone https://github.com/LineageOS/android_packages_resources_devicesettings.git -b lineage-17.0 packages/resources/devicesettings
    git clone https://github.com/RaghuVarma331/android_kernel_nokia_sdm660.git -b ten --depth=1 kernel/nokia/sdm660
    git clone https://gitlab.com/RaghuVarma331/vendor_nokia.git -b ten --depth=1 vendor/nokia
    git clone https://github.com/RaghuVarma331/android_device_nokia_Dragon.git -b ten device/nokia/Dragon
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New LineageOS 17.0 for Nokia 6.1 Plus build started 
    
    $(date)
    
    👤 By: Raghu Varma

    build's progress at $jenkinsurl"  
    . build/envsetup.sh && lunch lineage_Dragon-eng && make -j32 bacon
    cd out/target/product/Dragon
    Changelog=lineage-17.0-Dragon.txt


    echo "Generating changelog..."

    for i in $(seq 14);
    do
    export After_Date=`date --date="$i days ago" +%Y/%m/%d`
    k=$(expr $i - 1)
    export Until_Date=`date --date="$k days ago" +%Y/%m/%d`

    # Line with after --- until was too long for a small ListView
    echo '=======================' >> $Changelog;
    echo  "     "$Until_Date       >> $Changelog;
    echo '=======================' >> $Changelog;
    echo >> $Changelog;

    # Cycle through every repo to find commits between 2 dates
    repo forall -pc 'git log --oneline --after=$After_Date --until=$Until_Date' >> $Changelog
    echo >> $Changelog;
    done
    cat lineage-17.0**.txt > $path/changelog/Dragon/LineageOS.txt
    sshpass -p $password rsync -avP -e ssh lineage-17.0**.zip     raghuvarma331@frs.sourceforge.net:/home/frs/project/drg-sprout/LineageOS
    cd 
    cd $path
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P lineage.jpg -C "
    *
    New LineageOS 17.0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-6-1-plus/development/beta-lineageos-17-0-t3985367)
    
    💬 [Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/Dragon/LineageOS.txt)
    
    📱Device: Nokia 6.1 Plus
    
    ⚡Build Version: 17.0 
    
    ⚡Android Version: 10.0.0
    
    ⚡Security Patch : $securitypatch
    
    👤 By: Raghu Varma
    
    Follow:  @Nokia6plusofficial ✅"  
    cd changelog
    git add .
    git commit -m "build $(date)"
    git push -u -f origin master
    cd ..
    cd los
    rm -r device/nokia
    rm -r out/target/product/Dragon
    git clone https://github.com/RaghuVarma331/android_device_nokia_Onyx.git -b ten device/nokia/Onyx
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New LineageOS 17.0 for Nokia 7 Plus build started 
    
    $(date)
    
    👤 By: Raghu Varma

    build's progress at $jenkinsurl"      
    . build/envsetup.sh && lunch lineage_Onyx-eng && make -j32 bacon
    cd out/target/product/Onyx
    Changelog=lineage-17.0-Onyx.txt


    echo "Generating changelog..."

    for i in $(seq 14);
    do
    export After_Date=`date --date="$i days ago" +%Y/%m/%d`
    k=$(expr $i - 1)
    export Until_Date=`date --date="$k days ago" +%Y/%m/%d`

    # Line with after --- until was too long for a small ListView
    echo '=======================' >> $Changelog;
    echo  "     "$Until_Date       >> $Changelog;
    echo '=======================' >> $Changelog;
    echo >> $Changelog;

    # Cycle through every repo to find commits between 2 dates
    repo forall -pc 'git log --oneline --after=$After_Date --until=$Until_Date' >> $Changelog
    echo >> $Changelog;
    done    
    cat lineage-17.0**.txt > $path/changelog/Onyx/LineageOS.txt
    sshpass -p $password rsync -avP -e ssh lineage-17.0**.zip     raghuvarma331@frs.sourceforge.net:/home/frs/project/b2n-sprout/LineageOS
    cd 
    cd $path
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P lineage.jpg -C "
    *
    New LineageOS 17.0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-plus/development/rom-lineageos-17-0-t3993445)
    
    💬 [Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/Onyx/LineageOS.txt)
    
    📱Device: Nokia 7 Plus
    
    ⚡Build Version: 17.0
    
    ⚡Android Version: 10.0.0
    
    ⚡Security Patch : $securitypatch
    
    👤 By: Raghu Varma
    
    Follow: @Nokia7plusOfficial ✅"  
    cd changelog
    git add .
    git commit -m "build $(date)"
    git push -u -f origin master
    cd ..    
    cd los
    rm -r device/nokia
    rm -r out/target/product/Onyx
    git clone https://github.com/RaghuVarma331/android_device_nokia_Crystal.git -b ten device/nokia/Crystal
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New LineageOS 17.0 for Nokia 7.1 build started 
    
    $(date)
    
    👤 By: Raghu Varma

    build's progress at $jenkinsurl"      
    . build/envsetup.sh && lunch lineage_Crystal-eng && make -j32 bacon
    cd out/target/product/Crystal
    Changelog=lineage-17.0-Crystal.txt


    echo "Generating changelog..."

    for i in $(seq 14);
    do
    export After_Date=`date --date="$i days ago" +%Y/%m/%d`
    k=$(expr $i - 1)
    export Until_Date=`date --date="$k days ago" +%Y/%m/%d`

    # Line with after --- until was too long for a small ListView
    echo '=======================' >> $Changelog;
    echo  "     "$Until_Date       >> $Changelog;
    echo '=======================' >> $Changelog;
    echo >> $Changelog;

    # Cycle through every repo to find commits between 2 dates
    repo forall -pc 'git log --oneline --after=$After_Date --until=$Until_Date' >> $Changelog
    echo >> $Changelog;
    done    
    cat lineage-17.0**.txt > $path/changelog/Crystal/LineageOS.txt
    sshpass -p $password rsync -avP -e ssh lineage-17.0**.zip     raghuvarma331@frs.sourceforge.net:/home/frs/project/ctl-sprout/LineageOS
    cd 
    cd $path
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P lineage.jpg -C "
    *
    New LineageOS 17.0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-1/development/rom-lineageos-17-0-t4019915)
    
    💬 [Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/Crystal/LineageOS.txt)
    
    📱Device: Nokia 7.1
    
    ⚡Build Version: 17.0
    
    ⚡Android Version: 10.0.0
    
    ⚡Security Patch : $securitypatch
    
    👤 By: Raghu Varma
    
    Follow: @nokia7161  ✅"    
    cd changelog
    git add .
    git commit -m "build $(date)"
    git push -u -f origin master
    cd ..    
    cd los
    rm -r device/nokia
    rm -r kernel/nokia
    rm -r vendor/nokia
    rm -r out/target/product/Crystal
    git clone https://github.com/RaghuVarma331/android_device_xiaomi_whyred.git -b lineage-17.0 device/xiaomi/whyred
    git clone https://github.com/RaghuVarma331/android_kernel_xiaomi_whyred.git -b ten --depth=1 kernel/xiaomi/whyred
    git clone https://github.com/RaghuVarma331/vendor_MiuiCamera.git -b ten vendor/MiuiCamera
    git clone https://github.com/RaghuVarma331/vendor_xiaomi_whyred.git -b ten vendor/xiaomi/whyred
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New LineageOS 17.0 for Redmi Note 5 Pro build started 
    
    $(date)
    
    👤 By: Raghu Varma
    build's progress at $jenkinsurl"    
    . build/envsetup.sh && lunch lineage_whyred-eng && make -j32 bacon
    cd out/target/product/whyred
    Changelog=lineage-17.0-whyred.txt


    echo "Generating changelog..."

    for i in $(seq 14);
    do
    export After_Date=`date --date="$i days ago" +%Y/%m/%d`
    k=$(expr $i - 1)
    export Until_Date=`date --date="$k days ago" +%Y/%m/%d`

    # Line with after --- until was too long for a small ListView
    echo '=======================' >> $Changelog;
    echo  "     "$Until_Date       >> $Changelog;
    echo '=======================' >> $Changelog;
    echo >> $Changelog;

    # Cycle through every repo to find commits between 2 dates
    repo forall -pc 'git log --oneline --after=$After_Date --until=$Until_Date' >> $Changelog
    echo >> $Changelog;
    done    
    cat lineage-17.0**.txt > $path/changelog/whyred/LineageOS.txt
    sshpass -p $password rsync -avP -e ssh lineage-17.0**.zip     raghuvarma331@frs.sourceforge.net:/home/frs/project/whyred-rv/LineageOS
    cd 
    cd $path
    rm -r los
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P lineage.jpg -C "
    *
    New LineageOS 17.0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/redmi-note-5-pro/development/rom-lineageos-16-0-t3882431)
    
    💬 [Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/whyred/LineageOS.txt)
    
    📱Device: Redmi Note 5 Pro
    
    ⚡Build Version: 17.0
    
    ⚡Android Version: 10.0.0
    
    ⚡Security Patch : $securitypatch
    
    👤 By: Raghu Varma
    
    Follow: @Nokia7plusOfficial ✅"    
    cd changelog
    git add .
    git commit -m "build $(date)"
    git push -u -f origin master
    cd ..    
}

PE-SOURCE()
{
    wget https://github.com/RaghuVarma331/scripts/raw/master/telegram.py
    wget https://github.com/RaghuVarma331/custom_roms_banners/raw/master/pixel.jpg
    git clone https://$gitpassword@github.com/RaghuVarma331/changelogs.git changelog    
    mkdir pe
    cd pe
    echo -ne '\n' | repo init -u https://github.com/PixelExperience/manifest -b ten --depth=1
    repo sync -c --no-tags --no-clone-bundle -f --force-sync -j16
    sed -i "/ro.control_privapp_permissions=enforce/d" vendor/aosp/config/common.mk
    git clone https://github.com/LineageOS/android_packages_resources_devicesettings.git -b lineage-17.0 packages/resources/devicesettings
    git clone https://github.com/RaghuVarma331/android_kernel_nokia_sdm660.git -b ten --depth=1 kernel/nokia/sdm660	
    git clone https://gitlab.com/RaghuVarma331/vendor_nokia.git -b ten --depth=1 vendor/nokia
    git clone https://github.com/RaghuVarma331/android_device_nokia_Dragon.git -b ten device/nokia/Dragon    
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Pixel-Experience for Nokia 6.1 Plus build started 
    
    $(date)
    
    👤 By: Raghu Varma

    build's progress at $jenkinsurl"      
    . build/envsetup.sh && lunch aosp_Dragon-eng && make -j32 bacon
    cd out/target/product/Dragon
    cat PixelExperience**.txt > $path/changelog/Dragon/PixelExperience.txt
    sshpass -p $password rsync -avP -e ssh PixelExperience**.zip     raghuvarma331@frs.sourceforge.net:/home/frs/project/drg-sprout/PixelExperience
    cd 
    cd $path
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P pixel.jpg -C "
    *
    New Pixel-Experience Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-6-1-plus/development/rom-pixel-experience-t3985853)
    
    💬 [Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/Dragon/PixelExperience.txt)
    
    📱Device: Nokia 6.1 Plus
    
    ⚡Build Version: Ten
    
    ⚡Android Version: 10.0.0
    
    ⚡Security Patch : $securitypatch
    
    👤 By: Raghu Varma
    
    Follow:  @Nokia6plusofficial ✅" 
    cd changelog
    git add .
    git commit -m "build $(date)"
    git push -u -f origin master
    cd ..
    cd pe
    rm -r device/nokia
    rm -r out/target/product/Dragon
    git clone https://github.com/RaghuVarma331/android_device_nokia_Onyx.git -b ten device/nokia/Onyx
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Pixel-Experience for Nokia 7 Plus build started 
    
    $(date)
    
    👤 By: Raghu Varma

    build's progress at $jenkinsurl"      
    . build/envsetup.sh && lunch aosp_Onyx-eng && make -j32 bacon
    cd out/target/product/Onyx
    cat PixelExperience**.txt > $path/changelog/Onyx/PixelExperience.txt
    sshpass -p $password rsync -avP -e ssh PixelExperience**.zip     raghuvarma331@frs.sourceforge.net:/home/frs/project/b2n-sprout/PixelExperience
    cd 
    cd $path
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P pixel.jpg -C "
    *
    New Pixel-Experience Build is up 
    
    $(date)*
     
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-plus/development/rom-pixel-experience-t3992063)
    
    💬 [Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/Onyx/PixelExperience.txt)
    
    📱Device: Nokia 7 Plus
    
    ⚡Build Version: Ten
    
    ⚡Android Version: 10.0.0
    
    ⚡Security Patch : $securitypatch
    
    👤 By: Raghu Varma
    
    Follow: @Nokia7plusOfficial ✅"     
    cd changelog
    git add .
    git commit -m "build $(date)"
    git push -u -f origin master
    cd ..    
    cd pe
    rm -r device/nokia
    rm -r out/target/product/Onyx
    git clone https://github.com/RaghuVarma331/android_device_nokia_Crystal.git -b ten device/nokia/Crystal
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Pixel-Experience for Nokia 7.1 build started 
    
    $(date)
    
    👤 By: Raghu Varma

    build's progress at $jenkinsurl"      
    . build/envsetup.sh && lunch aosp_Crystal-eng && make -j32 bacon
    cd out/target/product/Crystal
    cat PixelExperience**.txt > $path/changelog/Crystal/PixelExperience.txt
    sshpass -p $password rsync -avP -e ssh PixelExperience**.zip     raghuvarma331@frs.sourceforge.net:/home/frs/project/ctl-sprout/PixelExperience
    cd 
    cd $path
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P pixel.jpg -C "
    *
    New Pixel-Experience Build is up 
    
    $(date)*
     
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-1/development/rom-pixel-experience-t4019933)
    
    💬 [Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/Crystal/PixelExperience.txt)
    
    📱Device: Nokia 7.1
    
    ⚡Build Version: Ten
    
    ⚡Android Version: 10.0.0
    
    ⚡Security Patch : $securitypatch
    
    👤 By: Raghu Varma
    
    Follow: @nokia7161 ✅"     
    cd changelog
    git add .
    git commit -m "build $(date)"
    git push -u -f origin master
    cd .. 
    cd pe
    rm -r device/nokia
    rm -r out/target/product/Crystal
    git clone https://github.com/RaghuVarma331/android_device_nokia_Plate2.git -b ten device/nokia/Plate2
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Pixel-Experience for Nokia 6.1 build started 
    
    $(date)
    
    👤 By: Raghu Varma

    build's progress at $jenkinsurl"      
    . build/envsetup.sh && lunch aosp_Plate2-eng && make -j32 bacon
    cd out/target/product/Plate2
    cat PixelExperience**.txt > $path/changelog/Plate2/PixelExperience.txt
    sshpass -p $password rsync -avP -e ssh PixelExperience**.zip     raghuvarma331@frs.sourceforge.net:/home/frs/project/pl2-sprout/PixelExperience
    cd 
    cd $path
    rm -r pe
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P pixel.jpg -C "
    *
    New Pixel-Experience Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-6-2018/development/rom-pixel-experience-t3994591)
    
    💬 [Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/Plate2/PixelExperience.txt)
    
    📱Device: Nokia 6.1
    
    ⚡Build Version: Ten
    
    ⚡Android Version: 10.0.0
    
    ⚡Security Patch : $securitypatch
    
    👤 By: Raghu Varma
    
    Follow: @nokia7161 ✅"        
    cd changelog
    git add .
    git commit -m "build $(date)"
    git push -u -f origin master
    cd ..    
}

EVOX-SOURCE()
{
    wget https://github.com/RaghuVarma331/scripts/raw/master/telegram.py
    wget https://github.com/RaghuVarma331/custom_roms_banners/raw/master/evox.png
    git clone https://$gitpassword@github.com/RaghuVarma331/changelogs.git changelog    
    mkdir evo
    cd evo
    echo -ne '\n' | repo init -u https://github.com/Evolution-X/manifest -b ten --depth=1
    repo sync -c --no-tags --no-clone-bundle -f --force-sync -j16
    sed -i "/ro.control_privapp_permissions=enforce/d" vendor/aosp/config/common.mk
    git clone https://github.com/LineageOS/android_packages_resources_devicesettings.git -b lineage-17.0 packages/resources/devicesettings
    git clone https://github.com/RaghuVarma331/android_kernel_nokia_sdm660.git -b ten --depth=1 kernel/nokia/sdm660	
    git clone https://gitlab.com/RaghuVarma331/vendor_nokia.git -b ten --depth=1 vendor/nokia
    git clone https://github.com/RaghuVarma331/android_device_nokia_Dragon.git -b ten device/nokia/Dragon    
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Evolution X for Nokia 6.1 Plus build started 
    
    $(date)
    
    👤 By: Raghu Varma

    build's progress at $jenkinsurl"      
    export SKIP_ABI_CHECKS=true
    . build/envsetup.sh && lunch aosp_Dragon-eng && make -j32 bacon
    cd out/target/product/Dragon
    cat EvolutionX**.txt > $path/changelog/Dragon/evolutionx.txt
    sshpass -p $password rsync -avP -e ssh EvolutionX**.zip       raghuvarma331@frs.sourceforge.net:/home/frs/project/drg-sprout/EvolutionX
    cd 
    cd $path
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P evox.png -C "
    *
    New Evolution X Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-6-1-plus/development/rom-evolution-x-3-3-t4011589)
    
    💬 [Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/Dragon/evolutionx.txt)
    
    📱Device: Nokia 6.1 Plus
    
    ⚡Build Version: $evoxversion
    
    ⚡Android Version: 10.0.0
    
    ⚡Security Patch : $securitypatch
    
    👤 By: Raghu Varma
    
    Follow:  @Nokia6plusofficial ✅" 
    cd changelog
    git add .
    git commit -m "build $(date)"
    git push -u -f origin master
    cd ..    
    cd evo
    rm -r device/nokia
    rm -r out/target/product/Dragon
    git clone https://github.com/RaghuVarma331/android_device_nokia_Onyx.git -b ten device/nokia/Onyx
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Evolution X for Nokia 7 Plus build started 
    
    $(date)
    
    👤 By: Raghu Varma

    build's progress at $jenkinsurl"      
    export SKIP_ABI_CHECKS=true
    . build/envsetup.sh && lunch aosp_Onyx-eng && make -j32 bacon
    cd out/target/product/Onyx
    cat EvolutionX**.txt > $path/changelog/Onyx/evolutionx.txt
    sshpass -p $password rsync -avP -e ssh EvolutionX**.zip       raghuvarma331@frs.sourceforge.net:/home/frs/project/b2n-sprout/EvolutionX
    cd 
    cd $path
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P evox.png -C "
    *
    New Evolution X Build is up 
    
    $(date)*
     
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-plus/development/rom-evolution-x-3-3-t4011603)
    
    💬 [Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/Onyx/evolutionx.txt)
    
    📱Device: Nokia 7 Plus
    
    ⚡Build Version: $evoxversion
    
    ⚡Android Version: 10.0.0
    
    ⚡Security Patch : $securitypatch
    
    👤 By: Raghu Varma
    
    Follow: @Nokia7plusOfficial ✅"  
    cd changelog
    git add .
    git commit -m "build $(date)"
    git push -u -f origin master
    cd ..        
    cd evo
    rm -r device/nokia
    rm -r out/target/product/Onyx
    git clone https://github.com/RaghuVarma331/android_device_nokia_Crystal.git -b ten device/nokia/Crystal
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Evolution X for Nokia 7.1 build started 
    
    $(date)
    
    👤 By: Raghu Varma

    build's progress at $jenkinsurl"      
    export SKIP_ABI_CHECKS=true
    . build/envsetup.sh && lunch aosp_Crystal-eng && make -j32 bacon
    cd out/target/product/Crystal
    cat EvolutionX**.txt > $path/changelog/Crystal/evolutionx.txt
    sshpass -p $password rsync -avP -e ssh EvolutionX**.zip       raghuvarma331@frs.sourceforge.net:/home/frs/project/ctl-sprout/EvolutionX
    cd 
    cd $path
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P evox.png -C "
    *
    New Evolution X Build is up 
    
    $(date)*
     
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-1/development/rom-evolution-x-3-5-t4020515)
    
    💬 [Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/Crystal/evolutionx.txt)
    
    📱Device: Nokia 7.1
    
    ⚡Build Version: $evoxversion
    
    ⚡Android Version: 10.0.0
    
    ⚡Security Patch : $securitypatch
    
    👤 By: Raghu Varma
    
    Follow: @nokia7161 ✅"  
    cd changelog
    git add .
    git commit -m "build $(date)"
    git push -u -f origin master
    cd ..            
    cd evo
    rm -r device/nokia
    rm -r out/target/product/Crystal
    git clone https://github.com/RaghuVarma331/android_device_nokia_Plate2.git -b ten device/nokia/Plate2
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Evolution X for Nokia 6.1 build started 
    
    $(date)
    
    👤 By: Raghu Varma

    build's progress at $jenkinsurl" 
    export SKIP_ABI_CHECKS=true
    . build/envsetup.sh && lunch aosp_Plate2-eng && make -j32 bacon
    cd out/target/product/Plate2
    cat EvolutionX**.txt > $path/changelog/Plate2/evolutionx.txt
    sshpass -p $password rsync -avP -e ssh EvolutionX**.zip  raghuvarma331@frs.sourceforge.net:/home/frs/project/pl2-sprout/EvolutionX
    cd 
    cd $path
    rm -r evo
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P evox.png -C "
    *
    New Evolution X Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-6-2018/development/rom-evolution-x-3-3-t4011611)
    
    💬 [Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/Plate2/evolutionx.txt)
    
    📱Device: Nokia 6.1
    
    ⚡Build Version: $evoxversion
    
    ⚡Android Version: 10.0.0
    
    ⚡Security Patch : $securitypatch
    
    👤 By: Raghu Varma
    
    Follow: @nokia7161 ✅"        
    cd changelog
    git add .
    git commit -m "build $(date)"
    git push -u -f origin master
    cd ..    
}

HAVOC-SOURCE()
{
    wget https://github.com/RaghuVarma331/scripts/raw/master/telegram.py
    wget https://github.com/RaghuVarma331/custom_roms_banners/raw/master/havoc.jpg
    git clone https://$gitpassword@github.com/RaghuVarma331/changelogs.git changelog    
    mkdir havoc
    cd havoc
    echo -ne '\n' | repo init -u https://github.com/Havoc-OS/android_manifest.git -b ten --depth=1
    repo sync -c --no-tags --no-clone-bundle -f --force-sync -j16
    rm -r vendor/havoc
    git clone https://github.com/Havoc-OS/android_vendor_havoc.git -b ten vendor/havoc
    cd vendor/havoc
    git remote add prebuilt https://github.com/RaghuVarma331/vendor_havoc.git
    git fetch prebuilt
    git cherry-pick 0e72dd40c7e9a1fce2f3b0e112967fc03625edd9
    cd
    cd $path/havoc
    sed -i "/ro.control_privapp_permissions=enforce/d" vendor/havoc/config/common.mk    
    git clone https://github.com/LineageOS/android_packages_resources_devicesettings.git -b lineage-17.0 packages/resources/devicesettings
    git clone https://github.com/RaghuVarma331/android_kernel_nokia_sdm660.git -b ten --depth=1 kernel/nokia/sdm660
    git clone https://gitlab.com/RaghuVarma331/vendor_nokia.git -b ten --depth=1 vendor/nokia
    git clone https://github.com/RaghuVarma331/android_device_nokia_Dragon.git -b ten device/nokia/Dragon    
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Havoc-OS for Nokia 6.1 Plus build started 
    
    $(date)
    
    👤 By: Raghu Varma

    build's progress at $jenkinsurl"      
    . build/envsetup.sh && lunch havoc_Dragon-eng && make -j32 bacon
    cd out/target/product/Dragon
    cat Havoc-OS**.txt > $path/changelog/Dragon/HavocOS.txt
    sshpass -p $password rsync -avP -e ssh Havoc-OS**.zip   raghuvarma331@frs.sourceforge.net:/home/frs/project/drg-sprout/Havoc-OS
    cd 
    cd $path
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P havoc.jpg -C "
    *
    New Havoc-OS Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-6-1-plus/development/rom-havoc-os-v3-0-t3997651)
    
    💬 [Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/Dragon/HavocOS.txt)
    
    📱Device: Nokia 6.1 Plus
    
    ⚡Build Version: $havocversion
    
    ⚡Android Version: 10.0.0
    
    ⚡Security Patch : $securitypatch
    
    👤 By: Raghu Varma
    
    Follow:  @Nokia6plusofficial ✅" 
    cd changelog
    git add .
    git commit -m "build $(date)"
    git push -u -f origin master
    cd ..
    cd havoc
    rm -r device/nokia
    rm -r out/target/product/Dragon
    git clone https://github.com/RaghuVarma331/android_device_nokia_Onyx.git -b ten device/nokia/Onyx
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Havoc-OS for Nokia 7 Plus build started 
    
    $(date)
    
    👤 By: Raghu Varma

    build's progress at $jenkinsurl"      
    . build/envsetup.sh && lunch havoc_Onyx-eng && make -j32 bacon
    cd out/target/product/Onyx
    cat Havoc-OS**.txt > $path/changelog/Onyx/HavocOS.txt
    sshpass -p $password rsync -avP -e ssh Havoc-OS**.zip   raghuvarma331@frs.sourceforge.net:/home/frs/project/b2n-sprout/Havoc-OS
    cd 
    cd $path
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P havoc.jpg -C "
    *
    New Havoc-OS Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-plus/development/rom-havoc-os-v3-0-t3998287)
    
    💬 [Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/Onyx/HavocOS.txt)
    
    📱Device: Nokia 7 Plus
    
    ⚡Build Version: $havocversion
    
    ⚡Android Version: 10.0.0
    
    ⚡Security Patch : $securitypatch
    
    👤 By: Raghu Varma
    
    Follow: @Nokia7plusOfficial ✅"     
    cd changelog
    git add .
    git commit -m "build $(date)"
    git push -u -f origin master
    cd ..    
    cd havoc
    rm -r device/nokia
    rm -r out/target/product/Onyx
    git clone https://github.com/RaghuVarma331/android_device_nokia_Crystal.git -b ten device/nokia/Crystal
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Havoc-OS for Nokia 7.1 build started 
    
    $(date)
    
    👤 By: Raghu Varma

    build's progress at $jenkinsurl"      
    . build/envsetup.sh && lunch havoc_Crystal-eng && make -j32 bacon
    cd out/target/product/Crystal
    cat Havoc-OS**.txt > $path/changelog/Crystal/HavocOS.txt
    sshpass -p $password rsync -avP -e ssh Havoc-OS**.zip   raghuvarma331@frs.sourceforge.net:/home/frs/project/ctl-sprout/Havoc-OS
    cd 
    cd $path
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P havoc.jpg -C "
    *
    New Havoc-OS Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-1/development/rom-havoc-os-v3-0-t4020097)
    
    💬 [Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/Crystal/HavocOS.txt)
    
    📱Device: Nokia 7.1
    
    ⚡Build Version: $havocversion
    
    ⚡Android Version: 10.0.0
    
    ⚡Security Patch : $securitypatch
    
    👤 By: Raghu Varma
    
    Follow: @nokia7161 ✅"     
    cd changelog
    git add .
    git commit -m "build $(date)"
    git push -u -f origin master
    cd ..          
    cd havoc
    rm -r device/nokia
    rm -r out/target/product/Crystal
    git clone https://github.com/RaghuVarma331/android_device_nokia_Plate2.git -b ten device/nokia/Plate2
    curl -s -X POST https://api.telegram.org/bot$Telegram_Api_code/sendMessage -d chat_id=$chat_id -d text="
    
    New Havoc-OS for Nokia 6.1 build started 
    
    $(date)
    
    👤 By: Raghu Varma

    build's progress at $jenkinsurl"      
    . build/envsetup.sh && lunch havoc_Plate2-eng && make -j32 bacon
    cd out/target/product/Plate2
    cat Havoc-OS**.txt > $path/changelog/Plate2/HavocOS.txt
    sshpass -p $password rsync -avP -e ssh Havoc-OS**.zip raghuvarma331@frs.sourceforge.net:/home/frs/project/pl2-sprout/Havoc-OS
    cd 
    cd $path
    rm -r havoc
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P havoc.jpg -C "
    *
    New Havoc-OS Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-6-2018/development/rom-havoc-os-v3-0-t3998283)
    
    💬 [Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/Plate2/HavocOS.txt)
    
    📱Device: Nokia 6.1
    
    ⚡Build Version: $havocversion
    
    ⚡Android Version: 10.0.0
    
    ⚡Security Patch : $securitypatch
    
    👤 By: Raghu Varma
    
    Follow: @nokia7161 ✅"        
    cd changelog
    git add .
    git commit -m "build $(date)"
    git push -u -f origin master
    cd ..    
}

TWRP-P-SOURCE()
{
    wget https://github.com/RaghuVarma331/scripts/raw/master/telegram.py
    wget https://github.com/RaghuVarma331/custom_roms_banners/raw/master/twrp.jpg
    mkdir DRG_sprout
    mkdir B2N_sprout	
    mkdir DDV_sprout
    mkdir SLD_sprout
    mkdir CTL_sprout
    mkdir twrp
    cd twrp
    repo init -u git://github.com/omnirom/android.git -b android-9.0 --depth=1
    repo sync -c --no-tags --no-clone-bundle -f --force-sync -j16
    rm -r bootable/recovery
    git clone https://github.com/RaghuVarma331/android_bootable_recovery.git -b android-9.0 bootable/recovery
    git clone https://github.com/TeamWin/external_magisk-prebuilt -b master external/magisk-prebuilt
    git clone https://github.com/TeamWin/android_external_busybox.git -b android-9.0 external/busybox
    git clone https://github.com/omnirom/android_external_toybox.git -b android-9.0 external/toybox
    git clone https://github.com/omnirom/android_vendor_qcom_opensource_commonsys.git -b android-9.0 vendor/qcom/opensource/commonsys
    git clone https://github.com/RaghuVarma331/android_device_nokia_DRG_sprout-TWRP.git -b android-9.0 device/nokia/DRG_sprout
    git clone https://github.com/RaghuVarma331/android_device_nokia_B2N_sprout-TWRP.git -b android-9.0 device/nokia/B2N_sprout
    git clone https://github.com/RaghuVarma331/android_device_nokia_DDV_sprout-TWRP.git -b android-9.0 device/nokia/DDV_sprout
    sed -i "91i PLATFORM_SECURITY_PATCH := $twrpsp" device/nokia/DDV_sprout/BoardConfig.mk
    git clone https://github.com/RaghuVarma331/android_device_nokia_SLD_sprout-TWRP.git -b android-9.0 device/nokia/SLD_sprout
    sed -i "91i PLATFORM_SECURITY_PATCH := $twrpsp" device/nokia/SLD_sprout/BoardConfig.mk
    . build/envsetup.sh && lunch omni_DRG_sprout-eng && make -j32 recoveryimage
    . build/envsetup.sh && lunch omni_B2N_sprout-eng && make -j32 recoveryimage	
    . build/envsetup.sh && lunch omni_SLD_sprout-eng && make -j32 recoveryimage	
    . build/envsetup.sh && lunch omni_DDV_sprout-eng && make -j32 recoveryimage
    cd out/target/product/DRG_sprout
    mv recovery.img twrp-3.3.1-0-DRG_sprout-9.0-$(date +"%Y%m%d").img
    cp -r twrp-3.3.1-0-DRG_sprout-9.0-$(date +"%Y%m%d").img $path/DRG_sprout
    cd
    cd $path/twrp	
    cd out/target/product/B2N_sprout
    mv recovery.img twrp-3.3.1-0-B2N_sprout-OOB-9.0-$(date +"%Y%m%d").img
    cp -r twrp-3.3.1-0-B2N_sprout-OOB-9.0-$(date +"%Y%m%d").img $path/B2N_sprout
    cd
    cd $path/twrp	
    cd out/target/product/SLD_sprout
    mv recovery.img twrp-3.3.1-0-SLD_sprout-9.0-$(date +"%Y%m%d").img
    cp -r twrp-3.3.1-0-SLD_sprout-9.0-$(date +"%Y%m%d").img $path/SLD_sprout
    cd
    cd $path/twrp	
    cd out/target/product/DDV_sprout
    mv recovery.img twrp-3.3.1-0-DDV_sprout-9.0-$(date +"%Y%m%d").img
    cp -r twrp-3.3.1-0-DDV_sprout-9.0-$(date +"%Y%m%d").img $path/DDV_sprout
    cd
    cd $path/twrp
    rm -r device/nokia
    rm -r out
    git clone https://github.com/RaghuVarma331/android_device_nokia_B2N_sprout-TWRP.git -b android-9.0-NB device/nokia/B2N_sprout
    . build/envsetup.sh && lunch omni_B2N_sprout-eng && make -j32 recoveryimage	
    cd out/target/product/B2N_sprout
    mv recovery.img twrp-3.3.1-0-B2N_sprout-POB-9.0-$(date +"%Y%m%d").img
    cp -r twrp-3.3.1-0-B2N_sprout-POB-9.0-$(date +"%Y%m%d").img $path/B2N_sprout
    cd
    cd $path    	
}	


TWRP-Q-SOURCE()
{
    cd twrp
    rm -r device/nokia
    rm -r out
    git clone https://github.com/RaghuVarma331/android_device_nokia_DRG_sprout-TWRP.git -b android-10.0 device/nokia/DRG_sprout
    git clone https://github.com/RaghuVarma331/android_device_nokia_B2N_sprout-TWRP.git -b android-10.0 device/nokia/B2N_sprout
    git clone https://github.com/RaghuVarma331/android_device_nokia_CTL_sprout-TWRP.git -b android-10.0 device/nokia/CTL_sprout
    . build/envsetup.sh && lunch omni_DRG_sprout-eng && make -j32 recoveryimage	
    . build/envsetup.sh && lunch omni_B2N_sprout-eng && make -j32 recoveryimage
    . build/envsetup.sh && lunch omni_CTL_sprout-eng && make -j32 recoveryimage
    cd out/target/product/DRG_sprout
    mv recovery.img twrp-3.3.1-0-DRG_sprout-10.0-$(date +"%Y%m%d").img
    cp -r twrp-3.3.1-0-DRG_sprout-10.0-$(date +"%Y%m%d").img $path/DRG_sprout
    cd
    cd $path/twrp
    cd out/target/product/CTL_sprout
    mv recovery.img twrp-3.3.1-0-CTL_sprout-10.0-$(date +"%Y%m%d").img
    cp -r twrp-3.3.1-0-CTL_sprout-10.0-$(date +"%Y%m%d").img $path/CTL_sprout
    cd
    cd $path/twrp    
    cd out/target/product/B2N_sprout
    mv recovery.img twrp-3.3.1-0-B2N_sprout-OOB-10.0-$(date +"%Y%m%d").img
    cp -r twrp-3.3.1-0-B2N_sprout-OOB-10.0-$(date +"%Y%m%d").img $path/B2N_sprout
    cd
    cd $path/twrp
    rm -r device/nokia
    rm -r out
    git clone https://github.com/RaghuVarma331/android_device_nokia_B2N_sprout-TWRP.git -b android-10.0-NB device/nokia/B2N_sprout
    . build/envsetup.sh && lunch omni_B2N_sprout-eng && make -j32 recoveryimage	
    cd out/target/product/B2N_sprout
    mv recovery.img twrp-3.3.1-0-B2N_sprout-POB-10.0-$(date +"%Y%m%d").img
    cp -r twrp-3.3.1-0-B2N_sprout-POB-10.0-$(date +"%Y%m%d").img $path/B2N_sprout
    cd
    cd $path  

}

TWRP-Q-INSTALLER()
{
    cd twrp
    rm -r out
    rm -r device/nokia
    git clone https://github.com/RaghuVarma331/android_device_nokia_DRG_sprout-TWRP.git -b android-10.0 device/nokia/DRG_sprout
    git clone https://github.com/RaghuVarma331/android_device_nokia_B2N_sprout-TWRP.git -b android-10.0 device/nokia/B2N_sprout	
    git clone https://github.com/RaghuVarma331/android_device_nokia_CTL_sprout-TWRP.git -b android-10.0 device/nokia/CTL_sprout    
    sed -i "/ro.build.version.security_patch/d" build/tools/buildinfo.sh
    . build/envsetup.sh && lunch omni_DRG_sprout-eng && make -j32 recoveryimage
    . build/envsetup.sh && lunch omni_B2N_sprout-eng && make -j32 recoveryimage
    . build/envsetup.sh && lunch omni_CTL_sprout-eng && make -j32 recoveryimage  
    cd out/target/product/DRG_sprout
    mv ramdisk-recovery.cpio ramdisk-twrp.cpio
    cp -r ramdisk-twrp.cpio $path/twrp/device/nokia/DRG_sprout/installer
    cd
    cd $path/twrp/device/nokia/DRG_sprout/installer
    zip -r twrp-installer-3.3.1-0-DRG_sprout-10.0-$(date +"%Y%m%d").zip magiskboot  META-INF ramdisk-twrp.cpio
    cp -r twrp-installer-3.3.1-0-DRG_sprout-10.0-$(date +"%Y%m%d").zip $path/DRG_sprout  
    cd
    cd $path/twrp
    cd out/target/product/CTL_sprout
    mv ramdisk-recovery.cpio ramdisk-twrp.cpio
    cp -r ramdisk-twrp.cpio $path/twrp/device/nokia/CTL_sprout/installer
    cd
    cd $path/twrp/device/nokia/CTL_sprout/installer
    zip -r twrp-installer-3.3.1-0-CTL_sprout-10.0-$(date +"%Y%m%d").zip magiskboot  META-INF ramdisk-twrp.cpio
    cp -r twrp-installer-3.3.1-0-CTL_sprout-10.0-$(date +"%Y%m%d").zip $path/CTL_sprout  
    cd
    cd $path/twrp
    cd out/target/product/B2N_sprout
    mv ramdisk-recovery.cpio ramdisk-twrp.cpio
    cp -r ramdisk-twrp.cpio $path/twrp/device/nokia/B2N_sprout/installer
    cd
    cd $path/twrp/device/nokia/B2N_sprout/installer
    zip -r twrp-installer-3.3.1-0-B2N_sprout-OOB-10.0-$(date +"%Y%m%d").zip magiskboot  META-INF ramdisk-twrp.cpio
    cp -r twrp-installer-3.3.1-0-B2N_sprout-OOB-10.0-$(date +"%Y%m%d").zip $path/B2N_sprout  
    cd
    cd $path/twrp
    rm -r out
    rm -r device/nokia
    git clone https://github.com/RaghuVarma331/android_device_nokia_B2N_sprout-TWRP.git -b android-10.0-NB device/nokia/B2N_sprout	
    . build/envsetup.sh && lunch omni_B2N_sprout-eng && make -j32 recoveryimage  
    cd out/target/product/B2N_sprout
    mv ramdisk-recovery.cpio ramdisk-twrp.cpio
    cp -r ramdisk-twrp.cpio $path/twrp/device/nokia/B2N_sprout/installer
    cd
    cd $path/twrp/device/nokia/B2N_sprout/installer
    zip -r twrp-installer-3.3.1-0-B2N_sprout-POB-10.0-$(date +"%Y%m%d").zip magiskboot  META-INF ramdisk-twrp.cpio
    cp -r twrp-installer-3.3.1-0-B2N_sprout-POB-10.0-$(date +"%Y%m%d").zip $path/B2N_sprout  
    cd
    cd $path    
}

TWRP-P-INSTALLER()
{
    cd twrp
    rm -r out
    rm -r device/nokia
    git clone https://github.com/RaghuVarma331/android_device_nokia_DRG_sprout-TWRP.git -b android-9.0 device/nokia/DRG_sprout
    git clone https://github.com/RaghuVarma331/android_device_nokia_B2N_sprout-TWRP.git -b android-9.0 device/nokia/B2N_sprout		
    . build/envsetup.sh && lunch omni_DRG_sprout-eng && make -j32 recoveryimage
    . build/envsetup.sh && lunch omni_B2N_sprout-eng && make -j32 recoveryimage
    cd out/target/product/DRG_sprout
    mv ramdisk-recovery.cpio ramdisk-twrp.cpio
    cp -r ramdisk-twrp.cpio $path/twrp/device/nokia/DRG_sprout/installer
    cd
    cd $path/twrp/device/nokia/DRG_sprout/installer
    zip -r twrp-installer-3.3.1-0-DRG_sprout-9.0-$(date +"%Y%m%d").zip magiskboot  META-INF ramdisk-twrp.cpio
    cp -r twrp-installer-3.3.1-0-DRG_sprout-9.0-$(date +"%Y%m%d").zip $path/DRG_sprout  
    cd
    cd $path/twrp	
    cd out/target/product/B2N_sprout
    mv ramdisk-recovery.cpio ramdisk-twrp.cpio
    cp -r ramdisk-twrp.cpio $path/twrp/device/nokia/B2N_sprout/installer
    cd
    cd $path/twrp/device/nokia/B2N_sprout/installer
    zip -r twrp-installer-3.3.1-0-B2N_sprout-OOB-9.0-$(date +"%Y%m%d").zip magiskboot  META-INF ramdisk-twrp.cpio
    cp -r twrp-installer-3.3.1-0-B2N_sprout-OOB-9.0-$(date +"%Y%m%d").zip $path/B2N_sprout  
    cd
    cd $path/twrp
    rm -r out
    rm -r device/nokia
    git clone https://github.com/RaghuVarma331/android_device_nokia_B2N_sprout-TWRP.git -b android-9.0-NB device/nokia/B2N_sprout	
    . build/envsetup.sh && lunch omni_B2N_sprout-eng && make -j32 recoveryimage     
    cd out/target/product/B2N_sprout
    mv ramdisk-recovery.cpio ramdisk-twrp.cpio
    cp -r ramdisk-twrp.cpio $path/twrp/device/nokia/B2N_sprout/installer
    cd
    cd $path/twrp/device/nokia/B2N_sprout/installer
    zip -r twrp-installer-3.3.1-0-B2N_sprout-POB-9.0-$(date +"%Y%m%d").zip magiskboot  META-INF ramdisk-twrp.cpio
    cp -r twrp-installer-3.3.1-0-B2N_sprout-POB-9.0-$(date +"%Y%m%d").zip $path/B2N_sprout  
    cd
    cd $path     
    rm -r twrp
    cd CTL_sprout
    sshpass -p $password rsync -avP -e ssh twrp-3.3.1-0-CTL_sprout-10.0* twrp-installer-3.3.1-0-CTL_sprout-10.0* raghuvarma331@frs.sourceforge.net:/home/frs/project/ctl-sprout/TWRP/TEN
    cd ..
    cd DRG_sprout
    sshpass -p $password rsync -avP -e ssh twrp-3.3.1-0-DRG_sprout-9.0* twrp-installer-3.3.1-0-DRG_sprout-9.0* raghuvarma331@frs.sourceforge.net:/home/frs/project/drg-sprout/TWRP/PIE
    sshpass -p $password rsync -avP -e ssh twrp-3.3.1-0-DRG_sprout-10.0* twrp-installer-3.3.1-0-DRG_sprout-10.0* raghuvarma331@frs.sourceforge.net:/home/frs/project/drg-sprout/TWRP/TEN
    cd ..
    cd B2N_sprout
    sshpass -p $password rsync -avP -e ssh twrp-3.3.1-0-B2N_sprout-OOB-9.0* twrp-installer-3.3.1-0-B2N_sprout-OOB-9.0* raghuvarma331@frs.sourceforge.net:/home/frs/project/b2n-sprout/TWRP-PIE/OOB
    sshpass -p $password rsync -avP -e ssh twrp-3.3.1-0-B2N_sprout-POB-9.0* twrp-installer-3.3.1-0-B2N_sprout-POB-9.0* raghuvarma331@frs.sourceforge.net:/home/frs/project/b2n-sprout/TWRP-PIE/POB
    sshpass -p $password rsync -avP -e ssh twrp-3.3.1-0-B2N_sprout-OOB-10.0* twrp-installer-3.3.1-0-B2N_sprout-OOB-10.0* raghuvarma331@frs.sourceforge.net:/home/frs/project/b2n-sprout/TWRP-TEN/OOB
    sshpass -p $password rsync -avP -e ssh twrp-3.3.1-0-B2N_sprout-POB-10.0* twrp-installer-3.3.1-0-B2N_sprout-POB-10.0* raghuvarma331@frs.sourceforge.net:/home/frs/project/b2n-sprout/TWRP-TEN/POB
    cd ..
    cd SLD_sprout 
    sshpass -p $password rsync -avP -e ssh twrp-3.3.1-0-SLD_sprout-9.0* raghuvarma331@frs.sourceforge.net:/home/frs/project/sld-sprout/TWRP/PIE/2019-12-05
    cd ..
    cd DDV_sprout
    sshpass -p $password rsync -avP -e ssh twrp-3.3.1-0-DDV_sprout-9.0* raghuvarma331@frs.sourceforge.net:/home/frs/project/ddv-sprout/TWRP/PIE/2019-12-05
    cd .. 
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "
    *
    New Android 10.0 Twrp-3.3.1-0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-6-1-plus/development/recovery-twrp-3-2-3-0-team-win-recovery-t3893909)
    
    📱Device: Nokia 6.1 Plus
    
    ⚡Build Version: 3.3.1-0
    
    ⚡Android Version: 10.0.0
    
    👤 By: Raghu Varma
    
    Follow:  @Nokia6plusofficial ✅"  
    
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "
    *
    New Android 10.0 Twrp-3.3.1-0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-1/development/twrp-3-2-3-0-team-win-recovery-project-t3935859)
    
    📱Device: Nokia 7.1
    
    ⚡Build Version: 3.3.1-0
    
    ⚡Android Version: 10.0.0
    
    👤 By: Raghu Varma
    
    Follow: @nokia7161 ✅"      
    
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "
    *
    New Android 10.0 Twrp-3.3.1-0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-plus/development/twrp-3-3-1-0-team-win-recovery-project-t3940223)
    
    📱Device: Nokia 7 Plus (OOB)
    
    ⚡Build Version: 3.3.1-0
    
    ⚡Android Version: 10.0.0
    
    👤 By: Raghu Varma
    
    Follow:  @Nokia7plusOfficial ✅" 
    
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "
    *
    New Android 10.0 Twrp-3.3.1-0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-plus/development/twrp-3-3-1-0-team-win-recovery-project-t3940223)
    
    📱Device: Nokia 7 Plus (POB)
    
    ⚡Build Version: 3.3.1-0
    
    ⚡Android Version: 10.0.0
    
    👤 By: Raghu Varma
    
    Follow:  @Nokia7plusOfficial ✅" 
    
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "    
    *
    New Android 9.0 Twrp-3.3.1-0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-6-1-plus/development/recovery-twrp-3-2-3-0-team-win-recovery-t3893909)
    
    📱Device: Nokia 6.1 Plus
    
    ⚡Build Version: 3.3.1-0
    
    ⚡Android Version: 9.0.0
    
    👤 By: Raghu Varma
    
    Follow:  @Nokia6plusofficial ✅"  
    
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "
    *
    New Android 9.0 Twrp-3.3.1-0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-plus/development/twrp-3-3-1-0-team-win-recovery-project-t3940223)
    
    📱Device: Nokia 7 Plus (OOB)
    
    ⚡Build Version: 3.3.1-0
    
    ⚡Android Version: 9.0.0
    
    👤 By: Raghu Varma
    
    Follow:  @Nokia7plusOfficial ✅" 
    
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "
    *
    New Android 9.0 Twrp-3.3.1-0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-plus/development/twrp-3-3-1-0-team-win-recovery-project-t3940223)
    
    📱Device: Nokia 7 Plus (POB)
    
    ⚡Build Version: 3.3.1-0
    
    ⚡Android Version: 9.0.0
    
    👤 By: Raghu Varma
    
    Follow:  @Nokia7plusOfficial ✅"  
    
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "
    *
    New Android 9.0 Twrp-3.3.1-0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-6-2/development/unofficial-twrp-3-3-1-0-team-win-t3999433)
    
    📱Device: Nokia 6.2
    
    ⚡Build Version: 3.3.1-0
    
    ⚡Android Version: 9.0.0
    
    ⚡Android Security Patch : $twrpsp
    
    👤 By: Raghu Varma
    
    Follow:  @Nokia7262 ✅"     
    
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "
    *
    New Android 9.0 Twrp-3.3.1-0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-2/development/unofficial-twrp-3-3-1-0-team-win-t3999325)
    
    📱Device: Nokia 7.2
    
    ⚡Build Version: 3.3.1-0
    
    ⚡Android Version: 9.0.0
    
    ⚡Android Security Patch : $twrpsp
    
    👤 By: Raghu Varma
    
    Follow:  @Nokia7262 ✅"  
    
}

KIWIS-SOURCE()
{   
    wget https://github.com/RaghuVarma331/custom_roms_banners/raw/master/kiwis.jpg
    wget https://github.com/RaghuVarma331/scripts/raw/master/telegram.py
    mkdir kiwis-kernel
    git clone https://github.com/RaghuVarma331/aarch64-linux-android-4.9.git -b master aarch64-linux-android-4.9
    git clone https://github.com/RaghuVarma331/android_kernel_nokia_sdm660.git -b ten --depth=1 drg
    cd drg
    export ARCH=arm64
    export CROSS_COMPILE=$path/aarch64-linux-android-4.9/bin/aarch64-linux-android-
    mkdir output
    make -C $(pwd) O=output SAT-perf_defconfig
    make -j32 -C $(pwd) O=output
    cp -r output/arch/arm64/boot/Image.gz-dtb $path/drg/DRG_sprout
    cd DRG_sprout
    zip -r Kiwis-kernel-10.0-DRG_sprout-$(date +"%Y%m%d").zip META-INF patch tools Image.gz-dtb anykernel.sh   
    cp -r Kiwis-kernel-10.0-DRG_sprout-$(date +"%Y%m%d").zip $path/kiwis-kernel
    cd
    cd $path
    rm -r drg
    cd kiwis-kernel
    sshpass -p $password rsync -avP -e ssh Kiwis-kernel**.zip raghuvarma331@frs.sourceforge.net:/home/frs/project/drg-sprout/Kiwis-kernel
    cd ..
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P kiwis.jpg -C "
    *
    New Android 10 Kiwis Kernel Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-6-1-plus/development/kernel-kiwis-kernel-9-0-0-nokia-6-1-t3963473)
    
    📱Device: Nokia 6.1 Plus
    
    ⚡Build Version: 4.4.165
    
    ⚡Android Version: 10.0.0
    
    👤 By: Raghu Varma
    
    Follow:  @Nokia6plusofficial ✅"   
    
}    

OXYGEN-SOURCE()
{   
    mkdir OxygenOS
    git clone https://github.com/RaghuVarma331/Gsi-Porter-Tool.git tool
    cd tool
    chmod a+x rv.sh
    sudo ./rv.sh
    cd output 
    cp -r OxygenOS-10.0-OP6-Stable-HMD-SDM660-$(date +"%Y%m%d").zip $path/OxygenOS
    cd ..
    cd ..
    sudo rm -r tool
    cd OxygenOS
    sshpass -p $password rsync -avP -e ssh OxygenOS-10.0**.zip raghuvarma331@frs.sourceforge.net:/home/frs/project/nokia-sdm660/OxygenOS
    cd ..
    wget https://github.com/RaghuVarma331/scripts/raw/master/telegram.py
    wget https://github.com/RaghuVarma331/custom_roms_banners/raw/master/oxygenos.png
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P oxygenos.png -C "
    *
    New Android 10.0  Oxygen OS Port 
    Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-2/nokia-616162777172-cross-device-development/rom-oxygen-os-t4008971)
    
    💬 [Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/crossdevelopment/oxygenos.txt)
    
    📱Device: Nokia 6.1 Plus
    
    ⚡Build Version: $oxversion
    
    ⚡Android Version: 10.0
    
    ⚡Security Patch : $securitypatch
    
    👤 By: Raghu Varma
    
    Follow:  @Nokia6plusofficial ✅" 
    
    
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P oxygenos.png -C "
    *
    New Android 10.0  Oxygen OS Port 
    Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-2/nokia-616162777172-cross-device-development/rom-oxygen-os-t4008971)
    
    💬 [Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/crossdevelopment/oxygenos.txt)
    
    📱Device: Nokia 7 Plus
    
    ⚡Build Version: $oxversion
    
    ⚡Android Version: 10.0
    
    ⚡Security Patch : $securitypatch
    
    👤 By: Raghu Varma
    
    Follow: @Nokia7plusOfficial ✅"  
    
    
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P oxygenos.png -C "
    *
    New Android 10.0  Oxygen OS Port 
    Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-2/nokia-616162777172-cross-device-development/rom-oxygen-os-t4008971)
    
    💬 [Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/crossdevelopment/oxygenos.txt)
    
    📱Device: Nokia 6.1
    
    ⚡Build Version: $oxversion
    
    ⚡Android Version: 10.0
    
    ⚡Security Patch : $securitypatch
    
    👤 By: Raghu Varma
    
    Follow: @nokia7161 ✅"     
    
    
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P oxygenos.png -C "
    *
    New Android 10.0  Oxygen OS Port 
    Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-2/nokia-616162777172-cross-device-development/rom-oxygen-os-t4008971)
    
    💬 [Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/crossdevelopment/oxygenos.txt)
    
    📱Device: Nokia 7.1
    
    ⚡Build Version: $oxversion
    
    ⚡Android Version: 10.0
    
    ⚡Security Patch : $securitypatch
    
    👤 By: Raghu Varma
    
    Follow: @nokia7161 ✅"       
    
    
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P oxygenos.png -C "
    *
    New Android 10.0  Oxygen OS Port 
    Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-2/nokia-616162777172-cross-device-development/rom-oxygen-os-t4008971)
    
    💬 [Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/crossdevelopment/oxygenos.txt)
    
    📱Device: Nokia 7.2
    
    ⚡Build Version: $oxversion
    
    ⚡Android Version: 10.0
    
    ⚡Security Patch : $securitypatch
    
    👤 By: Raghu Varma
    
    Follow: @Nokia7262 ✅"
    
    
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P oxygenos.png -C "
    *
    New Android 10.0  Oxygen OS Port 
    Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-2/nokia-616162777172-cross-device-development/rom-oxygen-os-t4008971)
    
    💬 [Changelog](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/crossdevelopment/oxygenos.txt)
    
    📱Device: Nokia 6.2
    
    ⚡Build Version: $oxversion
    
    ⚡Android Version: 10.0
    
    ⚡Security Patch : $securitypatch
    
    👤 By: Raghu Varma
    
    Follow: @Nokia7262 ✅"
    
}    


TOOLS_SETUP() 
{
        sudo apt-get update 
        echo -ne '\n' | sudo apt-get upgrade
        echo -ne '\n' | sudo apt-get install git ccache schedtool lzop bison gperf build-essential zip curl zlib1g-dev g++-multilib python-networkx libxml2-utils bzip2 libbz2-dev libghc-bzlib-dev squashfs-tools pngcrush liblz4-tool optipng libc6-dev-i386 gcc-multilib libssl-dev gnupg flex lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev xsltproc unzip python-pip python-dev libffi-dev libxml2-dev libxslt1-dev libjpeg8-dev openjdk-8-jdk imagemagick device-tree-compiler repo mailutils-mh expect python3-requests python-requests android-tools-fsutils sshpass
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
	mkdir -p ~/.ssh  &&  echo "Host *" > ~/.ssh/config && echo " StrictHostKeyChecking no" >> ~/.ssh/config
	echo "# Allow Jenkins" >> /etc/sudoers && echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
}

		
# Main Menu
clear
echo "------------------------------------------------"
echo "A simple remote script to compile custom Stuff"
echo "Coded By Raghu Varma.G "
echo "------------------------------------------------"
PS3='Please select your option (1-9): '
menuvar=("BasicSetup" "pe" "lineageos" "havoc" "evox" "oxygen" "twrp" "kiwis-kernel" "all_roms" "Exit")
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
        "kiwis-kernel")
            clear
            echo "----------------------------------------------"
            echo "Started Building kiwis-kernel For Nokia 6.1 Plus  ."
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
        "twrp")
            clear
            echo "----------------------------------------------"
            echo "Started Building Q TWRP-3.3.1-0 for DRG,B2N,DDV & SLD"
            echo "Please be patient..."
            # twrp
            echo "----------------------------------------------"
            echo "Setting Up Tools & Stuff..."
            echo " "
            TOOLS_SETUP
	    echo " "	    
            echo "----------------------------------------------"
            echo "Setting up twrp P source..."
            echo " "
            TWRP-P-SOURCE
	    echo " "
            echo "----------------------------------------------"
            echo "Setting up twrp Q source..."
            echo " "
            TWRP-Q-SOURCE
	    echo " "	 
            echo "----------------------------------------------"
            echo "Setting up twrp Q ins..."
            echo " "
            TWRP-Q-INSTALLER
	    echo " "	
            echo "----------------------------------------------"
            echo "Setting up twrp P ins..."
            echo " "
            TWRP-P-INSTALLER
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
        "pe")
            clear
            echo "----------------------------------------------"
            echo "Started Building Pixel-Experience for Nokia 6.1 Plus , 7 Plus & 6.1  ."
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
            echo "Started Building LineageOS 17.0 for Nokia 6.1 Plus , 7 Plus  ."
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
        "oxygen")
            clear
            echo "----------------------------------------------"
            echo "Started Porting OxygenOS for Nokia 6.1 Plus , 7 Plus ,Nokia 7.2 , Nokia 6.2 & Nokia 6.1  ."
            echo "Please be patient..."
            # oxygen
            echo "----------------------------------------------"
            echo "Setting Up Tools & Stuff..."
            echo " "
            TOOLS_SETUP
	    echo " "	    
            echo "----------------------------------------------"
            echo "Setting up OxygenOS source..."
            echo " "
            OXYGEN-SOURCE
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
        "havoc")
            clear
            echo "----------------------------------------------"
            echo "Started Building Havoc-3.0 for Nokia 6.1 , 6.1plus & 7 plus  ."
            echo "Please be patient..."
            # havoc
            echo "----------------------------------------------"
            echo "Setting Up Tools & Stuff..."
            echo " "
            TOOLS_SETUP
	    echo " "	    
            echo "----------------------------------------------"
            echo "Setting up havoc source..."
            echo " "
            HAVOC-SOURCE
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
        "evox")
            clear
            echo "----------------------------------------------"
            echo "Started Building Evolution X for Nokia 6.1 , 6.1plus & 7 plus  ."
            echo "Please be patient..."
            # evox
            echo "----------------------------------------------"
            echo "Setting Up Tools & Stuff..."
            echo " "
            TOOLS_SETUP
	    echo " "	    
            echo "----------------------------------------------"
            echo "Setting up Evolution X source..."
            echo " "
            EVOX-SOURCE
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
            echo "Started Building LineageOS 17.0 , Pixel-Exp , Havoc & Twrp for Nokia 6.1 Plus , 7 plus , 6.1 , 6.2 & 7.2 ."
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
            echo "Setting up pe source..."
            echo " "
            HAVOC-SOURCE
	    echo " "	    
            echo "----------------------------------------------"
            echo "Setting up Evolution X source..."
            echo " "
            EVOX-SOURCE
	    echo " "	
            echo "----------------------------------------------"
            echo "Setting up OxygenOS source..."
            echo " "
            OXYGEN-SOURCE
	    echo " "		    
            echo "----------------------------------------------"
            echo "Setting up twrp P source..."
            echo " "
            TWRP-P-SOURCE
	    echo " "
            echo "----------------------------------------------"
            echo "Setting up twrp Q source..."
            echo " "
            TWRP-Q-SOURCE
	    echo " "	 
            echo "----------------------------------------------"
            echo "Setting up twrp Q ins..."
            echo " "
            TWRP-Q-INSTALLER
	    echo " "	
            echo "----------------------------------------------"
            echo "Setting up twrp P ins..."
            echo " "
            TWRP-P-INSTALLER
	    echo " "    
            echo "----------------------------------------------"
            echo "Setting up kiwis-kernel source..."
            echo " "
            KIWIS-SOURCE
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

    
