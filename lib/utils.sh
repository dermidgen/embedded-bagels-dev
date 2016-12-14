#!/bin/bash

##
# Helper functions
##

user_in_group()
{
  groups $1 | grep -q "\b$2\b"
}

user_not_in_group()
{
  ! user_in_group $1 $2
}

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
  sudo apt-get -y -f install $1
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

repo_ensure ()
{
  echo "Checking for repo: $1"
  if [ ! -d $1 ]; then
    echo "Cloning repo: $2 at branch $3 to $1"
    git clone $2 -b $3 $1
  fi
}

repo_sync ()
{
  echo "Syncing repo:\n\tpath: $1\n\turi: $2\n\tbranch: $3"
  repo_ensure $1 $2 $3
  pushd $1
  git fetch --all --prune && git pull origin $3
  popd
}

repo_tool_ensure ()
{
  echo "Checking for repo tool"
  if [ ! -f "$HOME/bin/repo" ]; then
    echo "Installing repo tool to $REPO_PATH"
    mkdir -p "$HOME/bin"
    curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > $HOME/bin/repo
    chmod a+x $HOME/bin/repo
    echo "Installed repo tool to $HOME/bin/repo; update $HOME/.bashrc to automatically add $HOME/bin to \$PATH"
  else
    echo "  ... found repo tool: $REPO_PATH"
  fi
}
