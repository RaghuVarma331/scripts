#!/bin/bash

Telegram_Api_code=
chat_id=@MotoG60G40
AV=14.0
securitypatch=2024-02

wget https://github.com/RaghuVarma331/scripts/raw/master/pythonscripts/telegram.py
wget https://github.com/RaghuVarma331/custom_roms_banners/raw/master/pixel.jpg


python telegram.py -t $Telegram_Api_code -c $chat_id  -P pixel.jpg -C "
*$(date)

    🔥 New PixelExperience Build
    ================*
    ⬇️ [Download TWRP](https://forum.xda-developers.com/t/unofficial-twrp-3-6-2-11-0-team-win-recovery-project-moto-g60-g40.4453417/)
    ⬇️ [Download Rom](https://forum.xda-developers.com/t/rom-13-0-hanoip-pixelexperience-aosp-g60-g40f.4449285/)
    💬 [Installation procedure](https://github.com/RaghuVarma331/scripts/raw/master/Motorola-SM6150/Installation.txt)
    📱Device: *Moto G60/G40F*
    ⚡Android Version: *$AV*
    ⚡Security Patch : *$securitypatch*
    👤 By: *@RaghuVarma*
    #g60 #g40f #pe #update
    Follow:  @MotoG60G40 ✅
"
