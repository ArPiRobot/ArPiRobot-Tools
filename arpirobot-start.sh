#!/bin/bash

file=$(head -n 1 ~/arpirobot/main.txt)
python3 $file > ~/arpirobot_program.log

exit 0
