#!/bin/bash

echo "Startup CapScript.sh was run at $(date)"
echo "Execuating command: 'xhost +local:root > /dev/null 2>&1'"
# xhost +local:root > /dev/null 2>&1
# xhost +
export XAUTHORITY=/home/ww/.Xauthority
echo "The XAUTHORITY variable has the value: $XAUTHORITY"
echo "Execuating command: 'xkbcomp -w 0 /home/ww/WW/Misc/CapNoDelay/xkbmap $DISPLAY'"
xkbcomp -w 0 /home/ww/WW/Misc/CapNoDelay/xkbmap $DISPLAY 2>&1
# xkbcomp -w 0 /home/ww/WW/Misc/CapNoDelay/xkbmap localhost:0 2>&1
