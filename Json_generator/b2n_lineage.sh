rm -r **.md5sum
rm -r **.json
md5sum lineage-17.1**.zip > lineage.md5sum

sourceforge=https://sourceforge.net/projects/b2n-sprout/files/LineageOS
filename=$(echo lineage-17.1**.zip)
datetime=$(grep ro\.build\.date\.utc system/build.prop | cut -d= -f2)
size=$(stat -c%s $filename)
url=$sourceforge/$filename/download
filehash=$(cat **.md5sum | cut -d' ' -f1)
id=$(sha256sum $filename | awk '{ print $1 }');
version=android-10.0
path=/var/lib/jenkins/workspace/LineageOS
whatsNew=$(cat $path/changelog.txt)
notification=$(echo Sofware update - New LineageOS build is up)

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
