#!/bin/sh

VIDEOS=0
LIVE_PHOTOS=0
PHOTOS=0

echo
echo "Renaming Live Photos"
echo "===================="
echo

for FILE in IMG_*.MOV; do
  BASE=${FILE%.MOV}
  if [[ -e $BASE.MOV && -e $BASE.JPG ]]; then
    NAME=`jhead -n"%Y-%m-%d - %H-%M-%S" "$BASE.JPG"`
    echo "$NAME"

    # Rename video. Don't overwrite existing.
    NAME=${NAME#IMG_*.JPG --> }
    NAME=${NAME%.jpg}
    mv -n "$BASE.MOV" "$NAME.mov"

    LIVE_PHOTOS=$((LIVE_PHOTOS+1))
  fi
done

for FILE in IMG_*.MOV; do
    VIDEOS=$((VIDEOS+1))
done

for FILE in IMG_*.JPG; do
    PHOTOS=$((PHOTOS+1))
done

echo
echo "$LIVE_PHOTOS live photos"
echo "$PHOTOS photos"
echo "$VIDEOS videos"
