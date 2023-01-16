#!/system/bin/sh

sdcardName=`ls /storage/ | head -n1`

if [ $sdcardName != 'emulated' ] && [ $sdcardName != 'self' ]; then
	echo "Transferring /sdcard/RetroArch/ to /storage/$sdcardName/..."
	cp -rf /sdcard/RetroArch /storage/$sdcardName/
else
	echo "Physical sdcard is not detected."
fi