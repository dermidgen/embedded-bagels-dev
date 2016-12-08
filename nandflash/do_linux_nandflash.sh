#!/bin/sh

SMB_PATH=../../../Atmel/sam-ba_cdc_linux
$SMB_PATH/sam-ba_64 /dev/ttyACM0 at91sama5d4x-ek demo_linux_nandflash.tcl 2>&1 | tee logfile.log
