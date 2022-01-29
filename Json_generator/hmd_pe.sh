wget https://github.com/RaghuVarma331/scripts/raw/master/changelogs/changelog.txt
ip=http://ip:3000
rm -r **.md5sum
rm -r **.json
md5sum PixelExperience**.zip > pe.md5sum
unzip PixelExperience**.zip
sourceforge=$ip/roms
filename=$(echo PixelExperience**.zip)
datetime=$(grep post-timestamp META-INF/com/android/metadata | cut -d= -f2)
size=$(stat -c%s $filename)
url=$sourceforge/$filename
filehash=$(cat **.md5sum | cut -d' ' -f1)
id=$(sha256sum $filename | awk '{ print $1 }');
version=android-12.0
path=$(pwd)
whatsNew=$(cat $path/changelog.txt)
notification=$(echo New PixelExperience Update)
echo { >> $filename.json
echo \"version\":\"$version\", >> $filename.json
echo \"filename\":\"$filename\", >> $filename.json
echo \"datetime\":$datetime, >> $filename.json
echo \"size\":$size, >> $filename.json
echo \"url\":\"$url\", >> $filename.json
echo \"filehash\":\"$filehash\", >> $filename.json
echo \"id\":\"$id\", >> $filename.json
echo \"whatsNew\":\"$whatsNew\", >> $filename.json
echo \"notification\":\"$notification\" >> $filename.json
echo } >> $filename.json
