#!/system/bin/sh
#
# mount NTFS / exFAT
# 06/07/2019 by TecKnight
# This script checks the inserted Micro SD--
# If Micro SD is formatted exFAT or NTFS, it mounts it

setenforce 0

sdcard_device=`blkid /dev/block/mmcblk1`

sdcard_part1=`blkid /dev/block/mmcblk1p1`

# Uncomment next 2 lines to troubleshoot
# echo $sdcard_device > /cache/sdcard_device.txt
# echo $sdcard_part1 > /cache/sdcard_part1.txt

# output from blkid command looks like this:
# /dev/block/mmcblk1p1: LABEL="e" UUID="CEDC-3F3A" TYPE="exfat"

# create mount point
mkdir /mnt/media_rw/extsd

# mount approriate filesystem if it resides on device directly
case "$sdcard_device" in
  *exfat*) mount.exfat /dev/block/mmcblk1 /mnt/media_rw/extsd ;;
  *ntfs*) ntfs-3g /dev/block/mmcblk1 /mnt/media_rw/extsd ;;
esac

# mount approriate filesystem if it resides on first partition of device
case "$sdcard_part1" in
  *exfat*) mount.exfat /dev/block/mmcblk1p1 /mnt/media_rw/extsd ;;
  *ntfs*) ntfs-3g /dev/block/mmcblk1p1 /mnt/media_rw/extsd ;;
esac
