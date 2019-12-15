clear
echo "----------------------------------------------------"
echo "A simple remote script to create your own stock rom"
echo "Coded By Raghu Varma.G "
echo "----------------------------------------------------"

Telegram_Api_code=
chat_id=
url=
code=
buildnumber=
androidversion=
path=/root
password=
device=Nokia 6.1 Plus
securitypatch=

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
python telegram.py -t $Telegram_Api_code -c $chat_id  -P lineage.jpg -C "
*
New Stock Rom Maintenance Release Home Brew Build is up 
    
$(date)*
    
⬇️ [Download](https://forum.xda-developers.com)
    
💬 [Flashing procedure](https://raw.githubusercontent.com/RaghuVarma331/changelogs/master/crossdevelopment/installation.txt)
    
📱Device: $device
    
⚡Build Version: $buildnumber
    
⚡Android Version: $androidversion
    
⚡Security Patch : $securitypatch
    
👤 By: Nokia 
    
Follow:  @Nokia6plusofficial ✅"  
