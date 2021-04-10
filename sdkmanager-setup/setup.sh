#!/bin/bash

echo "--------------------------------------------"
echo "Sit Back & Have A coffee "
echo "--------------------------------------------"
sudo apt install android-sdk
wget https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip
unzip commandlinetools-linux-6858069_latest.zip
cd cmdline-tools
cd bin
./sdkmanager --sdk_root=/usr/lib/android-sdk/ "platform-tools" "platforms;android-29"
echo "--------------------------------------------"
echo "Successfully completed "
echo "--------------------------------------------"
