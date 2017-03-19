#!/bin/bash
# Format and prepare the block storage for digital ocean.
# Also sets the docker daemon to store images here.
# Use Ubuntu 16.10, Linux Kernel 4.x
# Block storage volume formatted to ext4
# WARNING: Script should only be run once

BLKNAME=$1
BLKSTORE=/dev/disk/by-id/scsi-0DO_Volume_$BLKNAME

cat /etc/fstab | grep $BLKNAME
if [ $? -eq 0 ]
then echo "Disk already prepared"
exit
fi

sudo parted $BLKSTORE mklabel gpt
sudo parted -a opt $BLKSTORE mkpart primary ext4 0% 100%
sudo mkfs.ext4 $BLKSTORE
sudo mkdir -p /mnt/$BLKNAME
echo $BLKSTORE' /mnt/'$BLKNAME' ext4 defaults,nofail,discard 0 2' | sudo tee -a /etc/fstab
sudo mount -a
dockerd -s overlay2 -g /mnt/$BLKNAME
