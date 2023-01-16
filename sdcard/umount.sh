#!/system/bin/sh

stamp=`date "+%m-%d %T"`

sdcardName=`ls /storage/ | head -n1`

if [ $sdcardName != 'emulated' ] && [ $sdcardName != 'self' ]; then
	# Emulation
	su -c umount /storage/emulated/0/Emulation
	su -c umount /mnt/runtime/default/emulated/0/Emulation
	su -c umount /mnt/runtime/read/emulated/0/Emulation
	su -c umount /mnt/runtime/write/emulated/0/Emulation
	su -c umount /mnt/runtime/full/emulated/0/Emulation

	# RetroArch - does not work, have to copy instead
	# su -c umount /storage/emulated/0/RetroArch
	# su -c umount /mnt/runtime/default/emulated/0/RetroArch
	# su -c umount /mnt/runtime/read/emulated/0/RetroArch
	# su -c umount /mnt/runtime/write/emulated/0/RetroArch
	# su -c umount /mnt/runtime/full/emulated/0/RetroArch

	# Android - data,obb
	su -c umount /storage/emulated/0/Android
	su -c umount /mnt/runtime/default/emulated/0/Android
	su -c umount /mnt/runtime/read/emulated/0/Android
	su -c umount /mnt/runtime/write/emulated/0/Android
	su -c umount /mnt/runtime/full/emulated/0/Android
	su -c echo "$stamp Physical sdcard mount points unmounted." >> /cache/magisk.log
else
	echo "Physical sdcard is not detected."
fi