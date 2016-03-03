#!/bin/bash

for SRC in `find . -type f -depth -iname "*md"`
do
    DIR=`dirname "${SRC}"`
    landslide -i $SRC -d $DIR/$DIR.html 
done
