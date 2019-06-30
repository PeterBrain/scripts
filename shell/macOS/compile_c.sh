#!/bin/sh

printf "\nCompile C files\n\n"
read -p "Path to C file: " FILE
read -p "Name the output file: " NAME

FILENAME=${FILE##*/}
FILEPATH=${FILE%/*}
NOEXT=${FILENAME%\.*}
EXT=${FILE##*.}

cd "$FILEPATH"

gcc -o "$NAME" "$FILE" -framework IOKit -framework ApplicationServices -framework CoreFoundation
