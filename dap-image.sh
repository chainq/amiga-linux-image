#!/bin/bash

# Daphne-Agnus-Portia... We will never forget.

# This needs amitools from
# https://github.com/cnvogelg/amitools

export PATH=$PATH:$HOME/Develop/amitools/bin

IMAGE_FILE_NAME="dap-linux.img"

ABOOT=aboot_affs.hdf.xz
LNXBOOT=lnxboot.vfat.xz
LNXROOT=rootfs.squashfs
LNXRW=rw.ext4.xz

echo "Creating and partitioning image..."

rm -f $IMAGE_FILE_NAME
rdbtool $IMAGE_FILE_NAME create size=1256Mi + init
rdbtool $IMAGE_FILE_NAME add size=32MiB name=ABOOT dostype=DOS1 max_transfer=0x1fe00 bootable
rdbtool $IMAGE_FILE_NAME add size=64MiB name=LNXBOOT dostype=FAT1 max_transfer=0x1fe00 automount=false
rdbtool $IMAGE_FILE_NAME add size=128MiB name=LNXROOT dostype=LNX0 max_transfer=0x1fe00 automount=false
rdbtool $IMAGE_FILE_NAME add size=1024MiB name=LNXRW dostype=EXT3 max_transfer=0x1fe00 automount=false

#rdbtool $IMAGE_FILE_NAME info

echo "Populating final image..."

CYL_BLOCKS=`rdbtool $IMAGE_FILE_NAME info | grep -m 1 cyl_blks | awk -F"=" '{print $NF}'`
BLOCK_SIZE=`rdbtool $IMAGE_FILE_NAME info | grep -m 1 block_size | awk -F"=" '{print $NF}'`
CYL_SIZE=$((CYL_BLOCKS*BLOCK_SIZE))

ABOOT_START=`rdbtool $IMAGE_FILE_NAME info | grep -m 1 ABOOT | awk '{print $4}'`
LNXBOOT_START=`rdbtool $IMAGE_FILE_NAME info | grep -m 1 LNXBOOT | awk '{print $4}'`
LNXROOT_START=`rdbtool $IMAGE_FILE_NAME info | grep -m 1 LNXROOT | awk '{print $4}'`
LNXRW_START=`rdbtool $IMAGE_FILE_NAME info | grep -m 1 LNXRW | awk '{print $4}'`

xz -d -c $ABOOT | dd of=$IMAGE_FILE_NAME conv=notrunc bs=$CYL_SIZE seek=$ABOOT_START status=none
xz -d -c $LNXBOOT | dd of=$IMAGE_FILE_NAME conv=notrunc bs=$CYL_SIZE seek=$LNXBOOT_START status=none
dd if=$LNXROOT of=$IMAGE_FILE_NAME conv=notrunc bs=$CYL_SIZE seek=$LNXROOT_START status=none
xz -d -c $LNXRW | dd of=$IMAGE_FILE_NAME conv=notrunc bs=$CYL_SIZE seek=$LNXRW_START status=none

echo "Compressing image..."
xz -T 4 -f $IMAGE_FILE_NAME
