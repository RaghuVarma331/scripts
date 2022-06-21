#!/bin/bash

Telegram_Api_code=
chat_id=
version=3.6.2-12.1


    wget https://github.com/RaghuVarma331/scripts/raw/master/pythonscripts/telegram.py
    wget https://github.com/RaghuVarma331/custom_roms_banners/raw/master/twrp.jpg
    python telegram.py -t $Telegram_Api_code -c $chat_id  -P twrp.jpg -C "
    *
    New Twrp-$version build
    
    $(date)*
    
    ⬇️ [Download TWRP](https://forum.xda-developers.com/t/unofficial-twrp-3-6-2-11-0-team-win-recovery-project-moto-g60-g40.4453417/)
    📱Device: *Moto G60/G40*
    ⚡Build Version: *$version*
    👤 By: *@RaghuVarma*
    #g60 #g40 #twrp #update
    Follow:  @MotoG60G40 ✅" 
   
