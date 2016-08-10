#!/bin/sh

echo
echo "Compile C files"
echo
echo "Path to c file"
read FILE
echo
echo "Name the output file"
read NAME
echo

FILENAME=${FILE##*/}
FILEPATH=${FILE%/*}
NOEXT=${FILENAME%\.*}
EXT=${FILE##*.}

cd "$FILEPATH"

gcc -o "$NAME" "$FILE" -framework IOKit -framework ApplicationServices -framework CoreFoundation

echo
echo "Done"
echo

read