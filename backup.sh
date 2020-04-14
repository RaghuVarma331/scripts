#!/bin/bash

password=
cd
git clone https://$password@github.com/RaghuVarma331/scripts-backup backup
cd backup
git pull https://github.com/RaghuVarma331/scripts.git
git push -u origin master
