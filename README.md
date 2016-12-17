# embedded-bagels-dev
Build scripts and environment for Embedded Bagels builds &amp; releases

**Current Scripts**

 * `./setup.sh`
  + make sure the paths are created
  + install pre-requisites
  + download & setup local sam-ba 2.16
 * `./build-yocto.sh`
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

## Usage
```
./setup.sh
./build-yocto.sh
./burn-nandflash.sh
```

### Build Options

Build options allow you to specify a target and optionally clean the target.

There are two optional build targets at this time.

 * `core-image-minimal`
 * `atmel-qt5-demo-image` - *default*


```
./build-yocto.sh [core-image-minimal|atmel-qt5-demo-image] [clean|superclean]
```

Using the `superclean` option will wipe the build's tmp directory. This is a great way to clean up stale images that have been built without loosing the caches of source downloads and build artifacts.

*Note*
```
Full build will require ~80 GiB disk-space.
Initial build will take a long time. On my system it takes ~2hrs.
   Memory: 30.9 GiB
   Processor: Intel® Core™ i7-6770HQ CPU @ 2.60GHz × 8 
   Disk: SanDisk SSD SD8SN8U256G1122 (X4120000)
```
