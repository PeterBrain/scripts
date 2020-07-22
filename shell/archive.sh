#!/usr/bin/env bash

# extracts archived files / mounts disk images.
extract () {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)  tar -jxvf "$1"                     ;;
            *.tar.gz)   tar -zxvf "$1"                     ;;
            *.bz2)      bunzip2 "$1"                       ;;
            *.dmg)      hdiutil mount "$1"                 ;;
            *.gz)       gunzip "$1"                        ;;
            *.tar)      tar -xvf "$1"                      ;;
            *.tbz2)     tar -jxvf "$1"                     ;;
            *.tgz)      tar -zxvf "$1"                     ;;
            *.zip)      unzip "$1"                         ;;
            *.ZIP)      unzip "$1"                         ;;
            *.pax)      pax -r < "$1"                      ;;
            *.pax.Z)    uncompress "$1" --stdout | pax -r  ;;
            *.rar)      unrar x "$1"                       ;;
            *.Z)        uncompress "$1"                    ;;
            *)          echo "'$1' cannot be extracted/mounted via extract()." ;;
        esac
    else
        echo "'$1' is not a valid file."
    fi
}

# compress all files inside a folder.
compress () {
    if [ -f "$1" ]; then
        case "$1" in
            *.zip)      zip -r -X "$1" "$2" ;;
            *.tar.gz)   tar -czvf "$1" "$2" ;;
            *)          echo "'$1' cannot be compressed via compress()." ;;
        esac
    else
        echo "'$1' is not a valid compressing format."
    fi
}