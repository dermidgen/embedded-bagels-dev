#!/bin/bash

source ../environment

$SAMBA /dev/ttyACM0 at91sama5d4x-ek linux_nandflash.tcl 2>&1 | tee logfile.log
