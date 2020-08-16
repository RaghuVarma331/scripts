#!/bin/bash


# TG stuff

Telegram_Api_code=
chat_id=

# Havoc stuff

date=17-08-2020
changelog=https://t.me/Havoc_OS/2494
DRGL=
B2NL=
CTLL=
PL2L=
dchangelog="
• initial build
"


wget https://github.com/RaghuVarma331/scripts/raw/master/pythonscripts/telegram.py
python telegram.py -t $Telegram_Api_code -c $chat_id  -M"

*
=============================
     Havoc-OS v3.8 Official Update
                      Android 10
=============================
*

*Date: $date

Device: Nokia 6.1 Plus (Dragon)

Maintainer: @RaghuVarma

Changelog: $changelog

Device changelog:
$dchangelog

Download Link: $DRGL
*
"

python telegram.py -t $Telegram_Api_code -c $chat_id  -M"

*
=============================
     Havoc-OS v3.8 Official Update
                      Android 10
=============================
*

*Date: $date

Device: Nokia 7 Plus (Onyx)

Maintainer: @RaghuVarma

Changelog: $changelog

Device changelog:
$dchangelog

Download Link: $B2NL
*
"

python telegram.py -t $Telegram_Api_code -c $chat_id  -M"

*
=============================
     Havoc-OS v3.8 Official Update
                      Android 10
=============================
*

*Date: $date

Device: Nokia 6.1 (Plate2)

Maintainer: @RaghuVarma

Changelog: $changelog

Device changelog:
$dchangelog

Download Link: $PL2L
*
"

python telegram.py -t $Telegram_Api_code -c $chat_id  -M"

*
=============================
     Havoc-OS v3.8 Official Update
                      Android 10
=============================
*

*Date: $date

Device: Nokia 7.1 (Crystal)

Maintainer: @RaghuVarma

Changelog: $changelog

Device changelog:
$dchangelog

Download Link: $CTLL
*
"
