#!/bin/bash

source ./environment
source ./lib/utils.sh

##
# Install pre-requisites
##

## Utils
pkg_ensure "curl"
pkg_ensure "cowsay"

## Kali patch;
if [ ! -f /usr/bin/cowsay ]; then
  if [ -f /usr/games/cowsay ]; then
    sudo ln -s /usr/games/cowsay /usr/bin/cowsay
  fi
fi

## perlbrew
if [ ! -f ~/perl5/perlbrew/etc/bashrc ]; then
  \curl -L https://install.perlbrew.pl | bash
fi 

source ~/perl5/perlbrew/etc/bashrc

perlbrew install perl-$PERL_VERSION
perlbrew switch perl-$PERL_VERSION

## Repo
repo_tool_ensure

## Debug
pkg_ensure "picocom"

## Build tools
pkg_ensure "build-essential"
pkg_ensure "diffstat"
pkg_ensure "texinfo"
pkg_ensure "gawk"
pkg_ensure "chrpath"

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

echo "Ensure $USER in groups"
if user_not_in_group $USER dialout; then
  echo "Adding $USER to group: dialout"
  sudo usermod -a -G dialout $USER
  sudo usermod -a -G adm $USER
  sudo usermod -a -G dip $USER
  sudo usermod -a -G plugdev $USER
  sudo usermod -a -G netdev $USER
fi

echo ""
cowsay "All done!"
echo ""
echo "Setup complete. You're ready to build."
echo ""
