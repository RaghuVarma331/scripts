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
twrpsp='2020-07-05'
securitypatch=2020-07-05

# credentials

Telegram_Api_code=$(cat $path/cred** | grep api | cut -d "=" -f 2)
chat_id=$(cat $path/cred** | grep id | cut -d "=" -f 2)
password=$(cat $path/cred** | grep sf | cut -d "=" -f 2)
gitpassword=$(cat $path/cred** | grep git | cut -d "=" -f 2)



# Init Methods

TOOLS_SETUP() 
{
        sudo apt-get update 
        echo -ne '\n' | sudo apt-get upgrade
        echo -ne '\n' | sudo apt-get install git ccache schedtool lzop bison gperf build-essential zip curl zlib1g-dev g++-multilib python-networkx libxml2-utils bzip2 libbz2-dev libghc-bzlib-dev squashfs-tools pngcrush liblz4-tool optipng libc6-dev-i386 gcc-multilib libssl-dev gnupg flex lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev xsltproc unzip python-pip python-dev libffi-dev libxml2-dev libxslt1-dev libjpeg8-dev openjdk-8-jdk imagemagick device-tree-compiler mailutils-mh expect python3-requests python-requests android-tools-fsutils sshpass
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
} &> /dev/null




REPO()
{
       cd $path
       mkdir bin
       PATH=$path/bin:$PATH
       curl https://storage.googleapis.com/git-repo-downloads/repo > $path/bin/repo
       chmod a+x $path/bin/repo
} &> /dev/null


