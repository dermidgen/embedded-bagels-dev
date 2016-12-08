#!/bin/bash

if [ ! -f ".screenrc" ]; then
  cat >./.screenrc <<EOL
screen
title "picocom"
stuff "picocom -b 115200 /dev/ttyUSB0\n"
split
focus down
chdir ./release
screen -t "window" bash -ic 'PATH=./bin/sam-ba_cdc_linux:$PATH bash'
title "nandflash"
exec echo ""
exec echo "Run ./do_linux_nandflash.sh when ready."
exec echo "When you're done, press CTL-a \."
exec echo ""
EOL
fi

# Run screen
screen -c .screenrc
