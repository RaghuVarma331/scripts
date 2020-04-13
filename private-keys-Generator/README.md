## Build scripts


### Note

     Iam not responsible for anything

### Requirements
      
	  Linux

### How to use?

    * mkdir keys
    * cd keys
    * wget https://github.com/RaghuVarma331/scripts/raw/master/private-keys-Generator/keys.sh
    * chmod a+x keys.sh
    * nano keys.sh
    * add your details at top
    Example- 
            # your country
            C=IN

            # Your state
            ST=Telangana

            # Your Location
            L=Hyderabad

           # Your Email
           emailAddress=
           
    *  ./keys.sh
    *  mkdir los
    *  cd los
    *  echo -ne '\n' | repo init -u git://github.com/LineageOS/android.git -b lineage-17.1 --depth=1
    *  repo sync -c --no-tags --no-clone-bundle -f --force-sync -j16 
    *  clone your device tree , kernel source & vendor
    *  export path=/var/lib/jenkins/workspace/Raghu #(this is my path)
    *  export device=Dragon #(this is my phone code)    
    *  .build/envsetup.sh && lunch aosp_$device-user && make -j32 otapackage && make dist -j32
    *  ./build/tools/releasetools/sign_target_files_apks -o -d $path/keys $path/los/out/dist/*-target_files-*.zip $path/los/out/target/product/$device/signed-target-files.zip
    *  ./build/tools/releasetools/ota_from_target_files -k $path/keys/releasekey $path/los/out/target/product/$device/signed-target-files.zip $path/los/out/target/product/$device/signed-ota_update.zip
    *  cd out/target/product/$device
    *  flash signed-ota_update.zip 

### Support

      Do you like my contribution?

      Show your support here 😊 https://www.paypal.me/Raghu107
