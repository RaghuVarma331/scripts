#!/bin/bash

Telegram_Api_code=
chat_id=
securitypatch=2021-02

wget https://github.com/RaghuVarma331/scripts/raw/master/pythonscripts/telegram.py
wget https://raw.githubusercontent.com/ArrowOS/documentation/master/misc/logo.png

python telegram.py -t $Telegram_Api_code -c $chat_id  -P logo.png -C "
*$(date)

    New ArrowOS Build
    ================*
    ⬇️ [Download Recovery](https://sourceforge.net/projects/motorola-sm6150/files/G60/Recovery)
    ⬇️ [Download Rom](https://motorola-sm6150.github.io)
    💬 [Build changelog](https://github.com/RaghuVarma331/scripts/raw/master/Motorola-SM6150/ArrowOS-changelog.txt)
    💬 [Installation procedure](https://github.com/RaghuVarma331/scripts/raw/master/Motorola-SM6150/Installation.txt)
    📱Device: *Moto G60*
    ⚡Android Version: *11.0*
    ⚡Security Patch : *$securitypatch*
    👤 By: *@RaghuVarma*
    #g60 #moto #update
    Follow:  @MotoG60G40 ✅
"