TWRP-Q-SOURCE()
{
    cd $path
    wget  https://github.com/RaghuVarma331/scripts/raw/master/pythonscripts/telegram.py
    wget https://github.com/RaghuVarma331/custom_roms_banners/raw/master/twrp.jpg
    mkdir DRG_sprout
    mkdir B2N_sprout	
    mkdir DDV_sprout
    mkdir SLD_sprout
    mkdir CTL_sprout
    mkdir PNX_sprout
    mkdir PL2_sprout
    mkdir twrp
    cd twrp
    echo -ne '\n' | repo init -u git://github.com/LineageOS/android.git -b lineage-16.0 --depth=1
    repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
    rm -r bootable/recovery
    rm -r system/core
    git clone https://github.com/RaghuVarma331/android_system_core.git -b android-9.0 system/core
    git clone https://github.com/RaghuVarma331/external_magisk-prebuilt.git -b master external/magisk-prebuilt
    git clone https://github.com/TeamWin/android_bootable_recovery.git -b android-9.0 bootable/recovery	
    git clone https://github.com/Nokia-SDM660/android_device_nokia_DRG_sprout-TWRP.git -b android-10.0 device/nokia/DRG_sprout
    git clone https://github.com/Nokia-SDM660/android_device_nokia_B2N_sprout-TWRP.git -b android-10.0 device/nokia/B2N_sprout
    git clone https://github.com/Nokia-SDM660/android_device_nokia_CTL_sprout-TWRP.git -b android-10.0 device/nokia/CTL_sprout
    git clone https://github.com/Nokia-SDM660/android_device_nokia_PL2_sprout-TWRP.git -b android-10.0 device/nokia/PL2_sprout
    git clone https://github.com/Nokia-SDM660/android_device_nokia_PNX_sprout-TWRP.git -b android-10.0 device/nokia/PNX_sprout
    sed -i "74i PLATFORM_SECURITY_PATCH := $twrpsp" device/nokia/PNX_sprout/BoardConfig.mk	
    git clone https://github.com/Nokia-SDM660/android_device_nokia_DDV_sprout-TWRP.git -b android-10.0 device/nokia/DDV_sprout
    sed -i "90i PLATFORM_SECURITY_PATCH := $twrpsp" device/nokia/DDV_sprout/BoardConfig.mk
    git clone https://github.com/Nokia-SDM660/android_device_nokia_SLD_sprout-TWRP.git -b android-10.0 device/nokia/SLD_sprout
    sed -i "90i PLATFORM_SECURITY_PATCH := $twrpsp" device/nokia/SLD_sprout/BoardConfig.mk    
    . build/envsetup.sh && lunch lineage_DRG_sprout-eng && make -j32 recoveryimage	
    . build/envsetup.sh && lunch lineage_B2N_sprout-eng && make -j32 recoveryimage
    . build/envsetup.sh && lunch lineage_CTL_sprout-eng && make -j32 recoveryimage
    . build/envsetup.sh && lunch lineage_SLD_sprout-eng && make -j32 recoveryimage	
    . build/envsetup.sh && lunch lineage_DDV_sprout-eng && make -j32 recoveryimage    
    . build/envsetup.sh && lunch lineage_PL2_sprout-eng && make -j32 recoveryimage	
    . build/envsetup.sh && lunch lineage_PNX_sprout-eng && make -j32 recoveryimage  	
    cd out/target/product/DRG_sprout
    mv recovery.img twrp-3.4.0-0-DRG_sprout-10.0-$(date +"%Y%m%d").img
    cp -r twrp-3.4.0-0-DRG_sprout-10.0-$(date +"%Y%m%d").img $path/DRG_sprout
    cd
    cd $path/twrp
    cd out/target/product/CTL_sprout
    mv recovery.img twrp-3.4.0-0-CTL_sprout-10.0-$(date +"%Y%m%d").img
    cp -r twrp-3.4.0-0-CTL_sprout-10.0-$(date +"%Y%m%d").img $path/CTL_sprout
    cd
    cd $path/twrp    
    cd out/target/product/B2N_sprout
    mv recovery.img twrp-3.4.0-0-B2N_sprout-OOB-10.0-$(date +"%Y%m%d").img
    cp -r twrp-3.4.0-0-B2N_sprout-OOB-10.0-$(date +"%Y%m%d").img $path/B2N_sprout
    cd
    cd $path/twrp	
    cd out/target/product/SLD_sprout
    mv recovery.img twrp-3.4.0-0-SLD_sprout-10.0-$(date +"%Y%m%d").img
    cp -r twrp-3.4.0-0-SLD_sprout-10.0-$(date +"%Y%m%d").img $path/SLD_sprout
    cd
    cd $path/twrp	
    cd out/target/product/DDV_sprout
    mv recovery.img twrp-3.4.0-0-DDV_sprout-10.0-$(date +"%Y%m%d").img
    cp -r twrp-3.4.0-0-DDV_sprout-10.0-$(date +"%Y%m%d").img $path/DDV_sprout    
    cd
    cd $path/twrp	
    cd out/target/product/PNX_sprout
    mv recovery.img twrp-3.4.0-0-PNX_sprout-10.0-$(date +"%Y%m%d").img
    cp -r twrp-3.4.0-0-PNX_sprout-10.0-$(date +"%Y%m%d").img $path/PNX_sprout 
    cd
    cd $path/twrp	
    cd out/target/product/PL2_sprout
    mv recovery.img twrp-3.4.0-0-PL2_sprout-10.0-$(date +"%Y%m%d").img
    cp -r twrp-3.4.0-0-PL2_sprout-10.0-$(date +"%Y%m%d").img $path/PL2_sprout       	
    cd
    cd $path/twrp
    rm -r device/nokia
    rm -r out
    git clone https://github.com/Nokia-SDM660/android_device_nokia_B2N_sprout-TWRP.git -b android-10.0-NB device/nokia/B2N_sprout
    . build/envsetup.sh && lunch lineage_B2N_sprout-eng && make -j32 recoveryimage	
    cd out/target/product/B2N_sprout
    mv recovery.img twrp-3.4.0-0-B2N_sprout-POB-10.0-$(date +"%Y%m%d").img
    cp -r twrp-3.4.0-0-B2N_sprout-POB-10.0-$(date +"%Y%m%d").img $path/B2N_sprout
    cd
    cd $path  

}

