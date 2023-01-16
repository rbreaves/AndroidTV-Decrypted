#!/system/bin/sh

# echo "Please run this script after installing bash via magisk."
usbName=`ls /storage/ | head -n1`

installme () {
  appPath="$1"
  appSize=`ls -l "$1" | awk '{print $5}'`
  echo $appPath
  echo $appSize
  cat "$appPath" | pm install -S $appSize
}

cd /storage/`ls /storage/ | head -n1`/

installme ./apks/Magisk-v25.2.apk
installme ./apks/FoxMMM-v1.1.0-default-armeabi-v7a-release.apk

echo "Waiting 30 seconds before rebooting to ensure no writes are occurring."
sleep 30

echo "1. Open Magisk let it prompt you to finish the install & reboot."
echo "2. Install busybox module from the Fox's Magisk Modules app. Do not use F-Droid or alternatives."
echo "3. Then run 'sh ./3-utils_install.sh' & reboot"
echo "4. Then run 'su -c bash ./4-install.sh'"
echo ""
echo "Type reboot to reboot."