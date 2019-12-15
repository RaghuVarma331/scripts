clear
echo "----------------------------------------------------"
echo "A simple remote script to create your own stock rom"
echo "Coded By Raghu Varma.G "
echo "----------------------------------------------------"

url=
code=
buildnumber=
androidversion=
path=/root
password=
chain=$$code
DRG=Nokia 6.1 Plus
CTL=Nokia 7.1
B2N=Nokia 7 Plus
PL2=Nokia 6.1
securitypatch=

git clone https://github.com/RaghuVarma331/OTA2HB-Tool.git tool
cd tool
sed -i "/url/d" make.sh
sed -i "/code/d" make.sh
sed -i "/buildnumber/d" make.sh
sed -i "/androidversion/d" make.sh
sed -i "/path/d" make.sh
sed -i "/password/d" make.sh

echo url=$url >> make.sh
echo code=$code >> make.sh
echo buildnumber=$buildnumber >> make.sh
echo androidversion=$androidversion >> make.sh
echo path=$path >> make.sh
echo password=$password >> make.sh
chmod a+x make.sh
./make.sh
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
    
📱Device: $chain
    
⚡Build Version: $buildnumber
    
⚡Android Version: $androidversion
    
⚡Security Patch : $securitypatch
    
👤 By: Nokia 
    
Follow:  @Nokia6plusofficial ✅"  
