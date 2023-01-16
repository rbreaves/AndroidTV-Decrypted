#!/system/bin/sh

usbName=`ls /storage/ | head -n1`
echo "Installing additional utilities"
mkdir -p /data/adb/modules/utils/system/bin/
cp -rf /storage/$usbName/Magisk/modules/utils/ /data/adb/modules/utils/
# compressed original install - only way to retain symlinks
# tar -zcvf ./BuiltIn-BusyBox.tar.gz /data/adb/modules/BuiltIn-BusyBox/
# decompressing
tar -zxvf /storage/$usbName/Magisk/modules/BuiltIn-BusyBox.tar.gz -C /
echo "Copying startup mount script for fat32 sdcards."
cp ./Magisk/service.d/* /data/adb/service.d/
chmod +x /data/adb/service.d/*
echo "Waiting 30 seconds before rebooting to ensure no writes are occurring."
sleep 30
echo "Done. type reboot to reboot."