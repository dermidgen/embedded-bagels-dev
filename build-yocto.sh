#!/bin/bash

source ./environment
source ./lib/utils.sh
source ./lib/acm.sh

ORIG_WORKSPACE=$(pwd)

path_ensure $BUILD_PATH
path_ensure $YOCTO_PATH
path_ensure $RELEASE_PATH

cd $YOCTO_PATH

if [ ! -d ".repo" ]; then
  repo init -u https://github.com/dermidgen/embedded-bagels-platform.git -b master
fi

repo sync --force-sync

source eb-init-build-env

TARGET=${1:-atmel-qt5-demo-image}

# bitbake core-image-minimal
if [ "$2" == "clean" ]; then
  bitbake -c cleanall $TARGET
fi

bitbake $TARGET

# Release
echo "Copying build artifacts to release..."

cd $ORIG_WORKSPACE

cp -f $BUILT_BOOTSTRAP $RELEASED_BOOTSTRAP
cp -f $BUILT_UBOOT     $RELEASED_UBOOT
cp -f $BUILT_KERNEL    $RELEASED_KERNEL
cp -f $BUILT_DTB       $RELEASED_DTB
cp -f $BUILT_ROOTFS    $RELEASED_ROOTFS
cp -f $BUILT_UBENV     $RELEASED_UBENV

cp nandflash/*      $RELEASE_PATH/.

cowsay "All done!"
