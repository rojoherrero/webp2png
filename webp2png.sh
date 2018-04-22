#!/bin/bash

ORIGIN=''
TARGET=''
NAME=''

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -o|--origin)
    ORIGIN="$2"
    shift # past argument
    shift # past value
    ;;
    -t|--target)
    TARGET="$2"
    shift # past argument
    shift # past value
    ;;
    -n|--name)
    NAME="$2"
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

if [ -d "$TARGET" ]; then
    echo "Removing target folder"
    rm -rf $TARGET
fi

TEMP=$PWD"/temp"

mkdir $TEMP

mkdir $TARGET
COUNTER=0

for f in "$ORIGIN"*; do
    dwebp $f -o $TEMP"/"$NAME"_"$COUNTER.png
    COUNTER=$((COUNTER + 1)) 
done

echo "all pics decoded"
echo "moving to target folder"

for f in "$TEMP"/*; do
    cp $f $TARGET
    rm $f
done

rm -rf $TEMP







