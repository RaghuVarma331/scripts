#!/bin/bash

Telegram_Api_code=
chat_id=
securitypatch=2022-05

wget https://github.com/RaghuVarma331/scripts/raw/master/pythonscripts/telegram.py
wget https://github.com/RaghuVarma331/custom_roms_banners/raw/master/pixel.jpg


python telegram.py -t $Telegram_Api_code -c $chat_id  -P pixel.jpg -C "
*$(date)

    New PixelExperience Build
    ================*
    ⬇️ [Download TWRP](https://forum.xda-developers.com/t/unofficial-twrp-3-6-2-11-0-team-win-recovery-project-moto-g60-g40.4453417/)
    ⬇️ [Download Rom](https://forum.xda-developers.com/t/rom-12-hanoip-pixelexperience-aosp-g60-g40.4449285/)
    💬 [Build changelog](https://github.com/RaghuVarma331/scripts/raw/master/Motorola-SM6150/PE-changelog.txt)
    💬 [Installation procedure](https://github.com/RaghuVarma331/scripts/raw/master/Motorola-SM6150/Installation.txt)
    📱Device: *Moto G60/G40*
    ⚡Android Version: *12L*
    ⚡Security Patch : *$securitypatch*
    👤 By: *@RaghuVarma*
    #g60 #g40 #moto #update
    Follow:  @MotoG60G40 ✅
"

