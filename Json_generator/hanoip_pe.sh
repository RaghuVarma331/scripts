wget https://github.com/RaghuVarma331/scripts/raw/master/changelogs/changelog.txt
rm -r **.md5sum
rm -r **.json
md5sum PixelExperience**.zip > pe.md5sum
unzip PixelExperience**.zip
sourceforge=https://sourceforge.net/projects/motorola-sm6150/files/G60/PixelExperience
filename=$(echo PixelExperience**.zip)
datetime=$(grep post-timestamp META-INF/com/android/metadata | cut -d= -f2)
size=$(stat -c%s $filename)
url=$sourceforge/$filename/download
filehash=$(cat **.md5sum | cut -d' ' -f1)
id=$(sha256sum $filename | awk '{ print $1 }');
version=android-12.0
path=/var/lib/jenkins/workspace/PixelExperience
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
rm -r rm -r META-INF apex_info.pb care_map.pb changelog.txt pe.md5sum  payload.bin payload_properties.txt
