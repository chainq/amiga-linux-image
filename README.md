# Amiga Linux/m68k Boot Partition generator

## What?

This repository contains a few simple scripts which scripts up 
creating an extremely simple boot partition, which allows one
to boot a Linux/m68k installation from AmigaOS prompt.

It is tuned to be used with my homemade Buildroot-based Linux
images, which might be published at a later point, for the
rest of Linux-y thinks, you can probably use it as a reference
point.

This is all very sketchy, and probably mostly only useful as
some sort of reference, to do your own. Probably also useful
for NetBSD/amiga with minor tweaks.

## Why?

I got bored doing this all the time by hand for every disk image
I generated... Also, since my build process is based on generating
partitions then a HDD image automatically, which then just has to
be written to a CF/SD card, it was a nice addition that the Amiga
partition can be generated too.

## Dependencies

* amitools - for rdbtool and xdftool https://github.com/cnvogelg/amitools
* Workbench 3.1 Disk Image ADF
* amiboot-5.6 https://people.debian.org/~cts/debian-m68k/misc/
* GiggleDisk http://www.geit.de/eng_giggledisk.html
* Phase5 CPU support libraries (optional) http://phase5.a1k.org
* FAT95 http://aminet.net/package/disk/misc/fat95
* various (de)compressors (lha, zip, gzip, xz)

## Credits

* Thanks to the authors of the tools mentioned above.
* Thanks to Linux/m68k people for keeping it (mostly) alive.

Definitely no thanks to anyone who still tries to milk 25+
years old Commodore and Amiga copyrights and software.
