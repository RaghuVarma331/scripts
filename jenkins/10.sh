#!/bin/bash

path=$(sudo find / -name pluginSetupWizard.js)

sudo systemctl start jenkins
echo "// default 10 seconds for AJAX responses to return before triggering an error condition" >> $path
echo "var pluginManagerErrorTimeoutMillis = 180 * 1000;" >> $path
sudo service jenkins restart
