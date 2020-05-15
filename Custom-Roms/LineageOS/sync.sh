#!/bin/bash


path=/var/lib/jenkins/workspace/LineageOS


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
       rm -r bin
       mkdir bin
       PATH=$path/bin:$PATH
       curl https://storage.googleapis.com/git-repo-downloads/repo > $path/bin/repo
       chmod a+x $path/bin/repo
       git config --global user.email "raghuvarma331@gmail.com"
       git config --global user.name "RaghuVarma331"
} &> /dev/null

LINEAGE-SOURCE()

{
    mkdir los
    cd los
    echo -ne '\n' | repo init -u git://github.com/LineageOS/android.git -b lineage-17.1 --depth=1
    repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
    rm -r vendor/lineage
    git clone https://github.com/LineageOS/android_vendor_lineage.git -b lineage-17.1 vendor/lineage
    sed -i "/ro.control_privapp_permissions=enforce/d" vendor/lineage/config/common.mk
    cd $path
}

echo Setting up tools..!!
TOOLS_SETUP

echo downloading repo..!!
REPO

echo Downloading LineageOS Source Code..!!
LINEAGE-SOURCE