TWRP-Q-INSTALLER()
{
    cd $path
    cd twrp
    rm -r out
    rm -r device/nokia
    git clone https://github.com/Nokia-SDM660/android_device_nokia_DRG_sprout-TWRP.git -b android-10.0 device/nokia/DRG_sprout
    git clone https://github.com/Nokia-SDM660/android_device_nokia_B2N_sprout-TWRP.git -b android-10.0 device/nokia/B2N_sprout	
    git clone https://github.com/Nokia-SDM660/android_device_nokia_CTL_sprout-TWRP.git -b android-10.0 device/nokia/CTL_sprout
    git clone https://github.com/Nokia-SDM660/android_device_nokia_PL2_sprout-TWRP.git -b android-10.0 device/nokia/PL2_sprout	
    sed -i "/ro.build.version.security_patch/d" build/tools/buildinfo.sh
    . build/envsetup.sh && lunch lineage_DRG_sprout-eng && make -j32 recoveryimage
    . build/envsetup.sh && lunch lineage_B2N_sprout-eng && make -j32 recoveryimage
    . build/envsetup.sh && lunch lineage_CTL_sprout-eng && make -j32 recoveryimage  
    . build/envsetup.sh && lunch lineage_PL2_sprout-eng && make -j32 recoveryimage 
    cd out/target/product/DRG_sprout
    mv ramdisk-recovery.cpio ramdisk-twrp.cpio
    cp -r ramdisk-twrp.cpio $path/twrp/device/nokia/DRG_sprout/installer
    cd
    cd $path/twrp/device/nokia/DRG_sprout/installer
    zip -r twrp-installer-3.4.0-0-DRG_sprout-10.0-$(date +"%Y%m%d").zip magiskboot  META-INF ramdisk-twrp.cpio
    cp -r twrp-installer-3.4.0-0-DRG_sprout-10.0-$(date +"%Y%m%d").zip $path/DRG_sprout  
    cd
    cd $path/twrp
    cd out/target/product/CTL_sprout
    mv ramdisk-recovery.cpio ramdisk-twrp.cpio
    cp -r ramdisk-twrp.cpio $path/twrp/device/nokia/CTL_sprout/installer
    cd
    cd $path/twrp/device/nokia/CTL_sprout/installer
    zip -r twrp-installer-3.4.0-0-CTL_sprout-10.0-$(date +"%Y%m%d").zip magiskboot  META-INF ramdisk-twrp.cpio
    cp -r twrp-installer-3.4.0-0-CTL_sprout-10.0-$(date +"%Y%m%d").zip $path/CTL_sprout  
    cd
    cd $path/twrp
    cd out/target/product/PL2_sprout
    mv ramdisk-recovery.cpio ramdisk-twrp.cpio
    cp -r ramdisk-twrp.cpio $path/twrp/device/nokia/PL2_sprout/installer
    cd
    cd $path/twrp/device/nokia/PL2_sprout/installer
    zip -r twrp-installer-3.4.0-0-PL2_sprout-10.0-$(date +"%Y%m%d").zip magiskboot  META-INF ramdisk-twrp.cpio
    cp -r twrp-installer-3.4.0-0-PL2_sprout-10.0-$(date +"%Y%m%d").zip $path/PL2_sprout  	
    cd
    cd $path/twrp    
    cd out/target/product/B2N_sprout
    mv ramdisk-recovery.cpio ramdisk-twrp.cpio
    cp -r ramdisk-twrp.cpio $path/twrp/device/nokia/B2N_sprout/installer
    cd
    cd $path/twrp/device/nokia/B2N_sprout/installer
    zip -r twrp-installer-3.4.0-0-B2N_sprout-OOB-10.0-$(date +"%Y%m%d").zip magiskboot  META-INF ramdisk-twrp.cpio
    cp -r twrp-installer-3.4.0-0-B2N_sprout-OOB-10.0-$(date +"%Y%m%d").zip $path/B2N_sprout  
    cd
    cd $path/twrp
    rm -r out
    rm -r device/nokia
    git clone https://github.com/Nokia-SDM660/android_device_nokia_B2N_sprout-TWRP.git -b android-10.0-NB device/nokia/B2N_sprout	
    . build/envsetup.sh && lunch lineage_B2N_sprout-eng && make -j32 recoveryimage  
    cd out/target/product/B2N_sprout
    mv ramdisk-recovery.cpio ramdisk-twrp.cpio
    cp -r ramdisk-twrp.cpio $path/twrp/device/nokia/B2N_sprout/installer
    cd
    cd $path/twrp/device/nokia/B2N_sprout/installer
    zip -r twrp-installer-3.4.0-0-B2N_sprout-POB-10.0-$(date +"%Y%m%d").zip magiskboot  META-INF ramdisk-twrp.cpio
    cp -r twrp-installer-3.4.0-0-B2N_sprout-POB-10.0-$(date +"%Y%m%d").zip $path/B2N_sprout  
    cd
    cd $path    
}

