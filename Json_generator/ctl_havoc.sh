#!/bin/sh

devicecode=Crystal
sourceforge=https://sourceforge.net/projects/ctl-sprout/files/Havoc-OS

datetime=$(grep ro\.build\.date\.utc system/build.prop | cut -d= -f2)
version=android-10.0
romtype=UNOFFICIAL
zipname=$(echo Havoc-OS**.zip)
url=$sourceforge/$zipname/download
id=$(cat "$zipname.md5sum" | cut -d' ' -f1)
echo "{\n\"response\": [\n{\n   \"datetime\": \"$datetime\",\n   \"filename\": \"$zipname\",\n   \"id\": \"$id\",\n   \"romtype\": \"UNOFFICIAL\",\n   \"size\": $(stat -c%s Havoc-OS**.zip),\n   \"url\": \"$url\",\n   \"version\": \"$version\"\n}\n]\n}" > $zipname.json

