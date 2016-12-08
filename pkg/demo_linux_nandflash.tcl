## Files to load
set bootstrapFile	"at91bootstrap-sama5d4_xplained.bin"
set ubootFile		"u-boot-sama5d4-xplained.bin"
set kernelFile		"zImage-sama5d4-xplained.bin"
set rootfsFile		"atmel-xplained-demo-image-sama5d4-xplained.ubi"
set dtbFile		"at91-sama5d4_xplained.dtb"

## board variants
set boardFamily		"sama5d4_xplained"
set board_suffix	"ek"

## the videoMode variable must be adapated to the screen size
set videoMode		""

## additional setup
set build_uboot_env "yes"

## now call common script
source demo_script_linux_nandflash.tcl
