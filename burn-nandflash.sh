#!/bin/bash

source ./environment
source ./lib/utils.sh
source ./lib/acm.sh

ORIG_WORKSPACE=$(pwd)

echo "Getting ready to flash NAND"
echo "Firing up debug terminal /dev/ttyUSB0..."
sleep 1
echo `(x-terminal-emulator --working-directory $ORIG_WORKSPACE -e $ORIG_WORKSPACE/debug-term.sh &> /dev/null) &`;

sleep 1
echo ""
echo "Close JP7 and connect your device..."
echo "Watch the debug terminal for RomBOOT..."

wait_for_acm_device

echo "Device found..."
echo ""
read -p "Open JP7 and press any key to continue... " -n1 -s

cowsay "Okay, here we go!"
