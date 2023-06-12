#!/bin/bash

COVER="/tmp/album_cover.png"
EMB_COVER="/tmp/emb_album_cover.png"
COVER_SIZE="300"

#path to current song
file="/home/me/backups/mosic/$(mpc --format %file% current)"
album="${file%/*}"
#search for cover image
art=$(find "$album"  -maxdepth 1 | grep -i -m 1 "\(cover\|folder\)\.\(jpg\|png\|gif\|bmp\|jpeg\)") # cover.png
if [ "$art" = "" ]; then
  # embedded cover
  art="$EMB_COVER"
  err=$(ffmpeg -loglevel 16 -y -an -i "$file" "$EMB_COVER")
  if [ "$err" != "" ]; then
    art="/home/me/.config/ncmpcpp/default_cover.jpg" # default
  fi
fi

#copy and resize image to destination
ffmpeg -loglevel 0 -y -i "$art" -vf "scale=-1:$COVER_SIZE" "$COVER"
