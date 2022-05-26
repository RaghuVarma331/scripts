#!/bin/bash

Telegram_Api_code=
chat_id=
securitypatch=2022-05

wget https://github.com/RaghuVarma331/scripts/raw/master/pythonscripts/telegram.py
wget https://github.com/RaghuVarma331/custom_roms_banners/raw/master/lineage.jpg


python telegram.py -t $Telegram_Api_code -c $chat_id  -P lineage.jpg -C "
*$(date)
    New LineageOS 19.1 Build
    ================*
    ⬇️ [Download Recovery](https://sourceforge.net/projects/motorola-sm6150/files/G60/Recovery)
    ⬇️ [Download Rom](https://forum.xda-developers.com/t/rom-12-hanoip-lineageos-19-1-aosp-g60-g40.4450789/)
    💬 [Build changelog](https://github.com/RaghuVarma331/scripts/raw/master/Motorola-SM6150/LOS-changelog.txt)
    💬 [Installation procedure](https://github.com/RaghuVarma331/scripts/raw/master/Motorola-SM6150/Installation.txt)
    📱Device: *Moto G60/G40*
    ⚡Android Version: *12L*
    ⚡Security Patch : *$securitypatch*
    👤 By: *@RaghuVarma*
    #g60 #g40 #moto #update
    Follow:  @MotoG60G40 ✅
"

