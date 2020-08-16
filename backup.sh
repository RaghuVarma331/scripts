#!/bin/bash

git remote rename origin upstream
git remote add origin https://github.com/RaghuVarma331/scripts-backup.git
git push -u -f origin master
