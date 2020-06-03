#!/bin/bash

MAIN_SCRIPT=~/arpirobot/main.sh
MAIN_TXT=~/arpirobot/main.txt

if [ -f "$MAIN_SCRIPT" ]; then
    dos2unix "$MAIN_SCRIPT"
    chmod +x "$MAIN_SCRIPT"
    "$MAIN_SCRIPT" > /tmp/arpirobot_program.log 2>&1
else
    # Fallback to old method if no main.sh script
    # main.txt would have a single line with the name of a python script to invoke
    file=$(head -n 1 $MAIN_TXT)
    PYTHONPATH=~/arpirobot python3 -u ~/arpirobot/$file > /tmp/arpirobot_program.log 2>&1
fi

exit 0
