#!/bin/sh

echo
echo "Make a dummy file with one or several bytes (b), kilobytes (k), megabytes (m), gigabytes (g)"
echo

echo "Type in a filesize (1 Gigabyte = 1g)"
read filesize

echo "Name the File:"
read name

echo "Give it an extension"
read extension

echo "Choose a storage directory (leave blank for desktop)"
read path

if [ -n $path ]; then
cd Desktop
else
cd $path
fi

mkfile $filesize $name.$extension
#mkfile 1g test.abc