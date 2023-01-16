#!/bin/sh


sdcardName=`ls /storage/ | head -n1`

cd /storage/$sdcardName

echo "Update retroarch playlists"
echo "This will update paths to use /storage/$sdcardName vs its current or old path."

if [ $sdcardName != 'emulated' ] && [ $sdcardName != 'self' ]; then
	
	# for f in ./playlists/*.lpl; do
	for f in /sdcard/RetroArch/playlists/*.lpl; do
		echo "Updating $f to use /storage/$sdcardName..."
		sed -i -E "s/(path\": \")(.*)(Emulation)/\1\/storage\/$sdcardName\/\3/" "$f"
	done
else
	echo "Physical sdcard is not detected."
fi
