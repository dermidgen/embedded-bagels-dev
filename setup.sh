#!/bin/bash

source ./environment
source ./lib/utils.sh

##
# Install pre-requisites
##

pkg_ensure "picocom"
pkg_ensure "curl"
pkg_ensure "screen"
pkg_ensure "cowsay"

##
# Setup workspace
##

path_ensure $BIN_PATH
path_ensure $BUILD_PATH
path_ensure $RELEASE_PATH
path_ensure $RESOURCE_PATH

echo "Using bin path: $BIN_PATH"
echo "Using build path: $BUILD_PATH"
echo "Using release path: $RELEASE_PATH"
echo "Using resource path: $RESOURCE_PATH"

# Download resources
resource_ensure $RESOURCE_PATH/$SAMBA_ZIP $RESOURCE_SERVER/$SAMBA_ZIP

# Setup sam-ba
echo "Checking for SAM-BA"
if [ ! -d $SAMBA_PATH ]; then
  echo "Couldn't find $SAMBA_PATH: setting up"
  pushd $RESOURCE_PATH
  unzip $SAMBA_ZIP
  popd
  cp -R $RESOURCE_PATH/$SAMBA_DIR $SAMBA_PATH
fi
echo "Using SAM-BA at $SAMBA_PATH/$SAMBA"

echo "Ensure $USER in group: dialout"
if user_not_in_group $USER dialout; then
  echo "Adding $USER to group: dialout"
  sudo useradd -G dialout $USER
fi

echo ""
cowsay "All done!"
echo ""
echo "Setup complete. You're ready to build."
echo ""
