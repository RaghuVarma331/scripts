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

# Detail Versions

path=/var/lib/jenkins/workspace/DotOS

# credentials

Telegram_Api_code=$(cat $path/cred** | grep api | cut -d "=" -f 2)
chat_id=$(cat $path/cred** | grep id | cut -d "=" -f 2)
gitpassword=$(cat $path/cred** | grep git | cut -d "=" -f 2)


L1()
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

L2()
{
    cd $path
    mkdir bin
    PATH=$path/bin:$PATH
    curl https://storage.googleapis.com/git-repo-downloads/repo > $path/bin/repo
    chmod a+x $path/bin/repo
}

L3()
{
    cd $path
    mkdir dot
    cd dot
    echo -ne '\n' | repo init -u git://github.com/DotOS/manifest.git -b dot11 --depth=1
    repo sync
}

L3A()
{
    cd $path/dot
    rm -r external/bson
    rm -r system/qcom
    git clone https://github.com/LineageOS/android_external_bson.git -b lineage-18.1 external/bson
    git clone https://github.com/LineageOS/android_system_qcom.git -b lineage-18.1 system/qcom
} &> /dev/null

L4()
{
    cd $path/dot
    rm -r packages/apps/SystemUpdates
    git clone https://github.com/Nokia-SDM660/android_kernel_nokia_sdm660.git -b android-11.0-clang --depth=1 kernel/nokia/sdm660
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_device_nokia_Dragon -b android-11.0 device/nokia/Dragon
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_device_nokia_Onyx -b android-11.0 device/nokia/Onyx
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_device_nokia_Crystal -b android-11.0 device/nokia/Crystal
    git clone https://$gitpassword@github.com/Nokia-SDM660/android_device_nokia_Plate2 -b android-11.0 device/nokia/Plate2
    git clone https://$gitpassword@github.com/Nokia-SDM660/proprietary_vendor_nokia -b android-11.0 vendor/nokia
    git clone https://$gitpassword@github.com/Nokia-SDM660/proprietary_vendor_nokia_GoogleCamera -b android-11.0 vendor/nokia/GoogleCamera
} &> /dev/null

L5()
{
    cd $path/dot
    git clone https://$gitpassword@github.com/RaghuVarma331/proprietary_vendor_nokia_Os_Updates -b Dragon-Dot vendor/nokia/Os_Updates &> /dev/null
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch dot_Dragon-userdebug && make -j$(nproc --all) bacon
    cp -r out/target/product/*/dotOS**.zip $path
    rm -r out
    rm -r vendor/nokia/Os_Updates
    git clone https://$gitpassword@github.com/RaghuVarma331/proprietary_vendor_nokia_Os_Updates -b Onyx-Dot vendor/nokia/Os_Updates &> /dev/null
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch dot_Onyx-userdebug && make -j$(nproc --all) bacon
    cp -r out/target/product/*/dotOS**.zip $path
    rm -r out
    rm -r vendor/nokia/Os_Updates
    git clone https://$gitpassword@github.com/RaghuVarma331/proprietary_vendor_nokia_Os_Updates -b Crystal-Dot vendor/nokia/Os_Updates &> /dev/null
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch dot_Crystal-userdebug && make -j$(nproc --all) bacon
    cp -r out/target/product/*/dotOS**.zip $path
    rm -r out
    rm -r vendor/nokia/Os_Updates
    git clone https://$gitpassword@github.com/RaghuVarma331/proprietary_vendor_nokia_Os_Updates -b Plate2-Dot vendor/nokia/Os_Updates &> /dev/null
    export SELINUX_IGNORE_NEVERALLOWS=true
    . build/envsetup.sh && lunch dot_Plate2-userdebug && make -j$(nproc --all) bacon
    cp -r out/target/product/*/dotOS**.zip $path
    rm -r out
}

echo "----------------------------------------------------"
echo "Downloading tools.."
echo "----------------------------------------------------" 
L1
echo "----------------------------------------------------"
echo "Downloading repo bin.."
echo "----------------------------------------------------" 
L2
echo "----------------------------------------------------"
echo "Downloading DotOS Source Code.."
echo "----------------------------------------------------" 
L3
echo "----------------------------------------------------"
echo "Downloading Selinux Repos.."
echo "----------------------------------------------------" 
L3A
echo "----------------------------------------------------"
echo "Downloading Device sources.."
echo "----------------------------------------------------" 
L4
echo "----------------------------------------------------"
echo "Started building DotOS for DRG B2N CTL PL2."
echo "----------------------------------------------------" 
L5
echo "----------------------------------------------------"
echo "Successfully build completed.."
echo "----------------------------------------------------" 
