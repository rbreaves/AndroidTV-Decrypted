#!/bin/sh

sdcardName=`ls /storage/ | head -n1`
count=0
retries=50
stamp=`date "+%m-%d %T"`

# start after emulated storage is setup && sdcard is detected
while [ $sdcardName == 'emulated' ] || [ $sdcardName == 'self' ]; do
	sleep 3
	sdcardName=`ls /storage/ | head -n1`
	stamp=`date "+%m-%d %T"`
	echo "$stamp Retry $count - sdcard: $sdcardName"
	echo "$stamp Retry $count - sdcard: $sdcardName" >> /cache/magisk.log
	count=$((count+1))
	if [ $count -gt $retries ]; then
		break
	fi
done

# To help figure out what your permissions & mount points ought to be
# cat /proc/mounts

railme() {
	su -c mount -o bind,rw,nosuid,nodev,noexec,noatime,fsuid=1023,fsgid=1023,gid=1015,multiuser,mask=6,derive_gid,default_normal /storage/"$sdcardName"/$1 /storage/emulated/0/$1
	su -c mount -o bind,rw,nosuid,nodev,noexec,noatime,fsuid=1023,fsgid=1023,gid=1015,multiuser,mask=6,derive_gid,default_normal /storage/"$sdcardName"/$1 /mnt/runtime/default/emulated/0/$1
	su -c mount -o bind,rw,nosuid,nodev,noexec,noatime,fsuid=1023,fsgid=1023,gid=9997,multiuser,mask=23,derive_gid,default_normal /storage/"$sdcardName"/$1 /mnt/runtime/read/emulated/0/$1
	su -c mount -o bind,rw,nosuid,nodev,noexec,noatime,fsuid=1023,fsgid=1023,gid=9997,multiuser,mask=7,derive_gid,default_normal /storage/"$sdcardName"/$1 /mnt/runtime/write/emulated/0/$1
	su -c mount -o bind,rw,nosuid,nodev,noexec,noatime,fsuid=1023,fsgid=1023,gid=9997,multiuser,mask=7,derive_gid,default_normal /storage/"$sdcardName"/$1 /mnt/runtime/full/emulated/0/$1
	su -c echo "$stamp $1 - $sdcardName mounted successfully. - On boot" >> /cache/magisk.log
}

if [ ! $sdcardName == 'emulated' ] && [ ! $sdcardName == 'self' ]; then
	# Emulation - RetroArch will not actually see this, will have to create script to update path on created playlists
	mkdir -p /sdcard/Emulation
	railme Emulation

	# RetroArch - does not work, have to copy instead
	# mkdir -p /sdcard/RetroArch
	# railme RetroArch

	# Android - data, obb - does work to allow games and apps to load storage from fat32 sdcards
	railme Android
else
	echo "Physical sdcard is not detected."
	su -c echo "$stamp Physical sdcard $sdcardName on retry $count failed to mount. - On boot" >> /cache/magisk.log
fi