# Amiga Linux/m68k Boot Partition generator

## What?

This repository contains a few hacky scripts to create an
extremely simple AmigaOS boot partition, which allows booting
a Linux/m68k installation from AmigaOS prompt.

It is tuned to be used with my homemade, Buildroot-based Linux
images, which might be published at a later point. For other
Amiga Linux-y things (Debian/m68k, etc.), you can probably use
it as a reference point.

This is all very sketchy, and probably mostly only useful as
some sort of reference, to do your own version. Probably also
useful for NetBSD/amiga with minor tweaks.

## Files

* `affs-image.sh` - creates a 32MiB AmigaOS FSS partition with
   the necessary tools to boot a Linux/m68k kernel
* `dap-image.sh` - combines various pre-generated partition
   images to create a bootable HDD/SD/CF image
   
* `files/Startup-Sequence` - AmigaDOS boot script
* `files/mountlnxboot` - mounts a FAT16 Linux boot partition
   using GiggleDisk
* `files/b` - one letter shortcut script to boot Linux

## Why?

I got bored doing this all the time by hand for every disk image
I made... Also, since my build process is based on generating
partitions, then combining them into HDD image automatically to
be written to a CF/SD card, it was a nice addition that the Amiga
partition can be generated too.

## Dependencies

* amitools - for `rdbtool` and `xdftool` https://github.com/cnvogelg/amitools
* Workbench 3.1 Disk Image ADF
* amiboot-5.6 https://people.debian.org/~cts/debian-m68k/misc/
* GiggleDisk http://www.geit.de/eng_giggledisk.html
* Phase5 CPU support libraries (optional) http://phase5.a1k.org
* FAT95 http://aminet.net/package/disk/misc/fat95
* various (de)compressors (lha, zip, gzip, xz)
* various standard Unix tools (dd, etc)

I only tested with the original Commodore Workbench 3.1 disk image,
it might work with other versions.

## It even works

The build scripts were tested on Ubuntu Linux 18.04/x86_64, but
should work on any Unix-y system until the required tools are
present and functional.

The resulting images were tested with FS-UAE on macOS, and on my
Amiga 1200 with a Blizzard 1260 CPU accelerator with a PATA SSD.
Other Amiga models and non-phase5 CPU cards will probably need some
tweaks in the scripts.

## Credits & Thanks

* Thanks to the authors of the tools mentioned above.
* Thanks to Linux/m68k people for keeping it (mostly) alive.

Definitely no thanks to anyone who still tries to milk 25+
years old Commodore and Amiga copyrights and software.
