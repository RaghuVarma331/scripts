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

# Detail Versions

path=/var/lib/jenkins/workspace/Raghu
twrpsp='2020-04-05'
securitypatch=2020-04-05

# credentials

Telegram_Api_code=$(cat $path/cred** | grep api | cut -d "=" -f 2)
chat_id=$(cat $path/cred** | grep id | cut -d "=" -f 2)
password=$(cat $path/cred** | grep sf | cut -d "=" -f 2)
gitpassword=$(cat $path/cred** | grep git | cut -d "=" -f 2)



# Init Methods


REPO()
{
       mkdir bin
       PATH=$path/bin:$PATH
       curl https://storage.googleapis.com/git-repo-downloads/repo > $path/bin/repo
       chmod a+x $path/bin/repo
}



TWRP-P-SOURCE()
{
    wget  https://github.com/RaghuVarma331/scripts/raw/master/pythonscripts/telegram.py
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
    . build/envsetup.sh && lunch omni_DRG_sprout-eng && make -j32 recoveryimage
    . build/envsetup.sh && lunch omni_B2N_sprout-eng && make -j32 recoveryimage	
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
    git clone https://github.com/RaghuVarma331/android_device_nokia_DDV_sprout-TWRP.git -b android-10.0 device/nokia/DDV_sprout
    sed -i "91i PLATFORM_SECURITY_PATCH := $twrpsp" device/nokia/DDV_sprout/BoardConfig.mk
    git clone https://github.com/RaghuVarma331/android_device_nokia_SLD_sprout-TWRP.git -b android-10.0 device/nokia/SLD_sprout
    sed -i "91i PLATFORM_SECURITY_PATCH := $twrpsp" device/nokia/SLD_sprout/BoardConfig.mk    
    . build/envsetup.sh && lunch omni_DRG_sprout-eng && make -j32 recoveryimage	
    . build/envsetup.sh && lunch omni_B2N_sprout-eng && make -j32 recoveryimage
    . build/envsetup.sh && lunch omni_CTL_sprout-eng && make -j32 recoveryimage
    . build/envsetup.sh && lunch omni_SLD_sprout-eng && make -j32 recoveryimage	
    . build/envsetup.sh && lunch omni_DDV_sprout-eng && make -j32 recoveryimage    
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
    cd out/target/product/SLD_sprout
    mv recovery.img twrp-3.3.1-0-SLD_sprout-10.0-$(date +"%Y%m%d").img
    cp -r twrp-3.3.1-0-SLD_sprout-10.0-$(date +"%Y%m%d").img $path/SLD_sprout
    cd
    cd $path/twrp	
    cd out/target/product/DDV_sprout
    mv recovery.img twrp-3.3.1-0-DDV_sprout-10.0-$(date +"%Y%m%d").img
    cp -r twrp-3.3.1-0-DDV_sprout-10.0-$(date +"%Y%m%d").img $path/DDV_sprout    
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
    sshpass -p $password rsync -avP -e ssh twrp-3.3.1-0-SLD_sprout-10.0* raghuvarma331@frs.sourceforge.net:/home/frs/project/sld-sprout/TWRP/TEN/2020-04-05
    cd ..
    cd DDV_sprout
    sshpass -p $password rsync -avP -e ssh twrp-3.3.1-0-DDV_sprout-10.0* raghuvarma331@frs.sourceforge.net:/home/frs/project/ddv-sprout/TWRP/TEN/2020-04-05
    cd .. 
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "
    *
    New Android 10.0 Twrp-3.3.1-0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-6-1-plus/development/recovery-twrp-3-2-3-0-team-win-recovery-t3893909)
    📱Device: *Nokia 6.1 Plus*
    ⚡Build Version: *3.3.1-0*
    ⚡Android Version: *10.0.0*
    👤 By: *Raghu Varma*
    #drg #nokia #twrp #update
    Follow:  @Nokia6plusofficial ✅"  

    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "
    *
    New Android 10.0 Twrp-3.3.1-0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-1/development/twrp-3-2-3-0-team-win-recovery-project-t3935859)
    📱Device: *Nokia 7.1*
    ⚡Build Version: *3.3.1-0*
    ⚡Android Version: *10.0.0*
    👤 By: *Raghu Varma*
    #ctl #nokia #twrp #update
    Follow: @nokia7161 ✅"          
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "
    *
    New Android 10.0 Twrp-3.3.1-0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-plus/development/twrp-3-3-1-0-team-win-recovery-project-t3940223)
    📱Device: *Nokia 7 Plus (OOB)*
    ⚡Build Version: *3.3.1-0*
    ⚡Android Version: *10.0.0*
    👤 By: *Raghu Varma*
    #b2n #nokia #twrp #update
    Follow:  @Nokia7plusOfficial ✅" 
    
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "
    *
    New Android 10.0 Twrp-3.3.1-0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-plus/development/twrp-3-3-1-0-team-win-recovery-project-t3940223)
    📱Device: *Nokia 7 Plus (POB)*
    ⚡Build Version: *3.3.1-0*
    ⚡Android Version: *10.0.0*
    👤 By: *Raghu Varma*
    #b2n #nokia #twrp #update
    Follow:  @Nokia7plusOfficial ✅" 
    
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "    
    *
    New Android 9.0 Twrp-3.3.1-0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-6-1-plus/development/recovery-twrp-3-2-3-0-team-win-recovery-t3893909)
    📱Device: *Nokia 6.1 Plus*
    ⚡Build Version: *3.3.1-0*
    ⚡Android Version: *9.0.0*
    👤 By: *Raghu Varma*
    #drg #nokia #twrp #update
    Follow:  @Nokia6plusofficial ✅"  
    
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "
    *
    New Android 9.0 Twrp-3.3.1-0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-plus/development/twrp-3-3-1-0-team-win-recovery-project-t3940223)
    📱Device: *Nokia 7 Plus (OOB)*
    ⚡Build Version: *3.3.1-0*
    ⚡Android Version: *9.0.0*
    👤 By: *Raghu Varma*
    #b2n #nokia #twrp #update
    Follow:  @Nokia7plusOfficial ✅" 
    
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "
    *
    New Android 9.0 Twrp-3.3.1-0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-plus/development/twrp-3-3-1-0-team-win-recovery-project-t3940223)
    📱Device: *Nokia 7 Plus (POB)*
    ⚡Build Version: *3.3.1-0*
    ⚡Android Version: *9.0.0*
    👤 By: *Raghu Varma*
    #b2n #nokia #twrp #update
    Follow:  @Nokia7plusOfficial ✅"  

    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "
    *
    New Android 10.0 Twrp-3.3.1-0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-6-2/development/unofficial-twrp-3-3-1-0-team-win-t3999433)
    📱Device: *Nokia 6.2*
    ⚡Build Version: *3.3.1-0*
    ⚡Android Version: *10.0.0*
    ⚡Android Security Patch : *$twrpsp*
    👤 By: *Raghu Varma*
    #sld #nokia #twrp #update
    Follow:  @Nokia7262 ✅"     
    
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "
    *
    New Android 10.0 Twrp-3.3.1-0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-2/development/unofficial-twrp-3-3-1-0-team-win-t3999325)
    📱Device: *Nokia 7.2*
    ⚡Build Version: *3.3.1-0*
    ⚡Android Version: *10.0.0*
    ⚡Android Security Patch : *$twrpsp*
    👤 By: *Raghu Varma*
    #ddv #nokia #twrp #update
    Follow:  @Nokia7262 ✅"  
    
}


clear
REPO
TWRP-P-SOURCE
TWRP-Q-SOURCE
TWRP-Q-INSTALLER
TWRP-P-INSTALLER
