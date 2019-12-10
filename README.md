## What is this?

    A simple automated script to build roms,kernels & twrps.builds will be automatically push to sourceforge. script also commit the   changelog of that particular rom source and device source changelogs  with the build respective date & time and finally script will    post the update notification in telegram channel & This is designed according to my infrastructure

## Note

    before using my scripts you have to believe that you won't get any errors during compilation


## Requirements
    Jenkins

## How to use?

    Fill these Blanks
   
    Telegram_Api_code=xxxxxxxxx
   
    chat_id=xxxxxxxx
   
    jenkinsurl=xxxxxxx  
   
    path=xxxxxxx
   
    Now Run the shell script using below commands
   
    $chmod a+x ten_build.sh
   
    $./ten_build.sh    
   
<p align="center">
<img src="https://raw.githubusercontent.com/RaghuVarma331/scripts/master/demo.jpg" > 
</p>
   
    Now select any number and hit enter if you are running on linux terminal


    for Jenkins
   
    just add command like this in  YourProject/Configure/BuildEnvironment/Execute Shell
   
<p align="center">
<img src="https://raw.githubusercontent.com/RaghuVarma331/scripts/master/jenkinsdemo.jpg" > 
</p>   
   
   
     echo yourserial number | ./ten_build.sh
   
     Example 
   
     echo 1 | ./ten_build.sh
   
   
   
   
   
   
    

