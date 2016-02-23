#!/bin/sh

VIDEOS=0
LIVE_PHOTOS=0

for FILE in IMG_*.MOV; do
  BASE=${FILE%.MOV}
  if [[ -e $BASE.MOV && -e $BASE.JPG ]]; then
    echo "Live Photo: $BASE"
    NAME=`jhead -n"%Y-%m-%d - %H-%M-%S" "$BASE.JPG"`
    echo "New Name: $NAME"
    NAME=${NAME#IMG_*.JPG --> }
    echo "New Name: $NAME"
    NAME=${NAME%.jpg}
    echo "New Name: $NAME"
    LIVE_PHOTOS=$((LIVE_PHOTOS+1))
  fi
done

for FILE in IMG_*.MOV; do
    VIDEOS=$((VIDEOS+1))
done


echo "$VIDEOS videos"
echo "$LIVE_PHOTOS live photos"
