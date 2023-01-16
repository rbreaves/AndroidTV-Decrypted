#!/system/bin/sh

echo "Only run this if you have not yet installed utils or have unmounted folders via umount.sh."
echo "And if you need to backup existing data from the local Android folder to the actual sdcard."

sdcardName=`ls /storage/ | head -n1`

if [ $sdcardName != 'emulated' ] && [ $sdcardName != 'self' ]; then
	echo "Transferring /sdcard/Android/ to /storage/$sdcardName/..."
	cp -rf /sdcard/Android /storage/$sdcardName/
else
	echo "Physical sdcard is not detected."
fi