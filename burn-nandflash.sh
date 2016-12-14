#!/bin/bash

source ./environment
source ./lib/utils.sh
source ./lib/acm.sh

echo "Getting ready to flash NAND"
echo "Firing up debug terminal /dev/ttyUSB0..."
sleep 1

## Pop out a new terminal for running picocom
# * requires an intermediary script to execute picocom
echo `(x-terminal-emulator --working-directory $ORIG_WORKSPACE -e $ORIG_WORKSPACE/debug-term.sh &> /dev/null) &`;

sleep 1
echo ""
echo "Close JP7 and connect your device..."
echo "Watch the debug terminal for RomBOOT..."

wait_for_acm_device

echo "Device found..."
echo ""
read -p "Open JP7 and press any key to continue... " -n1 -s

cowsay -f sodomized-sheep "Okay, here we go!"
sleep 2

cd $RELEASE_PATH
./do_linux_nandflash.sh

echo ""
echo ""
echo "All done!"
echo "Reset your device and watch it boot in the debug terminal"
echo ""
cowsay "Buh-bye!"
