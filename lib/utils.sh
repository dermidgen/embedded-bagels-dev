#!/bin/bash

##
# Helper functions
##

pkg_check ()
{
  echo "Checking for pkg: $1"
  PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $1|grep "install ok installed")
  if [ "" == "$PKG_OK" ]; then
    echo "  ... found."
    return 0
  fi
  return 1
}

pkg_install ()
{
  echo "$1 not found. Setting up $1."
  sudo apt-get --force-yes --yes install $1
}

pkg_ensure ()
{
  if pkg_check "$1"; then
    pkg_install "$1"
  fi
}

path_ensure ()
{
  echo "Checking for path: $1"
  if [ ! -d $1 ]; then
    echo "Creating missing path: $1"
    mkdir -p $1
  fi
}

resource_ensure ()
{
  echo "Checking for resource: $1"
  if [ ! -f $1 ]; then
    echo "Downloading missing resource: $1 => $2"
    curl -o $1 $2
  fi
}
