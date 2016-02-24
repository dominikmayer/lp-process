#!/bin/sh

VIDEOS=0
LIVE_PHOTOS=0
PHOTOS=0

FORMAT="%Y-%m-%d - %H-%M-%S"

echo
echo "Renaming Live Photos"
echo "===================="
echo

for FILE in IMG_*.MOV; do
  BASE=${FILE%.MOV}
  if [[ -e $BASE.MOV && -e $BASE.JPG ]]; then
    NAME=`jhead -n"$FORMAT" "$BASE.JPG"`
    echo "$NAME"

    # Rename video. Don't overwrite existing.
    NAME=${NAME#IMG_*.JPG --> }
    NAME=${NAME%.jpg}
    mv -n "$BASE.MOV" "$NAME.mov"

    LIVE_PHOTOS=$((LIVE_PHOTOS+1))
  fi
done

echo
echo "Renaming Videos"
echo "===================="
echo

for FILE in IMG_*.MOV; do
  if [[ $FILE != "IMG_*.MOV" ]]; then
    DATE=`stat -t "$FORMAT" -f "%Sm" "$FILE"`
    echo "$FILE --> $DATE.mov"
    mv -n "$FILE" "$DATE.mov"
    VIDEOS=$((VIDEOS+1))
  fi
done

echo
echo "Renaming Photos"
echo "===================="
echo

for FILE in IMG_*.JPG; do
  if [[ $FILE != "IMG_*.JPG" ]]; then
    #echo $(jhead -exonly -n"$FORMAT" "$FILE")
    PHOTOS=$((PHOTOS+1))
  fi
done

echo
echo "$LIVE_PHOTOS live photos"
echo "$PHOTOS photos"
echo "$VIDEOS videos"
