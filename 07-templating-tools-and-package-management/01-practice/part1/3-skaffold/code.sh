#!/bin/sh

GREETING="Hello Awesome World!"
STEP=2

echo "Printing \"$GREETING\" every $STEP second(s) ..."

while true; do echo $GREETING; sleep $STEP; done