# embedded-bagels-dev
Build scripts and environment for Embedded Bagels builds &amp; releases

**Current Scripts**

 * `./setup.sh`
  + make sure the paths are created
  + install pre-requisites
  + download & setup local sam-ba 2.16
 * `./build-nand.sh`
  + clone/sync yocto layers from repos
  + patch poky/build-atmel config
  + bitbake core-image-minimal
  + bitbake atmel-qt5-demo-image
  + copy build artifacts to release dir
  + copy nandflash scripts to release dir
 * `./burn-nandflash.sh`
  + fire up debug terminal
  + wait for device connection
  + wait for JP7 to open
  + flash the board

*Note*
Full build will require ~80 GiB disk-space.
Initial build will take a long time. On my system it takes ~2hrs.
   Memory: 30.9 GiB
   Processor: Intel® Core™ i7-6770HQ CPU @ 2.60GHz × 8 
   Disk: SanDisk SSD SD8SN8U256G1122 (X4120000)
