#!/bin/bash


# TG stuff

Telegram_Api_code=
chat_id=

# Download Links

DRGV=
DRGG=

B2NV=
B2NG=

PL2V=
PL2G=

CTLV=
CTLG=

# Havoc Changelog

HV=v3.8
date=17-08-2020
changelog=https://t.me/Havoc_OS/2494
dchangelog="
• initial build
"


wget https://github.com/RaghuVarma331/scripts/raw/master/pythonscripts/telegram.py
python telegram.py -t $Telegram_Api_code -c $chat_id  -M"

*
=============================
     Havoc-OS $HV Official Update
                      Android 10
=============================
*

*Date: $date

Device: Nokia 6.1 Plus (Dragon)

Maintainer: @RaghuVarma

Changelog: $changelog

Device changelog:
$dchangelog

Download Link: 
• ROM (Vanilla): $DRGV
• ROM (GApps): $DRGG

XDA Thread Link: https://bit.ly/2E1kfeC
*
"

python telegram.py -t $Telegram_Api_code -c $chat_id  -M"

*
=============================
     Havoc-OS $HV Official Update
                      Android 10
=============================
*

*Date: $date

Device: Nokia 7 Plus (Onyx)

Maintainer: @RaghuVarma

Changelog: $changelog

Device changelog:
$dchangelog

Download Link: 
• ROM (Vanilla): $B2NV
• ROM (GApps): $B2NG

XDA Thread Link: https://bit.ly/3auKFRP
*
"

python telegram.py -t $Telegram_Api_code -c $chat_id  -M"

*
=============================
     Havoc-OS $HV Official Update
                      Android 10
=============================
*

*Date: $date

Device: Nokia 6.1 (Plate2)

Maintainer: @RaghuVarma

Changelog: $changelog

Device changelog:
$dchangelog

Download Link: 
• ROM (Vanilla): $PL2V
• ROM (GApps): $PL2G

XDA Thread Link: https://bit.ly/2E0Prux
*
"

python telegram.py -t $Telegram_Api_code -c $chat_id  -M"

*
=============================
     Havoc-OS $HV Official Update
                      Android 10
=============================
*

*Date: $date

Device: Nokia 7.1 (Crystal)

Maintainer: @RaghuVarma

Changelog: $changelog

Device changelog:
$dchangelog

Download Link: 
• ROM (Vanilla): $CTLV
• ROM (GApps): $CTLG

XDA Thread Link: https://bit.ly/2PZzjMd
*
"
