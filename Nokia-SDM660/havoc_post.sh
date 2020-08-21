#!/bin/bash


# TG stuff

Telegram_Api_code=
chat_id=

# Download Links

DRGV=https://bit.ly/3ggDCNZ
DRGG=https://bit.ly/2ErDwWp

B2NV=https://bit.ly/2Eli3Pc
B2NG=https://bit.ly/34kpfpF

PL2V=https://bit.ly/2CLYKhm
PL2G=https://bit.ly/32bOYxP

CTLV=https://bit.ly/34lAZIw
CTLG=https://bit.ly/3giCF7V

# Havoc Changelog

HV=v3.8
date=21-08-2020
changelog=https://t.me/Havoc_OS/2494
dchangelog="
• Build based on latest stable sources
• Improved system stability
• User interface enhancements
• Google Security Patch 2020-08
• Faceunlock support out of the box
• Comes with BlackCaps kernel
• Linux version 4.4.212
• System blobs based on 4.15C
• Vendor blobs based on 4.15C
• Camera blobs based on 4.150
• Updated fingerprint to August from coral
• Redumped configurations from 4.15C/D dumps
• Fixed low volume issues on 6+ (no issues for 7+ , 7.1 & 6.1)
• Fixed usb tethering
• Fixed network switch
• Updated power profile from stock 4.15C (DRG/CTL/PL2) 4.15D (B2N)
• Updated usb configuration props from stock
• Updated CarrierConfig from motorola Payton (latest stock rom)
• Safety net passed out of the box
• All banking apps will work
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
