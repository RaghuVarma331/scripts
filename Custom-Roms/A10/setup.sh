#!/bin/bash
#
# RAGHU VARMA Build Script 
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

path=/var/lib/jenkins/workspace/Raghu
gitpassword=$(cat $path/cred** | grep git | cut -d "=" -f 2)

S1()
{
    cd $path
    mkdir roms
    git clone https://$gitpassword@github.com/Nokia-SDM660/Nokia-SDM660.github.io -b master web
    git clone https://$gitpassword@github.com/Nokia-SDM660/automated_faceunlock_patch -b android-10.0 fpatch
}

L1()
{
    cd $path
    wget https://github.com/RaghuVarma331/scripts/raw/master/Custom-Roms/A10/LineageOS/make.sh
    chmod a+x make.sh
} &> /dev/null

L2()
{
    cd $path
    ./make.sh
    rm -r make.sh
}

P1()
{
   cd $path
   wget https://github.com/RaghuVarma331/scripts/raw/master/Custom-Roms/A10/PixelExperience/make.sh
   chmod a+x make.sh
} &> /dev/null

P2()
{
   cd $path
   ./make.sh
   rm -r make.sh
}

D1()
{
   cd $path
   wget https://github.com/RaghuVarma331/scripts/raw/master/Custom-Roms/A10/DerpFest/make.sh
   chmod a+x make.sh
} &> /dev/null

D2()
{
   cd $path
   ./make.sh
   rm -r make.sh
}

E1()
{
   cd $path
   wget https://github.com/RaghuVarma331/scripts/raw/master/Custom-Roms/A10/EvolutionX/make.sh
   chmod a+x make.sh
} &> /dev/null

E2()
{
   cd $path
   ./make.sh
   rm -r make.sh
}

H1()
{
   cd $path
   wget https://github.com/RaghuVarma331/scripts/raw/master/Custom-Roms/A10/Havoc-OS/make.sh
   chmod a+x make.sh
} &> /dev/null

H2()
{
   cd $path
   ./make.sh
   rm -r make.sh
}

S2()
{
   cd $path/roms
   wget https://github.com/RaghuVarma331/scripts/raw/master/Nokia-SDM660/websync.sh
   wget https://github.com/RaghuVarma331/scripts/raw/master/Nokia-SDM660/uploads.sh
   wget https://github.com/RaghuVarma331/scripts/raw/master/Nokia-SDM660/telegram_post.sh
   chmod a+x websync.sh uploads.sh telegram_post.sh
   ./uploads.sh
   ./websync.sh > $path/web/README.md
   ./telegram_post.sh
   cd $path/web
   git add .
   git commit -s -m "Nokia-SDM660: Builds $(date)"
   git push -u -f origin master
   cd $path
   rm -r web roms
} &> /dev/null

T1()
{
   cd $path
   wget https://github.com/RaghuVarma331/scripts/raw/master/Teamwin-Recovery-Project/build-3.4.0-0.sh
   chmod a+x build-3.4.0-0.sh
} &> /dev/null

T2()
{
   ./build-3.4.0-0.sh
}

S1
L1
L2
P1
P2
D1
D2
H1
H2
E1
E2
S2
T1
T2
