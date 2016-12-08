#!/bin/bash

set -e

TARGET="yocto-angstrom-build"
WORKDIR="../../$TARGET"
BUILD_PATH="$WORKDIR/deploy/glibc/images/raspberrypi2"
BUILD_IMG="raspberrypi2_embedded-bagels.rootfs.rpi-sdimg"

## libc6-2.23 is required to build properly
#sudo dpkg -i ./libc6/libc6_2.23-0ubuntu4_amd64.deb

if [ ! -d "$WORKDIR" ]; then
  mkdir -p $WORKDIR
fi

pushd $WORKDIR

if [ ! -d ".repo" ]; then
  repo init -u git@github.com:dermidgen/embedded-bagels-platform.git -b master
fi

repo sync
. export

# if [ "$1" == "clean" ]; then
#   MACHINE=raspberrypi2 bitbake -c clean
# fi

# if [ "$1" == "cleanall" ]; then
#   MACHINE=raspberrypi2 bitbake -c cleanall
# fi

#bitbake -c devshell ympd (enter shell mode)
# MACHINE=raspberrypi2 bitbake -c cleanall world
# MACHINE=raspberrypi2 bitbake -c cleanall mpd
# MACHINE=raspberrypi2 bitbake -c cleanall mpc
# MACHINE=raspberrypi2 bitbake -c cleanall ympd
# MACHINE=raspberrypi2 bitbake -c cleanall mpd mpc ympd
# MACHINE=raspberrypi2 bitbake -c cleanall libsoxr
# MACHINE=raspberrypi2 bitbake -c cleanall shairport-sync
# MACHINE=raspberrypi2 bitbake -c cleanall libsoxr shairport-sync
# MACHINE=raspberrypi2 bitbake -c cleanall embedded-bagels-image
# MACHINE=sama5d4ek bitbake atmel-qt5-demo-image
MACHINE=sama5d4-xplained bitbake embedded-bagels-image

popd

# if [ ! -e "$BUILD_IMG" ]; then
#   echo "No working image found; copying new one"
#   cp $BUILD_PATH/$BUILD_IMG $BUILD_IMG
# else
#   if [ "$BUILD_PATH/$BUILD_IMG" -nt "$BUILD_IMG" ]; then
#     echo "Copying updated working image"
#     cp $BUILD_PATH/$BUILD_IMG $BUILD_IMG
#   else
#     echo "Images are the same; skipping img copy"
#   fi
# fi
cp "$BUILD_PATH/$BUILD_IMG" "$BUILD_IMG"

## Restore back to libc6-2.24
# sudo apt-get install -f
# sudo dpkg -i --force-overwrite ./libc6/libc6_2.24-3ubuntu1_amd64.deb
# sudo apt-get install -f
