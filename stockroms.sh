clear
echo "----------------------------------------------------"
echo "A simple remote script to create your own stock rom"
echo "Coded By Raghu Varma.G "
echo "----------------------------------------------------"

Telegram_Api_code=
chat_id=
url=https://android.googleapis.com/packages/ota-api/nokia_drgsprout_dragon00ww/810351d123009ec07c1cb5857c4707fdeba776ef.zip
code=DRG
buildnumber=354H
androidversion=9.0
path=/root
password=
device=Nokia6.1Plus
securitypatch=2019-07-19
sourceforge=drg-sprout
channel=@Nokia6plusofficial

git clone https://github.com/RaghuVarma331/OTA2HB-Tool.git tool
cd tool
echo url=$url >> rv.sh
echo code=$code >> rv.sh
echo buildnumber=$buildnumber >> rv.sh
echo androidversion=$androidversion >> rv.sh
echo path=$path >> rv.sh
echo password=$password >> rv.sh
chmod a+x rv.sh
./rv.sh
cd 
cd $path
rm -r tool
      wget https://github.com/RaghuVarma331/scripts/raw/master/telegram.py
      wget https://github.com/RaghuVarma331/custom_roms_banners/raw/master/image.png
      python telegram.py -t $Telegram_Api_code -c $chat_id  -P image.png -C " 
      *
      New Stock Rom Maintenance Release
      Home Brew Build is up

      $(date)*

      ⬇️ [Download](https://sourceforge.net/projects/$sourceforge/files/STOCK-ROMS/)
      
      🔨 [Flash Tool](https://github.com/RaghuVarma331/Stock-Rom_Flash-Tool_Nokia/releases)

      💬 [Flashing procedure](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/crossdevelopment/installation.txt)

      📱Device: $device

      ⚡Build Version: $buildnumber

      ⚡Android Version: $androidversion

      ⚡Security Patch : $securitypatch

      👤 By: Nokia
                                                                                                                                                                              
      Follow:  $channel ✅"
