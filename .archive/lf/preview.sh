#!/bin/bash

bat-preview() {
    bat --color=always -p "$1"
}

comp-preview() {
    case "$1" in
        *.zip) unzip -l "$1" |awk '{print $4}';;
        *.rar) unrar lb "$1";;
    esac
}

audio-preview() {
    ffmpeg -i "$1" 2>&1 | grep Duration | tr ',' '\n' | sed 's/^\s*//' | sed '/^start/d'
}

case "$1" in
    *.zip) comp-preview "$1";;
    *.rar) comp-preview "$1";;
    *.tar*) ;;
    *.pdf) ;;
    *.srt) ;;
    *.png | *.jpg | *.JPG | *.jpeg | *.gif | *.webp) ;;
    *.mp4 | *.mkv) ;;
    *.mp3) audio-preview "$1" ;;
    *) bat-preview "$1";;
esac
