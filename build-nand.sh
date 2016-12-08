#!/bin/bash

source ./environment
source ./lib/utils.sh

ORIG_WORKSPACE=$(pwd)

path_ensure $RELEASE_PATH

pushd $YOCTO_PATH

# TODO switch to repo tool from el-goog
# Sync repos & layers
repo_sync poky              git://git.yoctoproject.org/poky               krogoth
repo_sync meta-qt5          git://github.com/meta-qt5/meta-qt5.git        krogoth
repo_sync meta-atmel        git://github.com/linux4sam/meta-atmel.git     krogoth
repo_sync meta-openembedded git://git.openembedded.org/meta-openembedded  krogoth

pushd poky
source oe-init-build-env build-atmel

bitbake atmel-qt5-demo-image

# Release

cp $BUILT_BOOTSTRAP $RELEASED_BOOTSTRAP
cp $BUILT_UBOOT     $RELEASED_UBOOT
cp $BUILT_KERNEL    $RELEASED_KERNEL
cp $BUILT_DTB       $RELEASED_DTB
cp $BUILT_ROOTFS    $RELEASED_ROOTFS
cp $BUILT_UBENV     $RELEASED_UBENV

cp nandflash/*      $RELEASE_PATH/.
