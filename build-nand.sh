#!/bin/sh

EM_TARGET=sama5d4-xplained

POKY=../../Atmel/yocto/poky
POKY_IMG_PATH=$POKY/build-atmel/tmp/deploy/images/$EM_TARGET

EM_IMG_PATH=./pkg

if [ ! -d $EM_IMG_PATH ]; then
  mkdir $EM_IMG_PATH
fi

cp $POKY_IMG_PATH/zImage-at91-sama5d4_xplained.dtb $EM_IMG_PATH/at91-sama5d4_xplained.dtb
cp $POKY_IMG_PATH/at91bootstrap-sama5d4_xplained.bin $EM_IMG_PATH/.
cp $POKY_IMG_PATH/atmel-qt5-demo-image-sama5d4-xplained.ubi $EM_IMG_PATH/atmel-xplained-demo-image-sama5d4-xplained.ubi
cp $POKY_IMG_PATH/u-boot-sama5d4-xplained.bin $EM_IMG_PATH/.
cp $POKY_IMG_PATH/sama5d4_xplained-nandflashboot-uboot-3.8.7.bin $EM_IMG_PATH/ubootEnvtFileNandFlash.bin
cp $POKY_IMG_PATH/zImage-sama5d4-xplained.bin $EM_IMG_PATH/.

