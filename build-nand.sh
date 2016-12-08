#!/bin/bash

source ./environment
source ./lib/utils.sh

ORIG_WORKSPACE=$(pwd)

path_ensure $RELEASE_PATH

pushd $YOCTO_PATH

# Release

cp $BUILT_BOOTSTRAP $RELEASED_BOOTSTRAP
cp $BUILT_UBOOT     $RELEASED_UBOOT
cp $BUILT_KERNEL    $RELEASED_KERNEL
cp $BUILT_DTB       $RELEASED_DTB
cp $BUILT_ROOTFS    $RELEASED_ROOTFS
cp $BUILT_UBENV     $RELEASED_UBENV

cp nandflash/*      $RELEASE_PATH/.
