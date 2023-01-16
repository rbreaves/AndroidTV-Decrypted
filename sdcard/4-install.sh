#!/bin/bash

# Run me this way
# su -c bash ./install.sh

cd /storage/`ls /storage/ | head -n1`/

if [ -n "$BASH_VERSION" ]; then 
  echo $BASH_VERSION
else
  echo "Run with'su -c bash ./install.sh'"
  exit 0
fi

# exit 0

# pm set-install-location 2
prompt_before_install=0

installme () {
  appPath="$1"
  appSize=`ls -l "$1" | awk '{print $5}'`
  # echo $appPath
  # echo $appSize

  # check pkg name
  appName=`aapt dump badging $appPath | grep package:\ name | awk -F"'" '{$0=$2}1'`
  pm list packages -3 | grep "$appName" >/dev/null
  if [ $? -eq 0 ]; then
    echo "App $appName was already installed. Will be skipping."
  else
    [ $prompt_before_install -eq 1 ] && read -p "Press any key to continue... "$'\n' -n1 -s
    echo "Installing $appName ..."
    cat "$appPath" | pm install -S $appSize
    [ $appName == 'com.retroarch.ra32' ] && retroarchInstall
  fi
}

retroarchInstall() {
  rsync -aq ./RetroArch /sdcard/
  echo "If you need to change paths to any resources open Settings -> Directory"
  sh ./updateRetroArchPlaylists.sh
}

installme ./apks/packageName.apk
echo "Finished."