UPLOAD()
{
    cd $path
    cd PNX_sprout
    sshpass -p $password rsync -avP -e ssh twrp-3.4.0-0-PNX_sprout-10.0* raghuvarma331@frs.sourceforge.net:/home/frs/project/pnx-sprout/TWRP/TEN

    cd $path	
    cd PL2_sprout
    sshpass -p $password rsync -avP -e ssh twrp-3.4.0-0-PL2_sprout-10.0* twrp-installer-3.4.0-0-PL2_sprout-10.0* raghuvarma331@frs.sourceforge.net:/home/frs/project/pl2-sprout/TWRP/TEN

    cd $path
    cd CTL_sprout
    sshpass -p $password rsync -avP -e ssh twrp-3.4.0-0-CTL_sprout-10.0* twrp-installer-3.4.0-0-CTL_sprout-10.0* raghuvarma331@frs.sourceforge.net:/home/frs/project/ctl-sprout/TWRP/TEN
 
    cd $path 
    cd DRG_sprout
    sshpass -p $password rsync -avP -e ssh twrp-3.4.0-0-DRG_sprout-10.0* twrp-installer-3.4.0-0-DRG_sprout-10.0* raghuvarma331@frs.sourceforge.net:/home/frs/project/drg-sprout/TWRP/TEN

    cd $path
    cd B2N_sprout
    sshpass -p $password rsync -avP -e ssh twrp-3.4.0-0-B2N_sprout-OOB-10.0* twrp-installer-3.4.0-0-B2N_sprout-OOB-10.0* raghuvarma331@frs.sourceforge.net:/home/frs/project/b2n-sprout/TWRP-TEN/OOB
    sshpass -p $password rsync -avP -e ssh twrp-3.4.0-0-B2N_sprout-POB-10.0* twrp-installer-3.4.0-0-B2N_sprout-POB-10.0* raghuvarma331@frs.sourceforge.net:/home/frs/project/b2n-sprout/TWRP-TEN/POB

    cd $path
    cd SLD_sprout 
    sshpass -p $password rsync -avP -e ssh twrp-3.4.0-0-SLD_sprout-10.0* raghuvarma331@frs.sourceforge.net:/home/frs/project/sld-sprout/TWRP/TEN/2020-07-05

    cd $path
    cd DDV_sprout
    sshpass -p $password rsync -avP -e ssh twrp-3.4.0-0-DDV_sprout-10.0* raghuvarma331@frs.sourceforge.net:/home/frs/project/ddv-sprout/TWRP/TEN/2020-07-05

    cd $path
	
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "
    *
    New Android 10.0 Twrp-3.4.0-0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-6-1-plus/development/recovery-twrp-3-2-3-0-team-win-recovery-t3893909)
    📱Device: *Nokia 6.1 Plus*
    ⚡Build Version: *3.4.0-0*
    ⚡Android Version: *10.0.0*
    👤 By: *@RaghuVarma*
    #drg #nokia #twrp #update
    Follow:  @Nokia6plusofficial ✅"  

    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "
    *
    New Android 10.0 Twrp-3.4.0-0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-1/development/twrp-3-2-3-0-team-win-recovery-project-t3935859)
    📱Device: *Nokia 7.1*
    ⚡Build Version: *3.4.0-0*
    ⚡Android Version: *10.0.0*
    👤 By: *@RaghuVarma*
    #ctl #nokia #twrp #update
    Follow: @nokia7161 ✅"          
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "
    *
    New Android 10.0 Twrp-3.4.0-0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-plus/development/twrp-3-3-1-0-team-win-recovery-project-t3940223)
    📱Device: *Nokia 7 Plus (OOB)*
    ⚡Build Version: *3.4.0-0*
    ⚡Android Version: *10.0.0*
    👤 By: *@RaghuVarma*
    #b2n #nokia #twrp #update
    Follow:  @Nokia7plusOfficial ✅" 
    
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "
    *
    New Android 10.0 Twrp-3.4.0-0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-plus/development/twrp-3-3-1-0-team-win-recovery-project-t3940223)
    📱Device: *Nokia 7 Plus (POB)*
    ⚡Build Version: *3.4.0-0*
    ⚡Android Version: *10.0.0*
    👤 By: *@RaghuVarma*
    #b2n #nokia #twrp #update
    Follow:  @Nokia7plusOfficial ✅" 
    

    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "
    *
    New Android 10.0 Twrp-3.4.0-0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-6-2/development/unofficial-twrp-3-3-1-0-team-win-t3999433)
    📱Device: *Nokia 6.2*
    ⚡Build Version: *3.4.0-0*
    ⚡Android Version: *10.0.0*
    ⚡Android Security Patch : *$twrpsp*
    👤 By: *@RaghuVarma*
    #sld #nokia #twrp #update
    Follow:  @Nokia7262 ✅"     
    
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "
    *
    New Android 10.0 Twrp-3.4.0-0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-7-2/development/unofficial-twrp-3-3-1-0-team-win-t3999325)
    📱Device: *Nokia 7.2*
    ⚡Build Version: *3.4.0-0*
    ⚡Android Version: *10.0.0*
    ⚡Android Security Patch : *$twrpsp*
    👤 By: *@RaghuVarma*
    #ddv #nokia #twrp #update
    Follow:  @Nokia7262 ✅"  
	
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "
    *
    New Android 10.0 Twrp-3.4.0-0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://sourceforge.net/projects/pl2-sprout/files/TWRP/TEN/)
    📱Device: *Nokia 6.1*
    ⚡Build Version: *3.4.0-0*
    ⚡Android Version: *10.0.0*
    ⚡Android Security Patch : *$twrpsp*
    👤 By: *@RaghuVarma*
    #pl2 #nokia #twrp #update
    Follow:  @nokia7161 ✅" 

    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "
    *
    New Android 10.0 Twrp-3.4.0-0 Build is up 
    
    $(date)*
    
    ⬇️ [Download](https://forum.xda-developers.com/nokia-8-1/development/unofficial-twrp-3-3-1-0-team-win-t4090773)
    📱Device: *Nokia 8.1*
    ⚡Build Version: *3.4.0-0*
    ⚡Android Version: *10.0.0*
    ⚡Android Security Patch : *$twrpsp*
    👤 By: *@RaghuVarma*
    #pnx #nokia #twrp #update"   	
    
    cd $path
    rm -r *
    
} &> /dev/null


echo Setting up tools..!!
TOOLS_SETUP
echo downloading repo..!!
REPO
echo "-----------------------------------------------------"
echo "Started building TWRP-3.4.0-0 For DRG B2N CTL DDV SLD"
echo "-----------------------------------------------------" 
TWRP-Q-SOURCE
TWRP-Q-INSTALLER
echo "----------------------------------------------------"
echo " builds successfully completed" 
echo "----------------------------------------------------" 

echo "----------------------------------------------------"
echo "Started Uploading builds to sourceforge..!!"
echo "----------------------------------------------------" 
UPLOAD
echo "----------------------------------------------------"
echo " builds successfully Uploaded" 
echo "----------------------------------------------------" 

