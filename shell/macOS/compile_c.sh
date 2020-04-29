#!/usr/bin/env bash

printf "\nCompile C files\n\n"
read -rp "Path to C file: " FILE
read -rp "Name the output file: " NAME

FILENAME=${FILE##*/}
FILEPATH=${FILE%/*}
NOEXT=${FILENAME%\.*}
EXT=${FILE##*.}

cd "${FILEPATH}" || exit

gcc -o "${NAME}" "${FILE}" -framework IOKit -framework ApplicationServices -framework CoreFoundation
