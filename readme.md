# Android TV Decrypted

Purpose of this repo is provide a template for setup scripts that users can use on rooted Android TV devices that are v10 & newer. Currently this work is purely based on work that is verified to be working on Onn 4k & Dynalink type of devices running Android TV 10. The purpose.

## Description

The scripts contained in this project are meant to be transferred to a microsd card and ran over adb via sh or bash. Their install will allow for certain directories to be mounted from the fat32 microsd internally similar to adoptable storage, although it is not currently designed to fully integrate or replace the /data directory which contains local app on the internal storage. Currently unknown if attempts will be made later on to support adoptable storage type functionality on fat32 microsd cards.

## Getting Started

### Dependencies

Make sure you install adb & fastboot on your Windows, Mac or Linux system to remote into the Android TV device.

Also be prepared to patch the boot.img file for your specific device, ex. Onn 4K, via Magisk and then use fastboot to flash the boot.img to the device.

onn-user 10 QT 20220325 - Firmware 1.01.35 - Security Feb 5 2022 - Kernel 4.9.180 (Mar 25 2022)
https://android.googleapis.com/packages/ota-api/package/bec0ba7d09a391933160b4981267cf227ef008ff.zip

### Quick command line only overview of install Magisk & patching boot.img

```
adb devices
adb reboot bootloader
fastboot devices
fastboot oem 'setenv lock 10101000;save'
fastboot flashing unlock
fastboot reboot
adb install ./Magisk-v25.2.apk
# open magisk app - install and patch boot.img
adb push ./Onn_4k_May_2022_6e40026214b9d144df68e39fcbfcee4c9039f25c/boot.img /sdcard/boot.img
adb pull /sdcard/Download/magisk_patched-25200_wINkl.img

# adb reboot bootloader
adb -s OUSA2134014656 shell reboot bootloader
fastboot devices
fastboot flash boot ./magisk_patched-25200_wINkl.img
fastboot reboot
```

### Installing

* Bring in your own set of apks to place under /sdcard/apks for automatic install
* Files placed under /sdcard/Android or /sdcard/Emulation will be mounted as though they are internal to the system

### The 4 Step Install

Note: writes take longer than you think - ALWAYS wait 30 seconds after you last think a file was wrote before restarting your device or risk data corruption on the sdcard.

Also populate the /sdcard/Magisk/modules/utils folder with these binaries so step 4 works
https://github.com/Allespro/armv7-android-tools

Also replace aapt in utils with this version
https://github.com/JonForShort/android-tools/tree/master/build/android-9.0.0_r33/aapt/armeabi-v7a/bin

Once files are transferred to the microsd & booted on the device just run these scripts in this order over adb
```
# All basic apps for your initial configuration & setup should be placed here & ran like so

# Step 1 - Basic apps only to start your setup
sh ./1-basic_install.sh

# Step 2 - Finish the rooting process
sh ./2-magisk_install.sh
# reboot if or when needed

# Step 3 will install busybox & other utilities, plus the sdcard automounting script

# If you want to transfer your internal /sdcard/Android folder
# to the sdcard before mounting /storage/{sdcard-hash}/Android
# then run ` sh ./transfer.sh `

su
sh ./3-utils_install.sh
reboot
su

# Step 4 - Install all the apk files you want while skipping the ones already installed
#
# AKA add most of your apk files to this file for install
#
# Be certain you can run ` which aapt ` and get a path back to the binary or this step will fail.
bash ./4-install.sh

# If you use retroarch then it may not see your Emulation folder
# instead run ` sh ./updateRetroArchPlaylists.sh `



```

## Help

This is a work in progress and I stripped a good bit out as far things I am unable to share. This should be a good jumping off point for anyone that wants to get more out of there Android TV however.


## Authors

Contributors names and contact info

Ben Reaves

## Version History

* 0.1
    * Initial Release

## License

This project is licensed under the MIT License - see the LICENSE.md file for details

## References

Onn 4K images
https://forum.xda-developers.com/t/walmart-onn-android-tv.4313411/page-4

Really horrible looking website that contained details on how to patch Onn 4K's boot.img so you can root it.
https://stakeout5epictv.cyou/2022/05/01/walmart-onn-4k-streaming-box-root-unlock-bootloader-remote-remap-and-more/



