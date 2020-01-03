#!/bin/bash                                                                     

file=$(head -n 1 ~/arpirobot/main.txt)
PYTHONPATH=~/arpirobot python3 -u ~/arpirobot/$file > /tmp/arpirobot_program.log 2>&1

exit 0