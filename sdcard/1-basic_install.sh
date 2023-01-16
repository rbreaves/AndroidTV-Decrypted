#!/system/bin/sh

# todo - change basic settings if needed
# settings list global
# settings put global name value

# disables app verification over terminal/adb
settings put global verifier_verify_adb_installs 0

# disables app verification for casual use by user
# settings set global package_verifier_enable 0

# Remove apps
# adb shell pm uninstall -k --user 0 com.android.something
# Install if the package exist
# adb shell cmd package install-existing com.android.something

installme () {
  appPath="$1"
  appSize=`ls -l "$1" | awk '{print $5}'`
  echo $appPath
  echo $appSize
  cat "$appPath" | pm install -S $appSize
}

pm set-install-location 0

cd /storage/`ls /storage/ | head -n1`/

# basics
cp -rfn ./Wallpapers /sdcard/
installme ./apks/nameOfPackage.apk
echo "Waiting 30 seconds before rebooting to ensure no writes are occurring."
sleep 30
echo "Type 'reboot' to reboot"
