#!/bin/bash

SAMBA=sam-ba_64
SAMBA_DIR=sam-ba_cdc_linux

../bin/$SAMBA_DIR/$SAMBA /dev/ttyACM0 at91sama5d4x-ek linux_nandflash.tcl 2>&1 | tee logfile.log
