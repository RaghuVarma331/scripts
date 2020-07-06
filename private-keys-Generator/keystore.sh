
#!/bin/bash
#
# private Keys Generator
# Coded by RV 
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

name= # give your name
apkname= # give your apk name

# to create 
keytool -genkey -v -keystore keys.keystore -alias $name -keyalg RSA -keysize 2048 -validity 10000

# to sign
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore keys.keystore $apkname $name
