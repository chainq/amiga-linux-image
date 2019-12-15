# Amiga Linux/m68k Boot Partition generator

## What?

This repository contains a few simple scripts which scripts up 
creating an extremely simple boot partition, which allows one
to boot a Linux/m68k installation from AmigaOS prompt.

It is tuned to be used with my homemade Buildroot-based Linux
images, which might be published at a later point, for the
rest of Linux-y thinks, you can probably use it as a reference
point.

## Why?

I got bored doing this all over by hand for every disk image I
generated... Also, since my build process is based on generating
partitions then a HDD image automatically, which then just has
to be written to a CF/SD card, it was a nice addition that the
Amiga partition can be generated too.

## Dependencies

* amitools - for rdbtool and xdftool
* Workbench 3.1 Disk Image
* amiboot-5.6
* GiggleDisk
* Phase5 CPU support libraries (optional)
* FAT95
* various (de)compressors (lha, zip, gzip, xz)

## Credits

Thanks to the authors of the tools mentioned above.
Thanks to Linux/m68k people for keeping it (mostly) alive.

Definitely no thanks to anyone who still tries to milk 25+
years old Commodore and Amiga copyrights and software.
