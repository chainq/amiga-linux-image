#!/bin/bash

# This needs amitools from
# https://github.com/cnvogelg/amitools

export PATH=$PATH:$HOME/Develop/amitools/bin

WB31DISK=files/WB-3_1.ADF
CPULIBS=files/040_060Libs.zip
AMIBOOT=files/amiboot-5.6.gz
GIGGLEDISK=files/giggledisk.lha
FAT95=files/fat95.lha

ABOOT_IMAGE_NAME="aboot_affs"
ABOOT_IMAGE_HDF="$ABOOT_IMAGE_NAME".hdf

rm -f $ABOOT_IMAGE_HDF
xdftool $ABOOT_IMAGE_HDF create size=32Mi + format ABoot ffs

xdftool $ABOOT_IMAGE_HDF makedir C
xdftool $ABOOT_IMAGE_HDF makedir S
xdftool $ABOOT_IMAGE_HDF makedir L
xdftool $ABOOT_IMAGE_HDF makedir Libs


# Extract minimal needed stuff from WB 3.1 Disk
TMP_DIR=$(mktemp tmp.XXXXXXXXXX -d)
WB31FILES=( SetPatch List Assign Copy Delete Rename Execute Protect Mount )
for WBFILE in ${WB31FILES[@]}; do
    xdftool $WB31DISK read C/$WBFILE $TMP_DIR
    xdftool $ABOOT_IMAGE_HDF write $TMP_DIR/$WBFILE C/
done
rm -rf $TMP_DIR

# GiggleDisk is needed to mount boot partition, also copy mount script
TMP_DIR=$(mktemp tmp.XXXXXXXXXX -d)
pushd $TMP_DIR >/dev/null
lha x ../$GIGGLEDISK >/dev/null
popd >/dev/null
xdftool $ABOOT_IMAGE_HDF write $TMP_DIR/GiggleDisk/Bin/GiggleDisk_AOS68K C/
rm -rf $TMP_DIR
xdftool $ABOOT_IMAGE_HDF write files/mountlnxboot C/
xdftool $ABOOT_IMAGE_HDF protect C/mountlnxboot srwd

# FAT95 is needed to mount the LNXBoot partition which is generated as FAT
TMP_DIR=$(mktemp tmp.XXXXXXXXXX -d)
pushd $TMP_DIR >/dev/null
lha x ../$FAT95 >/dev/null
popd >/dev/null
xdftool $ABOOT_IMAGE_HDF write $TMP_DIR/fat95/l/fat95 L/
rm -rf $TMP_DIR

# amiboot is needed to boot the kernel
TMP_DIR=$(mktemp tmp.XXXXXXXXXX -d)
pushd $TMP_DIR >/dev/null
gzip -d -c ../$AMIBOOT >amiboot-5.6
popd >/dev/null
xdftool $ABOOT_IMAGE_HDF write $TMP_DIR/amiboot-5.6 C/
rm -rf $TMP_DIR

# copy CPU library files
CPULIBFILES=( 68060.library 68040old.library 68040new.library 68040.library )
TMP_DIR=$(mktemp tmp.XXXXXXXXXX -d)
pushd $TMP_DIR >/dev/null
unzip ../$CPULIBS >/dev/null
popd >/dev/null
for CPULIBFILE in ${CPULIBFILES[@]}; do
    xdftool $ABOOT_IMAGE_HDF write $TMP_DIR/$CPULIBFILE Libs/
done
rm -rf $TMP_DIR

# Copy startup sequence
xdftool $ABOOT_IMAGE_HDF write files/Startup-Sequence S/
xdftool $ABOOT_IMAGE_HDF protect S/Startup-Sequence srwd

# Copy one key boot script
xdftool $ABOOT_IMAGE_HDF write files/b C/
xdftool $ABOOT_IMAGE_HDF protect C/b srwd

xdftool $ABOOT_IMAGE_HDF list

xz -f -T 4 $ABOOT_IMAGE_HDF
