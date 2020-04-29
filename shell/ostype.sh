#!/usr/bin/env bash

## Version 1 with if
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "macOS in if"
elif [[ "$OSTYPE" == "msys"* ]]; then
  echo "windows in if"
elif [[ "$OSTYPE" == "linux"* ]]; then
  echo "linux in if"
elif [[ "$OSTYPE" == "solaris"* ]]; then
  echo "solaris in if"
elif [[ "$OSTYPE" == "bsd"* ]]; then
  echo "bsd in if"
fi

## Version 2 with case
case "$OSTYPE" in
  darwin*)
    echo "macOS in case"
    ;;
  msys*)
    echo "windows in case"
    ;;
  linux*)
    echo "linux in case"
    ;;
  solaris*)
    echo "solaris in case"
    ;;
  bsd*)
    echo "bsd in case"
    ;;
  *)
    echo "Unknown Operating system: $OSTYPE"
    exit 1
esac
