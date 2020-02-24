#!/bin/sh
sourceforge=https://sourceforge.net/projects/drg-sprout/files/EvolutionX
filename=$(echo EvolutionX**.zip)
datetime=$(grep ro\.build\.date\.utc system/build.prop | cut -d= -f2)
size=$(stat -c%s $filename)
url=$sourceforge/$filename/download
filehash=$(cat **.md5sum | cut -d' ' -f1)
id=$(sha256sum $filename | awk '{ print $1 }');
error=false
donate_url=https://www.paypal.me/Raghu107
website_url=https://raghuvarma331.github.io
news_url=https://t.me/Nokia6plusofficial
maintainer=$(echo G.RaghuVarma [Unofficial])
forum_url=https://forum.xda-developers.com/nokia-6-1-plus/development/rom-evolution-x-3-3-t4011589
version=android-10.0


echo "{\n\"error\":$error,\n\"donate_url\":\"$donate_url\",\n\"website_url\":\"$website_url\",\n\"news_url\":\"$news_url\",\n\"maintainer\":\"$maintainer\",\n\"forum_url\":\"$forum_url\",\n\"version\":\"$version\",\n\"filename\":\"$filename\",\n\"datetime\":$datetime,\n\"size\":$size,\n\"url\":\"$url\",\n\"filehash\":\"$filehash\",\n\"id\":\"$id\"\n}" > $filename.json
