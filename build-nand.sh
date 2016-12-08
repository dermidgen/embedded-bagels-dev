#!/bin/bash

source ./environment
source ./lib/utils.sh
source ./lib/acm.sh

ORIG_WORKSPACE=$(pwd)

path_ensure $BUILD_PATH
path_ensure $YOCTO_PATH
path_ensure $RELEASE_PATH

cd $YOCTO_PATH

# TODO switch to repo tool from el-goog
# Sync repos & layers
repo_sync poky              git://git.yoctoproject.org/poky               krogoth
repo_sync meta-qt5          git://github.com/meta-qt5/meta-qt5.git        krogoth
repo_sync meta-atmel        git://github.com/linux4sam/meta-atmel.git     krogoth
repo_sync meta-openembedded git://git.openembedded.org/meta-openembedded  krogoth


# Yocto time
cd poky
source oe-init-build-env build-atmel

# Apply our configs
cp -f ../../../../conf/bblayers.conf ./conf/.
cp -f ../../../../conf/local.conf ./conf/.

bitbake core-image-minimal
bitbake atmel-qt5-demo-image

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
