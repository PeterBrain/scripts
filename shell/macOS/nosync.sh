#!/bin/sh
# add .nosync extension and create a symbolic link to preserve original name

nosync () {
  mv "$1" "$1.nosync"
  ln -s "$1.nosync" "$1"
}

until [ -z "$1" ]
do
  nosync "$1"
  shift
done
